class Worksheet
  include Utilities

  attr_accessor :name
  attr_accessor :parent
  attr_accessor :rows
  attr_accessor :cols
  attr_accessor :merged_ranges
  attr_accessor :bmp_rec
  attr_accessor :show_formulas
  attr_accessor :show_grid
  attr_accessor :show_headers
  attr_accessor :panes_frozen
  attr_accessor :show_empty_as_zero
  attr_accessor :auto_colour_grid
  attr_accessor :cols_right_to_left
  attr_accessor :show_outline
  attr_accessor :remove_splits
  attr_accessor :selected
  # RED HERRING ALERT: "sheet_visible" is a clone of the "selected" attribute.
  # Typically a workbook created by the Excel UI will have one sheet
  # (the sheet that was selected when the user saved it)
  # with both bits set to 1, and all other sheets will have both 
  # bits set to 0. The true visibility of the sheet is found in the "visibility" 
  # attribute obtained from the BOUNDSHEET record.
  attr_accessor :sheet_visible
  attr_accessor :page_preview
  attr_accessor :first_visible_row
  attr_accessor :first_visible_col
  attr_accessor :grid_colour
  attr_accessor :preview_magn
  attr_accessor :normal_magn
  attr_accessor :visibility
  attr_accessor :vert_split_pos
  attr_accessor :horz_split_pos
  attr_accessor :vert_split_first_visible
  attr_accessor :horz_split_first_visible
  
  attr_accessor :delta
  attr_accessor :save_recalc
  attr_accessor :formula_options
  attr_accessor :print_headers
  attr_accessor :print_grid
  attr_accessor :grid_set
  attr_accessor :vert_page_breaks
  attr_accessor :horz_page_breaks
  attr_accessor :header_str
  attr_accessor :footer_str
  attr_accessor :print_centered_vert
  attr_accessor :print_centered_horz
  attr_accessor :left_margin
  attr_accessor :right_margin
  attr_accessor :top_margin
  attr_accessor :bottom_margin
  attr_accessor :paper_size_code
  attr_accessor :print_scaling
  attr_accessor :start_page_number
  attr_accessor :fit_width_to_pages
  attr_accessor :fit_height_to_pages
  attr_accessor :print_in_rows
  attr_accessor :portrait
  attr_accessor :print_not_colour
  attr_accessor :print_draft
  attr_accessor :print_notes
  attr_accessor :print_notes_at_end
  attr_accessor :print_omit_errors
  attr_accessor :print_hres
  attr_accessor :print_vres
  attr_accessor :header_margin
  attr_accessor :footer_margin
  attr_accessor :copies_num

  attr_accessor :show_auto_page_breaks
  attr_accessor :dialogue_sheet
  attr_accessor :auto_style_outline
  attr_accessor :outline_below
  attr_accessor :outline_right
  attr_accessor :fit_num_pages
  attr_accessor :show_row_outline
  attr_accessor :show_col_outline
  attr_accessor :alt_expr_eval
  attr_accessor :alt_formula_entries
  
  attr_accessor :col_default_width
  attr_reader   :calc_mode
  attr_accessor :calc_count
  
  attr_accessor :protect
  attr_accessor :wnd_protect
  attr_accessor :obj_protect
  attr_accessor :scen_protect
  attr_accessor :password
  
  def initialize(name, parent)
    @name = name
    @parent = parent
    @rows = {}
    @cols = {}
    @merged_ranges = []
    @bmp_rec = ''
    @show_formulas = 0
    @show_grid = 1
    @show_headers = 1
    @panes_frozen = 0
    @show_empty_as_zero = 1
    @auto_colour_grid = 1
    @cols_right_to_left = 0
    @show_outline = 1
    @remove_splits = 0
    @selected = 0
    @sheet_visible = 0
    @page_preview = 0
    
    @first_visible_row = 0
    @first_visible_col = 0
    @grid_colour = 0x40
    @preview_magn = 0
    @normal_magn = 0
    @visibility = 0

    @vert_split_pos = nil
    @horz_split_pos = nil
    @vert_split_first_visible = nil
    @horz_split_first_visible = nil
    @split_active_pane = nil # TODO test implications of converting None -> Nil

    @row_gut_width = 0
    @col_gut_height = 0

    @show_auto_page_breaks = 1
    @dialogue_sheet = 0
    @auto_style_outline = 0
    @outline_below = 0
    @outline_right = 0
    @fit_num_pages = 0
    @show_row_outline = 1
    @show_col_outline = 1
    @alt_expr_eval = 0
    @alt_formula_entries = 0

    @row_default_height = 0x00FF
    @col_default_width = 0x0008
    
    @default_row_height_mismatch = 0
    @default_row_hidden = 0
    @default_row_space_above = 0
    @default_row_space_below = 0

    @calc_mode = 1
    @calc_count = 0x0064
    @rc_ref_mode = 1
    @iterations_on = 0
    @delta = 0.001
    @save_recalc = 0
    @formula_options = Formula::RECALC_ALWAYS | Formula::CALC_ON_OPEN

    @print_headers = 0
    @print_grid = 0
    @grid_set = 1
    @vert_page_breaks = []
    @horz_page_breaks = []
    @header_str = '&P'
    @footer_str = '&F'
    @print_centered_vert = 0
    @print_centered_horz = 1
    @left_margin = 0.3 #0.5
    @right_margin = 0.3 #0.5
    @top_margin = 0.61 #1.0
    @bottom_margin = 0.37 #1.0
    @paper_size_code = 9 # A4
    @print_scaling = 100
    @start_page_number = 1
    @fit_width_to_pages = 1
    @fit_height_to_pages = 1
    @print_in_rows = 1
    @portrait = 1
    @print_not_colour = 0
    @print_draft = 0
    @print_notes = 0
    @print_notes_at_end = 0
    @print_omit_errors = 0
    @print_hres = 0x012C # 300 dpi
    @print_vres = 0x012C # 300 dpi
    @header_margin = 0.1
    @footer_margin = 0.1
    @copies_num = 1

    @wnd_protect = 0
    @obj_protect = 0
    @protect = 0
    @scen_protect = 0
    @password = ''
    
    @charts = []
  end
  
  # Accessors Performing Conversions
  def row_default_height
    twips_to_pixels(@row_default_height)
  end
  
  def row_default_height=(pixels)
    @row_default_height = pixels_to_twips(pixels)
  end
  
  def calc_mode=(value)
    @calc_mode = (value == 0xFFFF && value) || value & 0x01
  end
  
  def set_cell_style(r, c, style, create_blanks = false)
    cell = rows[r].cell(c)
    if cell.nil?
      write(r, c, nil, style) if create_blanks
    else
      cell.set_style(style)
    end
  end
  
  def hide_columns(col_range)
    col_range.each do |c|
      hide_column(c)
    end
  end
  
  def unhide_columns(col_range)
    col_range.each do |c|
      unhide_column(c)
    end
  end
  
  def set_column_widths(col_range, width)
    col_range.each do |c|
      set_column_width(c, width)
    end
  end
  
  def hide_column(c)
    col(c).hidden = true
  end

  def unhide_column(c)
    col(c).hidden = false
  end
  
  # TODO fix this if column doesn't exist yet.
  def set_column_width(c, width)
    if width < 100
      # Assume we are trying to use Excel-user style widths, scale up accordingly.
      # You can call col's width method directly to avoid this.
      width = width * 260
    end
    col(c).width = width
  end
  
  # Change the style for a range of cells. If nil is supplied for row_range,
  # the new style is supplied to every row (i.e. the entire column). Only
  # changes style for cells which actually exist, so this does not paint 
  # anything which has not been written to.
  def set_range_style(row_range, col_range, style, create_blanks = false)
    row_range ||= 0..65535
    col_range ||= 0..255
    
    @rows.each do |i, r|
      next unless row_range.include?(i)
      r.cells.each do |c|
        next unless col_range.include?(c.col)
        c.set_style(style)
      end
    end
  end

