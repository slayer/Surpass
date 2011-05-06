class ObjBmpRecord < BiffRecord
  RECORD_ID = 0x005D    # Record identifier
  
  def initialize(row, col, sheet, im_data_bmp, x, y, scale_x, scale_y)
    width = im_data_bmp.width * scale_x
    height = im_data_bmp.height * scale_y
    
    col_start, x1, row_start, y1, col_end, x2, row_end, y2 = position_image(sheet, row, col, x, y, width, height)
    
    # Store the OBJ record that precedes an IMDATA record. This could be generalise
    # to support other Excel objects.
    cobj = 0x0001      # count of objects in file (set to 1)
    ot = 0x0008        # object type. 8 = picture
    id = 0x0001        # object id
    grbit = 0x0614     # option flags
    coll = col_start    # col containing upper left corner of object
    dxl = x1            # distance from left side of cell
    rwt = row_start     # row containing top left corner of object
    dyt = y1            # distance from top of cell
    colr = col_end      # col containing lower right corner of object
    dxr = x2            # distance from right of cell
    rwb = row_end       # row containing bottom right corner of object
    dyb = y2            # distance from bottom of cell
    cbmacro = 0x0000    # length of fmla structure
    reserved1 = 0x0000  # reserved
    reserved2 = 0x0000  # reserved
    icvback = 0x09      # background colour
    icvfore = 0x09      # foreground colour
    fls = 0x00          # fill pattern
    fauto = 0x00        # automatic fill
    icv = 0x08          # line colour
    lns = 0xff          # line style
    lnw = 0x01          # line weight
    fautob = 0x00       # automatic border
    frs = 0x0000        # frame style
    cf = 0x0009         # image format, 9 = bitmap
    reserved3 = 0x0000  # reserved
    cbpictfmla = 0x0000 # length of fmla structure
    reserved4 = 0x0000  # reserved
    grbit2 = 0x0001     # option flags
    reserved5 = 0x0000  # reserved
    
    args = [cobj, ot, id, grbit, coll, dxl, rwt, dyt, colr, dxr, rwb, dyb, cbmacro, reserved1, reserved2, icvback, icvfore, fls, fauto, icv, lns, lnw, fautob, frs, cf, reserved3, cbpictfmla, reserved4, grbit2, reserved5]
    @record_data = args.pack('L v12 L v C8 v L v4 L')
  end
  
  # Calculate the vertices that define the position of the image as required by
  # the OBJ record.
  # 
  #          +------------+------------+
  #          |     A      |      B     |
  #    +-----+------------+------------+
  #    |     |(x1,y1)     |            |
  #    |  1  |(A1)._______|______      |
  #    |     |    |              |     |
  #    |     |    |              |     |
  #    +-----+----|    BITMAP    |-----+
  #    |     |    |              |     |
  #    |  2  |    |______________.     |
  #    |     |            |        (B2)|
  #    |     |            |     (x2,y2)|
  #    +---- +------------+------------+
  # 
  # Example of a bitmap that covers some of the area from cell A1 to cell B2.
  # 
  # Based on the width and height of the bitmap we need to calculate 8 vars:
  #     col_start, row_start, col_end, row_end, x1, y1, x2, y2.
  # The width and height of the cells are also variable and have to be taken into
  # account.
  # The values of col_start and row_start are passed in from the calling
  # function. The values of col_end and row_end are calculated by subtracting
  # the width and height of the bitmap from the width and height of the
  # underlying cells.
  # The vertices are expressed as a percentage of the underlying cell width as
  # follows (rhs values are in pixels):
  # 
  #        x1 = X / W *1024
  #        y1 = Y / H *256
  #        x2 = (X-1) / W *1024
  #        y2 = (Y-1) / H *256
  # 
  #        Where:  X is distance from the left side of the underlying cell
  #                Y is distance from the top of the underlying cell
  #                W is the width of the cell
  #                H is the height of the cell
  # 
  # Note: the SDK incorrectly states that the height should be expressed as a
  # percentage of 1024.
  # 
  # col_start  - Col containing upper left corner of object
  # row_start  - Row containing top left corner of object
  # x1  - Distance to left side of object
  # y1  - Distance to top of object
  # width  - Width of image frame
  # height  - Height of image frame
  def position_image(sheet, row_start, col_start, x1, y1, width, height)
    while x1 >= size_col(sheet, col_start) do
      x1 -= size_col(sheet, col_start)
      col_start += 1
    end
    
    # Adjust start row for offsets that are greater than the row height
    while y1 >= size_row(sheet, row_start) do
      y1 -= size_row(sheet, row_start)
      row_start += 1
    end
    
    # Initialise end cell to the same as the start cell
    row_end = row_start   # Row containing bottom right corner of object
    col_end = col_start   # Col containing lower right corner of object
    width = width + x1 - 1
    height = height + y1 - 1
    
    # Subtract the underlying cell widths to find the end cell of the image
    while (width >= size_col(sheet, col_end)) do
      width -= size_col(sheet, col_end)
      col_end += 1
    end
    
    # Subtract the underlying cell heights to find the end cell of the image
    while (height >= size_row(sheet, row_end)) do
      height -= size_row(sheet, row_end)
      row_end += 1
    end
    
    # Bitmap isn't allowed to start or finish in a hidden cell, i.e. a cell
    # with zero height or width.
    starts_or_ends_in_hidden_cell = ((size_col(sheet, col_start) == 0) or (size_col(sheet, col_end) == 0) or (size_row(sheet, row_start) == 0) or (size_row(sheet, row_end) == 0))
    return if starts_or_ends_in_hidden_cell

    # Convert the pixel values to the percentage value expected by Excel
    x1 = (x1.to_f / size_col(sheet, col_start) * 1024).to_i
    y1 = (y1.to_f / size_row(sheet, row_start) * 256).to_i
    # Distance to right side of object
    x2 = (width.to_f / size_col(sheet, col_end) * 1024).to_i
    # Distance to bottom of object
    y2 = (height.to_f / size_row(sheet, row_end) * 256).to_i
    
    [col_start, x1, row_start, y1, col_end, x2, row_end, y2]
  end
  
  def size_col(sheet, col)
    sheet.col_width(col)
  end

  def size_row(sheet, row)
    sheet.row_height(row)
  end
