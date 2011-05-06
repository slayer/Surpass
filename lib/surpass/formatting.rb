module Formatting
  COLOURS = {
    'aqua' => 0x31,
    'black'   => 0x08,
    'blue'    => 0x0C,
    'blue-grey' => 0x36,
    'bright-green' => 0xb,
    'brown' => 0x3c,
    'coral' => 0x1d,
    'cornflower-blue' => 0x18,
    'dark-blue' => 0x12,
    'dark-green' => 0x3a,
    'dark-red' => 0x10,
    'dark-teal' => 0x38,
    'dark-yellow' => 0x13,
    'fuchsia' => 0x0E,
    'gold' => 0x33,
    'gray'    => 0x17,
    'grey'    => 0x17,
    'green' => 0x11,
    'grey-25-percent' => 0x16,
    'grey-40-percent' => 0x37,
    'grey-50-percent' => 0x17,
    'grey-80-percent' => 0x3f,
    'indigo' => 0x3e,
    'lavender' => 0x2e,
    'lemon-chiffon' => 0x1a,
    'light-blue' => 0x30,
    'light-cornflower-blue' => 0x1f,
    'light-green' => 0x2a,
    'light-orange' => 0x34,
    'light-turquoise' => 0x29,
    'light-yellow' => 0x2b,
    'lime' => 0x32,
    'magenta' => 0x0E,
    'maroon' => 0x19,
    'olive-green' => 0x3b,
    'orange' => 0x35,
    'orchid' => 0x1c,
    'pale-blue' => 0x2c,
    'pink'    => 0x21,
    'plum' => 0x3d,
    'purple'  => 0x14,
    'red'     => 0x0A,
    'rose' => 0x2d,
    'royal-blue' => 0x1e,
    'sea-green' => 0x39,
    'silver'  => 0x16,
    'sky-blue' => 0x28,
    'tan' => 0x2f,
    'teal' => 0x15,
    'turquoise' => 0xf,
    'violet' => 0x14,
    'white'   => 0x09,
    'yellow'  => 0x0D
  }
  
  COLORS = COLOURS
end