# TODO get rid of meaningless default value for label, should be required?
### @export "write-method"
  def write(r, c, label = "", style = nil)
    if label.is_a?(Array)
      if label[0].is_a?(Array)
        write_arrays(r, c, label, style || true)
      else
        write_array_to_row(label, r, c, style || true)
      end
    else
      row(r).write(c, label, style)
    end
  end

### @export "write-arrays"
  def write_array_to_row(array, r, c = 0, style = true)
    array.each_with_index do |a, i|
      row(r).write(c + i, a, style)
    end
  end

  def write_array_to_column(array, c, r = 0, style = true)
    array.each_with_index do |a, i|
      row(r + i).write(c, a, style)
    end
  end
  
  def write_arrays(r, c, array_of_arrays, style = true)
    array_of_arrays.each_with_index do |a, i|
      raise "not an array of arrays!" unless a.is_a?(Array)
      write_array_to_row(a, r + i, c, style)
    end
  end
### @end
  
  # Comment from xlwt:
  ## Stand-alone merge of previously written cells.
  ## Problems: (1) style to be used should be existing style of
  ## the top-left cell, not an arg.
  ## (2) should ensure that any previous data value in
  ## non-top-left cells is nobbled.
  ## Note: if a cell is set by a data record then later
  ## is referenced by a [MUL]BLANK record, Excel will blank
  ## out the cell on the screen, but OOo & Gnu will not
  ## blank it out. Need to do something better than writing
  ## multiple records. In the meantime, avoid this method and use
  ## write_merge() instead.
  def merge(r1, r2, c1, c2, style = @parent.styles.default_style)
    row(r1).write_blanks(c1 + 1, c2, style) if c2 > c1
    ((r1+1)...(r2+1)).each do |r|
      row(r).write_blanks(c1, c2, style)
    end
    @merged_ranges << [r1, r2, c1, c2]
  end
  
  def write_merge(r1, r2, c1, c2, label="", style = @parent.styles.default_style)
    write(r1, c1,  label, style)
    merge(r1, r2, c1, c2, style)
  end
  
  ### @export "to-biff"
  def to_biff
    result = []
    result << Biff8BOFRecord.new(Biff8BOFRecord::WORKSHEET).to_biff
    # Calc Settings
    result << CalcModeRecord.new(@calc_mode).to_biff
    result << CalcCountRecord.new(@calc_count & 0xFFFF).to_biff
    result << RefModeRecord.new(@rc_ref_mode & 0x01).to_biff
    result << IterationRecord.new(@iterations_on & 0x01).to_biff
    result << DeltaRecord.new(@delta).to_biff
    result << SaveRecalcRecord.new(@save_recalc & 0x01).to_biff
    
    result << guts_record
    result << default_row_height_record
    result << wsbool_record
    result << @cols.sort.collect {|k, v| v.to_biff }.join
    result << dimensions_rec
    ### @end
    
    # Print Settings
    result << PrintHeadersRecord.new(@print_headers).to_biff
    result << PrintGridLinesRecord.new(@print_grid).to_biff
    result << GridSetRecord.new(@grid_set).to_biff
    result << HorizontalPageBreaksRecord.new(@horz_page_breaks.collect {|b| b.is_a?(Integer) ? [b, 0, -1] : b }).to_biff
    result << VerticalPageBreaksRecord.new(@vert_page_breaks.collect {|b| b.is_a?(Integer) ? [b, 0, -1] : b }).to_biff
    result << HeaderRecord.new(@header_str).to_biff
    result << FooterRecord.new(@footer_str).to_biff
    result << HCenterRecord.new(@print_centered_horz).to_biff
    result << VCenterRecord.new(@print_centered_vert).to_biff
    result << LeftMarginRecord.new(@left_margin).to_biff
    result << RightMarginRecord.new(@right_margin).to_biff
    result << TopMarginRecord.new(@top_margin).to_biff
    result << BottomMarginRecord.new(@bottom_margin).to_biff
    result << setup_page_record
    
    # Protection Settings
    result << ProtectRecord.new(as_numeric(@protect)).to_biff()
    result << ScenarioProtectRecord.new(as_numeric(@scen_protect)).to_biff()
    result << WindowProtectRecord.new(as_numeric(@wnd_protect)).to_biff()
    result << ObjectProtectRecord.new(as_numeric(@obj_protect)).to_biff()
    result << PasswordRecord.new(@password).to_biff()
    
    ### @export "to-biff-rows"
    keys = @rows.keys.sort
    keys.each do |i|
      result << @rows[i].to_biff
      result << @rows[i].cells_biff
    end
    ### @end
    
    # @charts.each do |c|
    #   result << c.to_biff
    # end
    result << MergedCellsRecord.new(@merged_ranges).to_biff
    result << @bmp_rec
    result << window_2_record
    result << panes_record
    # result << hyperlink_table_record
    result << EOFRecord.new.to_biff
    
    result.join
  end
  
  def guts_record
    max_row_level = @rows.values.inject(-1) {|level, row|  row.level > level ? row.level : level }
    max_col_level = @cols.values.inject(-1) {|level, col| col.level > level ? col.level : level }
    
    row_visible_levels = @rows.empty? ? 0 : max_row_level + 1
    col_visible_levels = @cols.empty? ? 0 : max_col_level + 1
    
    GutsRecord.new(@row_gut_width, @col_gut_height, row_visible_levels, col_visible_levels).to_biff
  end
  
  def default_row_height_record
    options = 0x00
    options |= (@default_row_height_mismatch & 0x01) << 0
    options |= (@default_row_hidden & 0x01) << 1
    options |= (@default_row_space_above & 0x01) << 2
    options |= (@default_row_space_below & 0x01) << 3
    
    DefaultRowHeight.new(options, @row_default_height).to_biff
  end
  
  def wsbool_record
    options = 0x00
    options |= (@show_auto_page_breaks & 0x01) << 0
    options |= (@dialogue_sheet & 0x01) << 4
    options |= (@auto_style_outline & 0x01) << 5
    options |= (@outline_below & 0x01) << 6
    options |= (@outline_right & 0x01) << 7
    options |= (@fit_num_pages & 0x01) << 8
    options |= (@show_row_outline & 0x01) << 10
    options |= (@show_col_outline & 0x01) << 11
    options |= (@alt_expr_eval & 0x01) << 14
    options |= (@alt_formula_entries & 0x01) << 15

    WSBoolRecord.new(options).to_biff
  end
  
  def dimensions_rec
    first_used_row = 0
    last_used_row = 0
    first_used_col = 0
    last_used_col = 0
    
    if !@rows.empty?
      first_used_row = @rows.keys.sort.first
      last_used_row = @rows.keys.sort.last
      first_used_col = 0xFFFFFFFF
      last_used_col = 0
    end
    
    first_used_col = @rows.values.inject(first_used_col) {|min_col, r| r.min_col_index < min_col ? min_col = r.min_col_index : min_col }
    last_used_col = @rows.values.inject(last_used_col) {|max_col, r| r.max_col_index > max_col ? max_col = r.max_col_index : max_col }

    DimensionsRecord.new(first_used_row, last_used_row, first_used_col, last_used_col).to_biff
  end
  
  def setup_page_record
    setup_page_options =  (@print_in_rows & 0x01) << 0
    setup_page_options |=  (@portrait & 0x01) << 1
    setup_page_options |=  (0x00 & 0x01) << 2
    setup_page_options |=  (@print_not_colour & 0x01) << 3
    setup_page_options |=  (@print_draft & 0x01) << 4
    setup_page_options |=  (@print_notes & 0x01) << 5
    setup_page_options |=  (0x00 & 0x01) << 6
    setup_page_options |=  (0x01 & 0x01) << 7
    setup_page_options |=  (@print_notes_at_end & 0x01) << 9
    setup_page_options |=  (@print_omit_errors & 0x03) << 10

    args = [
      @paper_size_code,
      @print_scaling,
      @start_page_number,
      @fit_width_to_pages,
      @fit_height_to_pages,
      setup_page_options,
      @print_hres,
      @print_vres,
      @header_margin,
      @footer_margin,
      @copies_num
    ]
    SetupPageRecord.new(*args).to_biff
  end
  
  def window_2_record
    options = 0
    options |= (as_numeric(@show_formulas       ) & 0x01) << 0
    options |= (as_numeric(@show_grid           ) & 0x01) << 1
    options |= (as_numeric(@show_headers        ) & 0x01) << 2
    options |= (as_numeric(@panes_frozen        ) & 0x01) << 3
    options |= (as_numeric(@show_empty_as_zero  ) & 0x01) << 4
    options |= (as_numeric(@auto_colour_grid    ) & 0x01) << 5
    options |= (as_numeric(@cols_right_to_left  ) & 0x01) << 6
    options |= (as_numeric(@show_outline        ) & 0x01) << 7
    options |= (as_numeric(@remove_splits       ) & 0x01) << 8
    options |= (as_numeric(@selected            ) & 0x01) << 9
    options |= (as_numeric(@sheet_visible       ) & 0x01) << 10
    options |= (as_numeric(@page_preview        ) & 0x01) << 11

    if @page_preview != 0
      if @preview_magn == 0
        scl_magn = 60
      else
        scl_magn = @preview_magn
      end
    else
      scl_magn = @normal_magn
    end
    
    Window2Record.new(options, @first_visible_row, @first_visible_col, @grid_colour, @preview_magn, @normal_magn, scl_magn).to_biff
  end
  
  def panes_record
    return '' if @vert_split_pos.nil? && @horz_split_pos.nil?
    @vert_split_pos = 0 if @vert_split_pos.nil?
    @horz_split_pos = 0 if @horz_split_pos.nil?
    if @panes_frozen
      @vert_split_first_visible = @vert_split_pos if @vert_split_first_visible.nil?
      @horz_split_first_visible = @horz_split_pos if @horz_split_first_visible.nil?
    else
      @vert_split_first_visible = 0 if @vert_split_first_visible.nil?
      @horz_split_first_visible = 0 if @horz_split_first_visible.nil?
      # inspired by pyXLWriter
      @horz_split_pos = 20 * @horz_split_pos + 255
      @vert_split_pos = 113.879 * @vert_split_pos + 390
    end
    @split_active_pane = 0 if @vert_split_pos > 0 and @horz_split_pos > 0
    @split_active_pane = 1 if @vert_split_pos < 0 and @horz_split_pos == 0
    @split_active_pane = 2 if @vert_split_pos == 0 and @horz_split_pos > 0
    @split_active_pane = 3

    args = [@vert_split_pos, @horz_split_pos, @horz_split_first_visible, @vert_split_first_visible, @split_active_pane]
    PanesRecord.new(*args).to_biff
  end
  
  def hyperlink_table_record
    result = ''
    return result if @links.nil?
    @links.each do |a, b|
      x, y = a
      url, target, textmark, description = b
      result += HyperlinkRecord.new(x, x, y, y, url, target, textmark, description).to_biff
      result += QuicktipRecord(x, x, y, y).to_biff unless description.nil?
    end
    result
  end
  
  # Fetch the row indicated by index, or create it if necessary.
  def row(index)
    rows[index] ||= Row.new(index, self)
  end
  
  # Fetch the col indicated by index, or create it if necessary.
  def col(index)
    cols[index] ||= Column.new(index, self)
  end
  alias :column :col
  
  def row_height(row)
    if @rows.include?(row)
      @rows[row].height_in_pixels
    else
      17
    end
  end
  
  def col_width(column_index)
    if cols.keys.include?(column_index)
      cols[column_index].width_in_pixels
    else
      64
    end
  end

  def insert_bitmap(filename, row, col, x = 0, y = 0, scale_x = 1, scale_y = 1)
    bmp = ImDataBmpRecord.new(filename)
    obj = ObjBmpRecord.new(row, col, self, bmp, x, y, scale_x, scale_y)

    @bmp_rec += obj.to_biff + bmp.to_biff
  end
end