end

class ImDataBmpRecord < BiffRecord
  RECORD_ID = 0x007F
  
  attr_accessor :width
  attr_accessor :height
  attr_accessor :size
  
  # Insert a 24bit bitmap image in a worksheet. The main record required is
  # IMDATA but it must be proceeded by a OBJ record to define its position.
  def initialize(filename)
    @width, @height, @size, data = process_bitmap(filename)
    
    cf = 0x09
    env = 0x01
    lcb = @size
    
    @record_data =  [cf, env, lcb].pack('v2L') + data
  end
  
  # Convert a 24 bit bitmap into the modified internal format used by Windows.
  # This is described in BITMAPCOREHEADER and BITMAPCOREINFO structures in the
  # MSDN library.
  def process_bitmap(filename)
    data = nil
    File.open(filename, "rb") do |f|
      data = f.read
    end
    
    raise "bitmap #{filename} doesn't contain enough data" if data.length <= 0x36
    raise "bitmap #{filename} is not valid" unless data[0, 2] === "BM"
    
    # Remove bitmap data: ID.
    data = data[2..-1]

    # Read and remove the bitmap size. This is more reliable than reading
    # the data size at offset 0x22.
    size = data[0,4].unpack('L')[0]
    size -=  0x36   # Subtract size of bitmap header.
    size +=  0x0C   # Add size of BIFF header.

    data = data[4..-1]
    # Remove bitmap data: reserved, offset, header length.
    data = data[12..-1]
    # Read and remove the bitmap width and height. Verify the sizes.
    width, height = data[0,8].unpack('L2')
    data = data[8..-1]
    raise "bitmap #{filename} largest image width supported is 65k." if (width > 0xFFFF)
    raise "bitmap #{filename} largest image height supported is 65k." if (height > 0xFFFF)
    
    # Read and remove the bitmap planes and bpp data. Verify them.
    planes, bitcount = data[0,4].unpack('v2')
    data = data[4..-1]
    raise "bitmap #{filename} isn't a 24bit true color bitmap." if (bitcount != 24)
    raise "bitmap #{filename} only 1 plane supported in bitmap image." if (planes != 1)

    # Read and remove the bitmap compression. Verify compression.
    compression = data[0,4].unpack('L')[0]
    data = data[4..-1]
    raise "bitmap #{filename} compression not supported in bitmap image." if (compression != 0)
        
    # Remove bitmap data: data size, hres, vres, colours, imp. colours.
    data = data[20..-1]
    # Add the BITMAPCOREHEADER data
    header = [0x000c, width, height, 0x01, 0x18].pack('Lv4')
    
    [width, height, size, header + data]
  end
end