class Font
  ESCAPEMENT_NONE         = 0x00
  ESCAPEMENT_SUPERSCRIPT  = 0x01
  ESCAPEMENT_SUBSCRIPT    = 0x02
  
  UNDERLINE_NONE          = 0x00
  UNDERLINE_SINGLE        = 0x01
  UNDERLINE_SINGLE_ACC    = 0x21
  UNDERLINE_DOUBLE        = 0x02
  UNDERLINE_DOUBLE_ACC    = 0x22
  
  FAMILY_NONE         = 0x00
  FAMILY_ROMAN        = 0x01
  FAMILY_SWISS        = 0x02
  FAMILY_MODERN       = 0x03
  FAMILY_SCRIPT       = 0x04
  FAMILY_DECORATIVE   = 0x05
  
  CHARSET_ANSI_LATIN          = 0x00
  CHARSET_SYS_DEFAULT         = 0x01
  CHARSET_SYMBOL              = 0x02
  CHARSET_APPLE_ROMAN         = 0x4D
  CHARSET_ANSI_JAP_SHIFT_JIS  = 0x80
  CHARSET_ANSI_KOR_HANGUL     = 0x81
  CHARSET_ANSI_KOR_JOHAB      = 0x82
  CHARSET_ANSI_CHINESE_GBK    = 0x86
  CHARSET_ANSI_CHINESE_BIG5   = 0x88
  CHARSET_ANSI_GREEK          = 0xA1
  CHARSET_ANSI_TURKISH        = 0xA2
  CHARSET_ANSI_VIETNAMESE     = 0xA3
  CHARSET_ANSI_HEBREW         = 0xB1
  CHARSET_ANSI_ARABIC         = 0xB2
  CHARSET_ANSI_BALTIC         = 0xBA
  CHARSET_ANSI_CYRILLIC       = 0xCC
  CHARSET_ANSI_THAI           = 0xDE
  CHARSET_ANSI_LATIN_II       = 0xEE
  CHARSET_OEM_LATIN_I         = 0xFF
  
  PLAIN           = 0x00
  BOLD            = 0x01
  ITALIC          = 0x02
  UNDERLINE       = 0x04
  STRUCK_OUT      = 0x08
  OUTLINE         = 0x010
  SHADOW          = 0x020
  
  attr_accessor :height
  attr_accessor :italic
  attr_accessor :struck_out
  attr_accessor :outline
  attr_accessor :shadow
  attr_accessor :colour_index
  attr_accessor :bold
  attr_accessor :weight # Looks like only 400 = normal, 700 = bold are supported so just use bold = true.
  attr_accessor :escapement
  attr_accessor :charset
  attr_accessor :name

  attr_reader :family
  attr_reader :underline
  
  def initialize(hash = {})
    @height = 200 # font size 10
    @italic = false
    @struck_out = false
    @outline = false
    @shadow = false
    @colour_index = 0x7FFF
    @bold = false
    @weight = 400 # regular
    @escapement = ESCAPEMENT_NONE
    @charset = CHARSET_SYS_DEFAULT
    @name = 'Arial'
    @family = FAMILY_NONE
    @underline = UNDERLINE_NONE
    
    hash.each do |k, v|
      self.send((k.to_s + '=').to_sym, v)
    end
  end
  
  def family=(arg)
    raise "Oops, font_family doesn't take a string. Do you want font_name instead?" if arg.is_a?(String)
    @family = arg
  end
  
  # Convert font size in points to native twips
  def size=(points)
    @height = points * 20
  end
  
  def strikethrough=(arg)
    @struck_out = arg
  end
  
  def subscript=(arg)
    case arg
    when TrueClass
      @escapement = ESCAPEMENT_SUBSCRIPT
    when FalseClass
      @escapement  = ESCAPEMENT_NONE
    else
      raise "I don't know how to set subscript to #{arg.inspect}."
    end
  end
  
  def superscript=(arg)
    case arg
    when TrueClass
      @escapement = ESCAPEMENT_SUPERSCRIPT
    when FalseClass
      @escapement  = ESCAPEMENT_NONE
    else
      raise "I don't know how to set superscript to #{arg.inspect}."
    end
  end

  # User-friendly underlining directives.
  def underline=(arg)
    case arg
    when UNDERLINE_NONE, UNDERLINE_SINGLE, UNDERLINE_SINGLE_ACC, UNDERLINE_DOUBLE, UNDERLINE_DOUBLE_ACC
      @underline = arg
    when nil
      @underline ||= UNDERLINE_NONE
    when TrueClass
      @underline = UNDERLINE_SINGLE
    when FalseClass
      @underline = UNDERLINE_NONE
    when :none
      @underline = UNDERLINE_NONE
    when :single
      @underline = UNDERLINE_SINGLE
    when :single_acc, :single_accounting
      @underline = UNDERLINE_SINGLE_ACC
    when :double
      @underline = UNDERLINE_DOUBLE
    when :double_acc, :double_accounting
      @underline = UNDERLINE_DOUBLE_ACC
    else
      raise "I don't know how to set underline to #{arg.inspect}."
    end
  end
  
  def colour_index_from_name(colour_name)
    Formatting::COLOURS[colour_name.to_s]
  end
  
  def colour=(colour_name)
    new_colour = colour_index_from_name(colour_name)
    if new_colour.nil?
      raise "Invalid Colour #{colour_name}"
    else
      @colour_index = new_colour
    end
  end
  alias :color= :colour=
  alias :color_index= :colour_index=
  
  def to_biff
    options = PLAIN
    options |= BOLD if @bold
    options |= ITALIC if @italic
    options |= UNDERLINE if (@underline != UNDERLINE_NONE)
    options |= STRUCK_OUT if @struck_out
    options |= OUTLINE if @outline
    options |= SHADOW if @shadow

    @weight = 700 if @bold
    args = [@height, options, @colour_index, @weight, @escapement, @underline, @family, @charset, @name]
    FontRecord.new(*args).to_biff
  end
end

