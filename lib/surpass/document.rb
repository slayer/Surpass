class Reader
  DIR_ENTRY_SIZE = 128
  
  attr_accessor :header
  attr_accessor :data
  
  attr_accessor :doc_magic
  attr_accessor :file_uid
  attr_accessor :rev_num
  attr_accessor :ver_num
  attr_accessor :byte_order
  attr_accessor :sect_size
  attr_accessor :short_sect_size
  
  attr_accessor :total_sat_sectors
  attr_accessor :dir_start_sid
  attr_accessor :min_stream_size
  attr_accessor :ssat_start_sid
  attr_accessor :total_ssat_sectors
  attr_accessor :msat_start_sid
  attr_accessor :total_msat_sectors
  
  attr_accessor :msat
  attr_accessor :sat
  attr_accessor :ssat
  attr_accessor :dir_entry_list
  
  def initialize(file)
    @streams = {}
    
    file = File.open(file, 'rb') unless file.respond_to?(:read)
    doc = file.read
    @header, @data = doc[0...512], doc[512..-1]
    
    build_header
    build_msat
    build_sat
    build_directory
    build_short_sectors_data

    if @short_sectors_data.length > 0
      build_ssat
    else
      @ssat_start_sid = -2
      @total_ssat_sectors = 0
      @ssat = [-2]
    end

    @dir_entry_list[1..-1].each do |d|
      did, sz, name, t, c, did_left, did_right, did_root, dentry_start_sid, stream_size = d
      stream_data = ''
      if stream_size > 0
        if stream_size > @min_stream_size
          args = [@data, @sat, dentry_start_sid, @sect_size]
        else
          args = [@short_sectors_data, @ssat, dentry_start_sid, @short_sect_size]
        end
        stream_data = stream_data(*args)
      end
      # BAD IDEA: names may be equal. NEED use full paths...
      @streams[name] = stream_data if !name.length == 0
    end
  end
  
  def build_header
    @doc_magic = @header[0...8]
    raise 'Not an OLE file.' unless @doc_magic === "\320\317\021\340\241\261\032\341"

    @file_uid              = @header[8...24]
    @rev_num               = @header[24...26]
    @ver_num               = @header[26...28]
    @byte_order            = @header[28...30]
    @log2_sect_size       = @header[30...32].unpack('v')[0]
    @log2_short_sect_size = @header[32...34].unpack('v')[0]
    @total_sat_sectors    = @header[44...48].unpack('V')[0]
    @dir_start_sid        = @header[48...52].unpack('V')[0]
    @min_stream_size      = @header[56...60].unpack('V')[0]
    @ssat_start_sid       = @header[60...64].unpack('V')[0]
    @total_ssat_sectors   = @header[64...68].unpack('V')[0]
    @msat_start_sid       = @header[68...72].unpack('V')[0]
    @total_msat_sectors   = @header[72...76].unpack('V')[0]

    @sect_size        = 1 << @log2_sect_size
    @short_sect_size  = 1 << @log2_short_sect_size
  end
  
  def build_msat
    @msat = @header[76..-1].unpack('V109')
    next_sector = @msat_start_sid
    while next_sector > 0 do
      raise "not implemented"
      start = next_sector * @sect_size
      finish = (next_sector + 1) * @sect_size
      msat_sector = @data[start...finish]
      @msat << msat_sector
      next_sector = msat_sector[-1]
    end
  end
  
  def build_sat
    sat_stream = @msat.collect {|i| i >= 0 ? @data[(i*@sect_size)...((i+1)*@sect_size)] : '' }.join
    @sat = sat_stream.unpack('V*')
  end
  
  def build_ssat
    ssat_stream = stream_data(@data, @sat, @ssat_start_sid, @sect_size)
    @ssat = ssat_stream.unpack('V*')
  end
  
  def build_directory
    dir_stream = stream_data(@data, @sat, @dir_start_sid, @sect_size)
    @dir_entry_list = []
    i = 0
    while i < dir_stream.length do
      dentry = dir_stream[i...(i+DIR_ENTRY_SIZE)]
      i += DIR_ENTRY_SIZE
      
      did = @dir_entry_list.length
      sz = dentry[64...66].unpack('C')[0]
      
      if sz > 0
        name = dentry[0...(sz-2)] # TODO unicode
      else
        name = ''
      end
      
      t = dentry[66...67].unpack('C')[0]
      c = dentry[67...68].unpack('C')[0]
      did_left = dentry[68...72].unpack('V')[0]
      did_right = dentry[72...76].unpack('V')[0]
      did_root = dentry[76...80].unpack('V')[0]
      dentry_start_sid = dentry[116...120].unpack('V')[0]
      stream_size = dentry[120...124].unpack('V')[0]
      
      @dir_entry_list << [did, sz, name, t, c, did_left, did_right, did_root, dentry_start_sid, stream_size]
    end
  end
  
  def build_short_sectors_data
    did, sz, name, t, c, did_left, did_right, did_root, dentry_start_sid, stream_size = @dir_entry_list[0]
    raise unless t == 0x05 # Short-Stream Container Stream (SSCS) resides in Root Storage

    if stream_size == 0
      @short_sectors_data = ''
    else
      @short_sectors_data = stream_data(@data, @sat, dentry_start_sid, @sect_size)
    end
  end
  
  def stream_data(data, sat, start_sid, sect_size)
      sid = start_sid
      chunks = [[sid, sid]]
      stream_data = ''
      while sat[sid] >= 0 do
          next_in_chain = sat[sid]
          last_chunk_start, last_chunk_finish = chunks[-1]
          if next_in_chain == last_chunk_finish + 1
              chunks[-1] = last_chunk_start, next_in_chain
          else
              chunks << [next_in_chain, next_in_chain]
          end
          sid = next_in_chain
      end
      
      chunks.each do |s, f|
        stream_data += data[s*sect_size...(f+1)*sect_size]
      end
      stream_data
    end
