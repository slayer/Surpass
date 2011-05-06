class Workbook
  MACROS = {
      'Consolidate_Area' => 0x00,
      'Auto_Open' => 0x01,
      'Auto_Close' => 0x02,
      'Extract' => 0x03,
      'Database' => 0x04,
      'Criteria' => 0x05,
      'Print_Area' => 0x06,
      'Print_Titles' => 0x07, # in the docs it says Pint_Titles, I think its a mistake
      'Recorder' => 0x08,
      'Data_Form' => 0x09,
      'Auto_Activate' => 0x0A,
      'Auto_Deactivate' => 0x0B,
      'Sheet_Title' => 0x0C,
      '_FilterDatabase' => 0x0D
  }
  
  attr_accessor :owner
  attr_accessor :country_code
  attr_accessor :wnd_protect
  attr_accessor :obj_protect
  attr_accessor :protect
  attr_accessor :backup_on_save
  attr_accessor :styles
  attr_accessor :sst
  
  def hpos_twips=(value)
    @hpos_twips = value & 0xFFFF
  end
  
  attr_reader :vpos_twips
  def vpos_twips=(value)
    @vpos_twips = value & 0xFFFF
  end
  
  attr_reader :width_twips
  def width_twips=(value)
    @width_twips = value & 0xFFFF
  end
  
  attr_reader :height_twips
  def height_twips=(value)
    @height_twips = value & 0xFFFF
  end
  
  attr_reader :active_sheet
  def active_sheet=(value)
    @active_sheet = value & 0xFFFF
    @first_tab_index = @active_sheet
  end
  
  attr_reader :tab_width_twips
  def tab_width_twips=(value)
    @tab_width_twips = value & 0xFFFF
  end
  
  attr_reader :default_style

  def initialize(filename = nil)
    @owner = 'None'
    @wnd_protect = 0
    @obj_protect = 0
    @protect = 0
    @backup_on_save = 0

    @hpos_twips = 0x01E0
    @vpos_twips = 0x005A
    @width_twips = 0x3FCF
    @height_twips = 0x2A4E

    @active_sheet = 0
    @first_tab_index = 0
    @selected_tabs = 0x01
    @tab_width_twips = 0x0258

    @wnd_hidden = false
    @wnd_mini = false
    @hscroll_visible = true
    @vscroll_visible = true
    @tabs_visible = true

    @styles = ::StyleCollection.new

    @dates_1904 = false
    @use_cell_values = true

    @sst = SharedStringTable.new

    @worksheets = []
    @names = []
    @refs = []
    
    @filename = filename
  end
  
  def add_sheet(name = nil)
    name ||= "Sheet#{@worksheets.length + 1}"
    s = Worksheet.new(name, self)
    @worksheets << s
    s
  end
  
  def print_area(sheetnum, rstart, rend, cstart, cend)
    if !sheetnum.is_a?(Integer)
      i = 0
      @worksheets.each_with_index do |w, i|
        sheetnum = i+1 if w.name === sheetnum
        break if sheetnum.is_a?(Integer)
      end
    end
    
    options = 0x0020 # see Options Flags for Name record
     
    # FIXME: this is just a bad hack, need to use Formula to make the rpn
    #~ rpn = Formula.Formula('').rpn()[2:] # minus the size field
    rpn = [0x3B, 0x0000, rstart, rend, cstart, cend].pack('Cv5')
    args = [options, 0x00, MACROS['Print_Area'], sheetnum, rpn]
    @names << NameRecord.new(*args).to_biff
  end

  def to_biff
    raise "You cannot save a workbook with no worksheets" if @worksheets.empty?
    