class Alignment
  HORZ_GENERAL                = 0x00
  HORZ_LEFT                   = 0x01
  HORZ_CENTER                 = 0x02
  HORZ_RIGHT                  = 0x03
  HORZ_FILLED                 = 0x04
  HORZ_JUSTIFIED              = 0x05 # BIFF4-BIFF8X
  HORZ_CENTER_ACROSS_SEL      = 0x06 # Centred across selection (BIFF4-BIFF8X)
  HORZ_DISTRIBUTED            = 0x07 # Distributed (BIFF8X)
  
  VERT_TOP                    = 0x00 
  VERT_CENTER                 = 0x01
  VERT_BOTTOM                 = 0x02
  VERT_JUSTIFIED              = 0x03 # Justified (BIFF5-BIFF8X)
  VERT_DISTRIBUTED            = 0x04 # Distributed (BIFF8X)

  DIRECTION_GENERAL           = 0x00 # BIFF8X
  DIRECTION_LR                = 0x01
  DIRECTION_RL                = 0x02

  ORIENTATION_NOT_ROTATED     = 0x00
  ORIENTATION_STACKED         = 0x01
  ORIENTATION_90_CC           = 0x02
  ORIENTATION_90_CW           = 0x03

  ROTATION_0_ANGLE            = 0x00
  ROTATION_STACKED            = 0xFF
  
  WRAP_AT_RIGHT               = 0x01
  NOT_WRAP_AT_RIGHT           = 0x00
  
  SHRINK_TO_FIT               = 0x01
  NOT_SHRINK_TO_FIT           = 0x00
  
  attr_accessor :horz
  attr_accessor :vert
  attr_accessor :dire
  attr_accessor :orie
  attr_accessor :rota
  attr_accessor :shri
  attr_accessor :inde
  attr_accessor :merg

  attr_reader :wrap
  
  def initialize(hash = {})
    # Initialize to defaults.
    @horz = HORZ_GENERAL
    @vert = VERT_BOTTOM
    @wrap = NOT_WRAP_AT_RIGHT
    @dire = DIRECTION_GENERAL
    @orie = ORIENTATION_NOT_ROTATED
    @rota = ROTATION_0_ANGLE
    @shri = NOT_SHRINK_TO_FIT
    @inde = 0
    @merg = 0
    
    # Allow defaults to be overridden in hash. Where there is no :align key in hash,
    # this just leaves the default value in place.
    self.align = hash[:align]
    self.wrap = hash[:wrap]
  end
  
  # Don't support passing constants here because :horz and :vert are exposed
  # so if someone wants to use nasty HORZ_RIGHT they can do align.vert = HORZ_RIGHT
  def align=(alignment_directives)
    if alignment_directives =~ /\s/
      args = alignment_directives.split
    else
      args = [alignment_directives] # there's just 1 here
    end
    
    args.each do |a|
      case a
      when 'right'
        @horz = HORZ_RIGHT
      when 'left'
        @horz = HORZ_LEFT
      when 'center', 'centre'
        @horz = HORZ_CENTER
      when 'general'
        @horz = HORZ_GENERAL
      when 'filled'
        @horz = HORZ_FILLED
      when 'justify'
        @horz = HORZ_JUSTIFIED
      when 'top'
        @vert = VERT_TOP
      when 'bottom'
        @vert = VERT_BOTTOM
      when nil
        # Do nothing.
      else
        raise "I don't know how to set align to #{a.inspect}."
      end
    end
  end
  
  def wrap=(arg)
    case arg
    when TrueClass, WRAP_AT_RIGHT
      @wrap = WRAP_AT_RIGHT
    when FalseClass, NOT_WRAP_AT_RIGHT
      @wrap = NOT_WRAP_AT_RIGHT
    when nil
      # Do nothing.
    else
      raise "I don't know how to set wrap to #{arg.inspect}."
    end
  end
end