end


# This implementation writes only 'Root Entry', 'Workbook' streams
# and 2 empty streams for aligning directory stream on sector boundary
# 
# LAYOUT:
# 0         header
# 76                MSAT (1st part: 109 SID)
# 512       workbook stream
# ...       additional MSAT sectors if streams' size > about 7 Mb == (109*512 * 128)
# ...       SAT
# ...       directory stream
#
# NOTE: this layout is "ad hoc". It can be more general. RTFM
class ExcelDocument
  SECTOR_SIZE = 0x0200
  MIN_LIMIT   = 0x1000

  SID_FREE_SECTOR  = -1
  SID_END_OF_CHAIN = -2
  SID_USED_BY_SAT  = -3
  SID_USED_BY_MSAT = -4
  
  def initialize
    @book_stream_sect = []
    @dir_stream_sect = []
    
    @packed_sat = ''
    @sat_sect = []
    
    @packed_msat_1st = ''
    @packed_msat_2nd = ''
    @msat_sect_2nd = []
    @header = ''
  end
  
  def build_directory
    @dir_stream = ''
    
    name = 'Root Entry'
    type = 0x05 # root storage
    colour = 0x01 # black
    did_left  = -1
    did_right = -1
    did_root  = 1
    start_sid = -2
    stream_sz = 0
    @dir_stream += pack_directory(name, type, colour, did_left, did_right, did_root, start_sid, stream_sz)

    name = 'Workbook'
    type = 0x02 # user stream
    colour = 0x01 # black
    did_left  = -1
    did_right = -1
    did_root  = -1
    start_sid = 0
    stream_sz = @book_stream_len
    @dir_stream += pack_directory(name, type, colour, did_left, did_right, did_root, start_sid, stream_sz)
    # padding
    name      = ''
    type      = 0x00 # empty
    colour    = 0x01 # black
    did_left  = -1
    did_right = -1
    did_root  = -1
    start_sid = -2
    stream_sz = 0
    @dir_stream += pack_directory(name, type, colour, did_left, did_right, did_root, start_sid, stream_sz) * 2
  end
  
  def pack_directory(name, type, colour, did_left, did_right, did_root, start_sid, stream_sz)
    encoded_name = ''
    0.upto(name.length) do |i|
      encoded_name << name[i, 1] + "\000" 
    end
    encoded_name << "\000"
    name_sz = encoded_name.length

    args = [encoded_name, name_sz, type, colour, did_left, did_right, did_root, 0, 0, 0, 0, 0, 0, 0, 0, 0, start_sid, stream_sz, 0]
    args.pack('a64 v C2 V3 V9 V V2')
  end
  
  def build_sat
    book_sect_count       = @book_stream_len >> 9
    dir_sect_count        = @dir_stream.length >> 9
    total_sect_count      = book_sect_count + dir_sect_count
    sat_sect_count        = 0
    msat_sect_count       = 0
    sat_sect_count_limit  = 109
    
    while (total_sect_count > 128*sat_sect_count) || (sat_sect_count > sat_sect_count_limit) do
      sat_sect_count += 1
      total_sect_count += 1
      if sat_sect_count > sat_sect_count_limit
        msat_sect_count += 1
        total_sect_count += 1
        sat_sect_count_limit += 127
      end
    end
    
    # initialize the sat array to be filled with the "empty" character specified by SID_FREE_SECTOR
    sat = [SID_FREE_SECTOR]*128*sat_sect_count
    
    sect = 0
    while sect < book_sect_count - 1 do
      @book_stream_sect << sect
      sat[sect] = sect + 1
      sect += 1
    end
    @book_stream_sect << sect
    sat[sect] = SID_END_OF_CHAIN
    sect += 1
    
    while sect < book_sect_count + msat_sect_count do
      @msat_sect_2nd << sect
      sat[sect] = SID_USED_BY_MSAT
      sect += 1
    end
    
    while sect < book_sect_count + msat_sect_count + sat_sect_count do
      @sat_sect << sect
      sat[sect] = SID_USED_BY_SAT
      sect += 1
    end
    
    while sect < book_sect_count + msat_sect_count + sat_sect_count + dir_sect_count - 1 do
      @dir_stream_sect << sect
      sat[sect] = sect + 1
      sect += 1
    end
    
    @dir_stream_sect << sect
    sat[sect] = SID_END_OF_CHAIN
    sect += 1
    
    @packed_sat = sat.pack('V*')
    
    msat_1st = []
    109.times do |i|
      msat_1st[i] = @sat_sect[i] || SID_FREE_SECTOR
    end
    @packed_msat_1st = msat_1st.pack('V*')
    
    msat_2nd = [SID_FREE_SECTOR] * 128 * msat_sect_count
    msat_2nd[-1] = SID_END_OF_CHAIN if msat_sect_count > 0
    
    i = 109
    msat_sect = 0
    sid_num = 0
    
    while i < sat_sect_count do
      if (sid_num + 1) % 128 == 0
        msat_sect += 1
        msat_2nd[sid_num] = @msat_sect_2nd[msat_sect] if msat_sect < @msat_sect_2nd.length
      else
        msat_2nd[sid_num] = @sat_sect[i]
        i += 1
      end
      sid_num += 1
    end
    
    @packed_msat_2nd = msat_2nd.pack('V*')
  end
  
  def build_header
     doc_magic                    = "\320\317\021\340\241\261\032\341"
     file_uid                     =  "\000" * 16
     rev_num                      = ">\000"
     ver_num                      = "\003\000"
     byte_order                   = "\376\377"
     log_sect_size                = [9].pack('v')
     log_short_sect_size          = [6].pack('v')
     not_used0                    = "\000"*10
     total_sat_sectors            = [@sat_sect.length].pack('V')
     dir_start_sid                = [@dir_stream_sect[0]].pack('V')
     not_used1                    = "\000"*4        
     min_stream_size              = [0x1000].pack('V')
     ssat_start_sid               = [-2].pack('V')
     total_ssat_sectors           = [0].pack('V')
     
     if @msat_sect_2nd.length == 0
       msat_start_sid = [-2].pack('V')
     else
       msat_start_sid = [@msat_sect_2nd[0]].pack('V')
     end
     
     total_msat_sectors = [@msat_sect_2nd.length].pack('V')
     
     @header = [
         doc_magic,
         file_uid,
         rev_num,
         ver_num,
         byte_order,
         log_sect_size,
         log_short_sect_size,
         not_used0,
         total_sat_sectors,
         dir_start_sid,
         not_used1,
         min_stream_size,
         ssat_start_sid,
         total_ssat_sectors,
         msat_start_sid,
         total_msat_sectors
     ].join
  end
  
  def data(stream)
    distance_to_end_of_next_sector_boundary = 0x1000 - (stream.length % 0x1000)
    @book_stream_len = stream.length + distance_to_end_of_next_sector_boundary
    padding = "\000" * distance_to_end_of_next_sector_boundary

    build_directory
    build_sat
    build_header
    
    s = StringIO.new
    s.write(@header)
    s.write(@packed_msat_1st)
    s.write(stream)
    s.write(padding)
    s.write(@packed_msat_2nd)
    s.write(@packed_sat)
    s.write(@dir_stream)
    s.rewind
    s
  end
  
  def save(file, stream)
    we_own_it = !file.respond_to?(:write)
    file = File.open(file, 'wb') if we_own_it
    file.write data(stream).read
    file.close if we_own_it
  end
end