### @export "to-biff"
    section_1_array = []
    section_1_array << Biff8BOFRecord.new(Biff8BOFRecord::BOOK_GLOBAL).to_biff
    section_1_array << InterfaceHeaderRecord.new.to_biff
    section_1_array << MMSRecord.new.to_biff
    section_1_array << InterfaceEndRecord.new.to_biff
    section_1_array << WriteAccessRecord.new(owner).to_biff
    section_1_array << CodepageBiff8Record.new.to_biff
    section_1_array << DSFRecord.new.to_biff
    section_1_array << TabIDRecord.new(@worksheets.length).to_biff
    section_1_array << FnGroupCountRecord.new.to_biff
    section_1_array << WindowProtectRecord.new(as_numeric(@wnd_protect)).to_biff
    section_1_array << ProtectRecord.new(as_numeric(@protect)).to_biff
    section_1_array << ObjectProtectRecord.new(as_numeric(@obj_protect)).to_biff
    section_1_array << PasswordRecord.new.to_biff
    section_1_array << Prot4RevRecord.new.to_biff
    section_1_array << Prot4RevPassRecord.new.to_biff
    section_1_array << BackupRecord.new(@backup_on_save).to_biff
    section_1_array << HideObjRecord.new.to_biff
    section_1_array << window_1_record
    section_1_array << DateModeRecord.new(@dates_1904).to_biff
    section_1_array << PrecisionRecord.new(@use_cell_values).to_biff
    section_1_array << RefreshAllRecord.new.to_biff
    section_1_array << BookBoolRecord.new.to_biff
    section_1_array << @styles.to_biff
    section_1_array << '' # Palette
    section_1_array << UseSelfsRecord.new.to_biff
    section_1 = section_1_array.join
### @end
    section_3_array = []
    section_3_array << CountryRecord.new(@country_code, @country_code).to_biff unless @country_code.nil?
    # section_3_array << InternalReferenceSupBookRecord.new(@worksheets.length).to_biff
    # section_3_array << ExternSheetRecord.new(@refs).to_biff
    # section_3_array << @names.collect {|n| n.to_biff}.join
    section_3_array << @sst.to_biff
    section_3 = section_3_array.join
    
    section_4 = '' # ExtSSTRecord
    section_5 = EOFRecord.new.to_biff
    
    @worksheets[@active_sheet].selected = true
    worksheet_biff_data = @worksheets.collect {|w| w.to_biff }
    worksheet_biff_data_lengths = worksheet_biff_data.collect {|w| w.length }
    section_6 = worksheet_biff_data.join
    
    # Need to know how long the bound sheet records will be
    boundsheet_data_lengths = @worksheets.collect {|w| BoundSheetRecord.new(0x00, w.visibility, w.name).to_biff.length }
    total_boundsheet_data_length = boundsheet_data_lengths.inject(0) {|sum, l| sum + l}
    start_position = section_1.length + total_boundsheet_data_length + section_3.length + section_4.length + section_5.length
    
    boundsheet_records = []
    @worksheets.each_with_index do |w, i|
      boundsheet_records << BoundSheetRecord.new(start_position, w.visibility, w.name).to_biff
      start_position += worksheet_biff_data_lengths[i]
    end
    
    section_2 = boundsheet_records.join
    section_1 + section_2 + section_3 + section_4 + section_5 + section_6
  end
  
  def window_1_record
    flags = 0
    flags |= (as_numeric(@wnd_hidden)) << 0
    flags |= (as_numeric(@wnd_mini)) << 1
    flags |= (as_numeric(@hscroll_visible)) << 3
    flags |= (as_numeric(@vscroll_visible)) << 4
    flags |= (as_numeric(@tabs_visible)) << 5
    
    args = [@hpos_twips, @vpos_twips, @width_twips, @height_twips, flags, @active_sheet, @first_tab_index, @selected_tabs, @tab_width_twips]
    Window1Record.new(*args).to_biff
  end
  
  def data
    doc = ExcelDocument.new
    doc.data(to_biff).read
  end
  
  def save(filename = nil)
    @filename = filename unless filename.nil?
    doc = ExcelDocument.new
    doc.save(@filename, to_biff)
  end
end