class Borders
  attr_reader :left
  attr_reader :right
  attr_reader :top
  attr_reader :bottom
  attr_reader :diag

  attr_accessor :left_colour
  attr_accessor :right_colour
  attr_accessor :top_colour
  attr_accessor :bottom_colour
  attr_accessor :diag_colour

  attr_accessor :need_diag1
  attr_accessor :need_diag2
  
  NO_LINE = 0x00
  THIN    = 0x01
  MEDIUM  = 0x02
  DASHED  = 0x03
  DOTTED  = 0x04
  THICK   = 0x05
  DOUBLE  = 0x06
  HAIR    = 0x07
  #The following for BIFF8
  MEDIUM_DASHED               = 0x08
  THIN_DASH_DOTTED            = 0x09
  MEDIUM_DASH_DOTTED          = 0x0A
  THIN_DASH_DOT_DOTTED        = 0x0B
  MEDIUM_DASH_DOT_DOTTED      = 0x0C
  SLANTED_MEDIUM_DASH_DOTTED  = 0x0D
  
  NEED_DIAG1      = 0x01
  NEED_DIAG2      = 0x01
  NO_NEED_DIAG1   = 0x00
  NO_NEED_DIAG2   = 0x00
  
  # Want to keep these sorted in this order, so need nested array instead of hash.
  LINE_TYPE_DIRECTIVES = [
    ['none', NO_LINE],
    ['thin', THIN],
    ['medium', MEDIUM],
    ['dashed', DASHED],
    ['dotted', DOTTED],
    ['thick', THICK],
    ['double', DOUBLE],
    ['hair', HAIR],
    ['medium-dashed', MEDIUM_DASHED],
    ['thin-dash-dotted', THIN_DASH_DOTTED],
    ['medium-dash-dotted', MEDIUM_DASH_DOTTED],
    ['thin-dash-dot-dotted', THIN_DASH_DOT_DOTTED],
    ['medium-dash-dot-dotted', MEDIUM_DASH_DOT_DOTTED],
    ['slanted-medium-dash-dotted', SLANTED_MEDIUM_DASH_DOTTED]
  ]
  
  def self.line_type_directives
    LINE_TYPE_DIRECTIVES.collect {|k, v| k}
  end
  
  def self.line_type_constants
    LINE_TYPE_DIRECTIVES.collect {|k, v| v}
  end
  
  def self.line_type_directives_hash
    Hash[*LINE_TYPE_DIRECTIVES.flatten]
  end
  
  def initialize(hash = {})
    @left   = NO_LINE
    @right  = NO_LINE
    @top    = NO_LINE
    @bottom = NO_LINE
    @diag   = NO_LINE

    @left_colour   = 0x40
    @right_colour  = 0x40
    @top_colour    = 0x40
    @bottom_colour = 0x40
    @diag_colour   = 0x40

    @need_diag1 = NO_NEED_DIAG1
    @need_diag2 = NO_NEED_DIAG2
    
    hash.each do |k, v|
      self.send((k.to_s + '=').to_sym, v)
    end
  end
  
  def all=(directives)
    self.left = directives
    self.right = directives
    self.top = directives
    self.bottom = directives
  end
  
  def process_directives(directives)
    if directives =~ /\s/
      args = directives.split
    else
      args = [directives] # there's just 1 here, stick it in an array
    end
    
    raise "no directives given to process_directives" if args.empty? # maybe don't need this, just get thin black border? but for development I want to know if this happens.
    raise "too many directives given to process_directives" if args.size > 2
    
    instructions = [THIN, Formatting::COLOURS['black']]
    args.each do |a|
      if Formatting::COLOURS.include?(a)
        instructions[1] = Formatting::COLOURS[a]
        next
      end
      
      if Borders.line_type_directives.include?(a)
        instructions[0] = Borders.line_type_directives_hash[a]
        next
      end
      
      if Borders.line_type_constants.include?(a)
        instructions[0] = a
        next
      end

      raise "I don't know how to format a border with #{a.inspect}."
    end

    instructions
  end
  
  def right=(directives)
    @right, @right_colour = process_directives(directives)
  end
  
  def left=(directives)
    @left, @left_colour = process_directives(directives)
  end
  
  def top=(directives)
    @top, @top_colour = process_directives(directives)
  end

  def bottom=(directives)
    @bottom, @bottom_colour = process_directives(directives)
  end
