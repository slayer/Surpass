class StyleFormat
  attr_accessor :number_format_string
  attr_accessor :font
  attr_accessor :alignment
  attr_accessor :borders
  attr_accessor :pattern
  attr_accessor :protection
  
  def initialize(hash = {})
    @number_format_string = hash[:number_format_string] || 'General'

    @font           = Font.new(hash_select(hash, /^font_/))
    @alignment      = Alignment.new(hash_select(hash, /^text_/))
    @borders        = Borders.new(hash_select(hash, /^border_/))
    @pattern        = Pattern.new(hash_select(hash, /^(fill|pattern)_/))
    @protection     = Protection.new
  end
  
  def hash_select(hash, pattern)
    new_hash = {}
    hash.keys.each do |k|
      next unless k.to_s =~ pattern
      new_key = k.to_s.gsub(pattern, '').to_sym
      new_hash[new_key] = hash[k]
    end
    new_hash
  end
end

class StyleCollection
  attr_accessor :fonts
  attr_accessor :number_formats
  attr_accessor :styles
  attr_accessor :default_style
  attr_accessor :default_format
  
  FIRST_USER_DEFINED_NUM_FORMAT_INDEX = 164
  
  STANDARD_NUMBER_FORMATS = [
    'General',
    '0',
    '0.00',
    '#,##0',
    '#,##0.00',
    '"$"#,##0_);("$"#,##',
    '"$"#,##0_);[Red]("$"#,##',
    '"$"#,##0.00_);("$"#,##',
    '"$"#,##0.00_);[Red]("$"#,##',
    '0%',
    '0.00%',
    '0.00E+00',
    '# ?/?',
    '# ??/??',
    'M/D/YY',
    'D-MMM-YY',
    'D-MMM',
    'MMM-YY',
    'h:mm AM/PM',
    'h:mm:ss AM/PM',
    'h:mm',
    'h:mm:ss',
    'M/D/YY h:mm',
    '_(#,##0_);(#,##0)',
    '_(#,##0_);[Red](#,##0)',
    '_(#,##0.00_);(#,##0.00)',
    '_(#,##0.00_);[Red](#,##0.00)',
    '_("$"* #,##0_);_("$"* (#,##0);_("$"* "-"_);_(@_)',
    '_(* #,##0_);_(* (#,##0);_(* "-"_);_(@_)',
    '_("$"* #,##0.00_);_("$"* (#,##0.00);_("$"* "-"??_);_(@_)',
    '_(* #,##0.00_);_(* (#,##0.00);_(* "-"??_);_(@_)',
    'mm:ss',
    '[h]:mm:ss',
    'mm:ss.0',
    '##0.0E+0',
    '@'   
  ]
  
  def initialize
    # Populate default font list.
    @fonts = {}
    # Initialize blank fonts into slots 0,1,2,3,5 in order to skip slot 4.
    [0,1,2,3,5].each do |i|
      @fonts[i] = Font.new
    end
    
    # Populate default number format list.
    @number_formats = {}
    STANDARD_NUMBER_FORMATS.each_with_index do |s, i|
      index = (i <= 23) ? i : i + 14
      @number_formats[index] = s
    end
    
    @styles = {}
    @default_style = StyleFormat.new
    
    # Store the 6 parameters of the default_style
    @default_format = add_style(@default_style)[0]
  end
  
### @export "autoformats"
  def default_date_style
    @default_date_style ||= StyleFormat.new(:number_format_string => 'dd-mmm-yyyy')
  end

  def default_datetime_style
    @default_datetime_style ||= StyleFormat.new(:number_format_string => 'dd-mmm-yyyy hh:mm:ss')
  end

  def default_float_style
    @default_float_style ||= StyleFormat.new(:number_format_string => '#,##0.00')
  end
### @end

  def add(style)
    if style.nil?
      0x10 # Return the index of the default style.
    else
      # TODO find way to freeze style so if someone modifies a StyleFormat instance it won't affect previously formatted cells.
      add_style(style)[1] # Return the index of the style just stored.
    end
  end
  
  def number_format_index(number_format_string)
    index = @number_formats.index(number_format_string)
    if index.nil?
      # TODO implement regex to check if valid string
      index = FIRST_USER_DEFINED_NUM_FORMAT_INDEX + @number_formats.length - STANDARD_NUMBER_FORMATS.length
      @number_formats[index] = number_format_string
    end
    index
  end
  
  def font_index(font)
    index = @fonts.index(font)
    if index.nil?
      index = @fonts.length + 1
      @fonts[index] = font
    end
    index
  end
  
  def format_index(format)
    index = @styles.index(format)
    if index.nil?
      index = 0x10 + @styles.length
      @styles[index] = format
    end
    index
  end
  
  private
  # This is private, please use add(style) instead.
  def add_style(style)
    number_format_index = number_format_index(style.number_format_string)
    font_index = font_index(style.font)
    
    format = [font_index, number_format_index, style.alignment, style.borders, style.pattern, style.protection]
    [format, format_index(format)]
  end
  
  public
  def to_biff
    fonts_biff + number_formats_biff + cell_styles_biff + StyleRecord.new.to_biff
  end
  
  # TODO use inject here?
  def fonts_biff
    result = ''
    @fonts.sort.each do |i, f|
      result += f.to_biff
    end
    result
  end
  
  def number_formats_biff
    result = ''
    @number_formats.sort.each do |i, f|
      next if i < FIRST_USER_DEFINED_NUM_FORMAT_INDEX
      result += NumberFormatRecord.new(i, f).to_biff
    end
    result
  end
  
  def cell_styles_biff
    result = ''
    0.upto(15) do |i|
      result += XFRecord.new(@default_format, 'style').to_biff
    end
    @styles.sort.each do |i, f|
      result += XFRecord.new(f).to_biff
    end
    result
  end
end
