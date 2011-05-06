class Row
  attr_accessor :index
  attr_accessor :parent
  attr_accessor :parent_wb
  attr_accessor :cells
  attr_accessor :min_col_index
  attr_accessor :max_col_index
  attr_accessor :total_str
  attr_accessor :xf_index
  attr_accessor :has_default_format
  attr_accessor :height_in_pixels
  
  attr_accessor :height
  attr_accessor :has_default_height
  attr_accessor :height_mismatch
  attr_accessor :level
  attr_accessor :collapse
  attr_accessor :hidden
  attr_accessor :space_above
  attr_accessor :space_below

  def initialize(index, parent_sheet)
    is_int = index.is_a?(Integer)
    in_range = (index >= 0) && (index <= 65535)
    raise "row index #{index} is not valid" unless is_int && in_range
    
    @index = index
    @parent = parent_sheet
    @parent_wb = parent_sheet.parent()
    @cells = []
    @min_col_index = 0
    @max_col_index = 0
    @total_str = 0
    @xf_index = 0x0F
    @has_default_format = 0
    @height_in_pixels = 0x11
    
    @height = 0x00FF
    @has_default_height = 0x00
    @height_mismatch = 0
    @level = 0
    @collapse = 0
    @hidden = 0
    @space_above = 0
    @space_below = 0
  end
  
  def adjust_height(style)
    twips = style.font.height
    points = twips/20.0
    # Cell height in pixels can be calcuted by following approx. formula:
    # cell height in pixels = font height in points * 83/50 + 2/5
    # It works when screen resolution is 96 dpi 
    pix = (points*83.0/50.0 + 2.0/5.0).round
    @height_in_pixels = pix if (pix > @height_in_pixels)
  end

  def set_height(height)
    @height = height * 20 #This seems to correspond to row height in excel.
    @height_mismatch = 1
  end
  
  def adjust_boundary_column_indexes(*args)
    args.each do |a|
      is_int = (a.to_i == a)
      in_range = (0 <= a) && (a <= 255)
      raise "invalid boundary index #{a}" unless is_int && in_range
      @min_col_index = a if a < @min_col_index
      @max_col_index = a if a > @max_col_index
    end
  end
  
  # TODO can we get rid of this? Tests pass if it is commented out.
  def style=(style)
    adjust_height(style)
    @xf_index = @parent_wb.styles.add(style)
    @has_default_format = 1
  end
  
  def cells_count
    @cells.length
  end
 
  ### @export "to-biff"
  def to_biff
    height_options = (@height & 0x07FFF)
    height_options |= (@has_default_height & 0x01) << 15
    
    options =  (@level & 0x07) << 0
    options |= (@collapse & 0x01) << 4
    options |= (@hidden & 0x01) << 5
    options |= (@height_mismatch & 0x01) << 6
    options |= (@has_default_format & 0x01) << 7
    options |= (0x01 & 0x01) << 8
    options |= (@xf_index & 0x0FFF) << 16
    options |= (@space_above & 0x01) << 28
    options |= (@space_below & 0x01) << 29

    args = [@index, @min_col_index, @max_col_index, height_options, options]
    RowRecord.new(*args).to_biff
  end
  
  def cells_biff
    cells.collect {|c| c.to_biff }.join
  end
  ### @end
  
  def cell(col_index)
    cells.select {|c| c.index == col_index}.first
  end
  
  def write(col, label, style)
    case style
    when StyleFormat
      # leave it alone
    when Hash
      style = StyleFormat.new(style)
### @export "autoformats"
    when TrueClass # Automatically apply a nice numeric format.
      case label
      when DateTime, Time
        style = @parent_wb.styles.default_datetime_style
      when Date
        style = @parent_wb.styles.default_date_style
      when Float
        style = @parent_wb.styles.default_float_style
      else
        style = @parent_wb.styles.default_style
      end
### @end
    when NilClass
      style = @parent_wb.styles.default_style
    else
      raise "I don't know how to use this to format a cell #{style.inspect}"
    end

    style_index = @parent_wb.styles.add(style)

    raise "trying to write to cell #{self.index}, #{col} - already exists!" if cell(col)
    
    adjust_height(style)
    adjust_boundary_column_indexes(col)

    ### @export "label-classes"
    case label
    when TrueClass, FalseClass
      @cells << BooleanCell.new(self, col, style_index, label)
    when String, NilClass
      if label.to_s.length == 0
        @cells << BlankCell.new(self, col, style_index)
      else
        @cells << StringCell.new(self, col, style_index, @parent_wb.sst.add_str(label))
        @total_str += 1
      end
    when Numeric
      @cells << NumberCell.new(self, col, style_index, label)
    when Date, DateTime, Time
      @cells << NumberCell.new(self, col, style_index, as_excel_date(label))
    when Formula
      @cells << FormulaCell.new(self, col, style_index, label)
    else
      raise "You are trying to write an object of class #{label.class.name} to a spreadsheet. Please convert this to a supported class such as String."
    end
    ### @end
  end
  
  def write_blanks(c1, c2, style)
    raise unless c1 <= c2
    adjust_height(style)
    adjust_boundary_column_indexes(c1, c2)
    @cells << MulBlankCell.new(self, c1, c2, @parent_wb.styles.add(style))
  end
end