end


class Pattern
  NO_PATTERN      = 0x00 
  SOLID_FOREGROUND   = 0x01
  SOLID_PATTERN = SOLID_FOREGROUND # for backwards compatibility
  FINE_DOTS = 0x02
  ALT_BARS = 0x03
  SPARSE_DOTS = 0x04
  THICK_HORZ_BANDS = 0x05
  THICK_VERT_BANDS = 0x06
  THICK_BACKWARD_DIAG = 0x07
  THICK_FORWARD_DIAG = 0x08
  BIG_SPOTS = 0x09
  BRICKS = 0x0A
  THIN_HORZ_BANDS = 0x0B
  THIN_VERT_BANDS = 0x0C
  THIN_BACKWARD_DIAG = 0x0D
  THIN_FORWARD_DIAG = 0x0E
  SQUARES = 0x0F
  DIAMONDS = 0x10
  LESS_DOTS = 0x11
  LEAST_DOTS = 0x12
  
  # Want to keep these sorted in this order, so need nested array instead of hash.
  PATTERN_DIRECTIVES = [
    ['none', NO_PATTERN],
    ['solid', SOLID_FOREGROUND],
    ['fine-dots', FINE_DOTS],
    ['alt-bars', ALT_BARS],
    ['sparse-dots', SPARSE_DOTS],
    ['thick-horz-bands', THICK_HORZ_BANDS],
    ['thick-vert-bands', THICK_VERT_BANDS],
    ['thick-backward-diag', THICK_BACKWARD_DIAG],
    ['thick-forward-diag', THICK_FORWARD_DIAG],
    ['big-spots', BIG_SPOTS],
    ['bricks', BRICKS],
    ['thin-horz-bands', THIN_HORZ_BANDS],
    ['thin-vert-bands', THIN_VERT_BANDS],
    ['thin-backward-diag', THIN_BACKWARD_DIAG],
    ['thin-forward-diag', THIN_FORWARD_DIAG],
    ['squares', SQUARES],
    ['diamonds', DIAMONDS],
    ['less-dots', LESS_DOTS],
    ['least-dots', LEAST_DOTS]
  ]
  
  attr_reader :pattern
  attr_reader :pattern_fore_colour
  attr_reader :pattern_back_colour
  
  def self.fill_directives
    PATTERN_DIRECTIVES.collect {|a| a[0]}
  end
  
  def self.directives_hash
    Hash[*PATTERN_DIRECTIVES.flatten]
  end
  
  def initialize(hash = {})
    @pattern = NO_PATTERN
    @pattern_fore_colour = 0x40
    @pattern_back_colour = 0x41
    
    hash.each do |k, v|
      self.send((k.to_s + '=').to_sym, v)
    end
  end
  
  def pattern=(arg)
    case arg
    when String
      pattern_index = Pattern.directives_hash[arg]
    when Integer
      pattern_index = arg
    else
      raise "I don't know how to interpret #{arg.inspect} as a pattern!"
    end
    raise "invalid pattern #{arg}" if pattern_index.nil?
    
    @pattern = pattern_index
  end
  
  def fore_colour=(arg)
   colour_index = Formatting::COLOURS[arg]
   raise "Invalid colour #{arg}" if colour_index.nil?
   @pattern_fore_colour = colour_index
  end
  alias :fore_color= :fore_colour=

  def back_colour=(arg)
   colour_index = Formatting::COLOURS[arg]
   raise "Invalid colour #{arg}" if colour_index.nil?
   @pattern_back_colour = colour_index
  end
  alias :back_color= :back_colour=
  
  # Sets the foreground colour, also if no pattern has been specified
  # will assume you want a solid colour fill.
  def colour=(arg)
    self.fore_colour = arg
    @pattern = SOLID_PATTERN if @pattern == NO_PATTERN
  end
  alias :color= :colour=
  alias :fill= :colour=
end

class Protection
  attr_accessor :cell_locked
  attr_accessor :formula_hidden
  
  def initialize
    @cell_locked = 1
    @formula_hidden = 0
  end
end
