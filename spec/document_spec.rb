require File.dirname(__FILE__) + '/spec_helper'

describe ExcelDocument do
  it "should save" do
    w = Workbook.new
    w.country_code = 0x01
    s = w.add_sheet("Hello World!")
    s.write(0, 0, 99)
    s.write(1, 1, "Hello!")
    w.save("spec/output/mini.xls")
  end
end

# describe Reader do
#   before(:each) do
#     @doc = Reader.new("spec/reference/mini.xls")
#   end
#   
#   it "should read in the entire file" do
#     @doc.header.length.should == 512
#     @doc.data.length.should == 5120
#   end
#   
#   it "should correctly parse doc_magic" do
#     @doc.doc_magic.should === [0xD0, 0xCF, 0x11, 0xE0, 0xA1, 0xB1, 0x1A, 0xE1].to_bin
#   end
#   
#   it "should correctly parse file_uid" do
#     @doc.file_uid.should === [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00].to_bin
#   end
#   
#   it "should correctly parse rev_num" do
#     @doc.rev_num.should === [0x3E, 0x00].to_bin
#   end
#   
#   it "should correctly parse ver_num" do
#     @doc.ver_num.should === [0x03, 0x00].to_bin
#   end
#   
#   it "should correctly parse byte_order" do
#     @doc.byte_order.should === [0xFE, 0xFF].to_bin
#   end
#   
#   it "should correctly parse sector size" do
#     @doc.sect_size.should === 512
#   end
#   
#   it "should correctly parse short sector size" do
#     @doc.short_sect_size.should == 64
#   end
#   
#   it "should correctly parse total sat sectors" do
#     @doc.total_sat_sectors.should == 1
#   end
#   
#   it "should correctly parse dir start sid" do
#     @doc.dir_start_sid.should == 8
#   end
#   
#   it "should correctly parse min stream size" do
#     @doc.min_stream_size.should == 4096
#   end
#   
#   it "should correctly parse ssat start sid" do
#     @doc.ssat_start_sid.should == -2
#   end
#   
#   it "should correctly parse total ssat sectors" do
#     @doc.total_ssat_sectors.should == 0
#   end
#   
#   it "should correctly parse msat start sid" do
#     @doc.msat_start_sid.should == -2
#   end
#   
#   it "should correctly parse total msat sectors" do
#     @doc.total_msat_sectors.should == 0
#   end
#   
#   it "should correctly parse the msat" do
#     @doc.msat.should == [9, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
#   end
#   
#   it "should correctly parse the sat" do
#     @doc.sat.should == [1, 2, 3, 4, 5, 6, 7, -2, -2, -3, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
#   end
#   
#   it "should correctly parse the directory list" do
#     @doc.dir_entry_list.length.should == 4
#   end
# end

# from pyExcelerator import *
# doc = CompoundDoc.Reader("museum/mini.xls", True)

# file magic: 
# 0xD0 0xCF 0x11 0xE0 0xA1 0xB1 0x1A 0xE1 
# file uid: 
# 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
# revision number: 
# 0x3E 0x00 
# version number: 
# 0x03 0x00 
# byte order: 
# 0xFE 0xFF 
# sector size                                : 0x200 512
# short sector size                          : 0x40 64
# Total number of sectors used for the SAT   : 0x1 1
# SID of first sector of the directory stream: 0x8 8
# Minimum size of a standard stream          : 0x1000 4096
# SID of first sector of the SSAT            : -0x2 -2
# Total number of sectors used for the SSAT  : 0x0 0
# SID of first additional sector of the MSAT : -0x2 -2
# Total number of sectors used for the MSAT  : 0x0 0
# MSAT (header part): 
# [9, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
# additional MSAT sectors: 
# []
# SAT sid count:
# 128
# SAT content:
# (1, 2, 3, 4, 5, 6, 7, -2, -2, -3, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1)
# total directory entries: 4
# DID 0
# Size of the used area of the character buffer of the name: 22
# dir entry name: u'Root Entry'
# type of entry: 5 Root storage
# entry colour: 0 Red
# left child DID : -1
# right child DID: -1
# root DID       : 1
# start SID       : -2
# stream size     : 0
# stream is empty
# DID 1
# Size of the used area of the character buffer of the name: 18
# dir entry name: u'Workbook'
# type of entry: 2 User stream
# entry colour: 0 Red
# left child DID : -1
# right child DID: -1
# root DID       : -1
# start SID       : 0
# stream size     : 4096
# stream stored as normal stream
# DID 2
# Size of the used area of the character buffer of the name: 0
# dir entry name: u''
# type of entry: 0 Empty
# entry colour: 0 Red
# left child DID : -1
# right child DID: -1
# root DID       : -1
# start SID       : 0
# stream size     : 0
# stream is empty
# DID 3
# Size of the used area of the character buffer of the name: 0
# dir entry name: u''
# type of entry: 0 Empty
# entry colour: 0 Red
# left child DID : -1
# right child DID: -1
# root DID       : -1
# start SID       : 0
# stream size     : 0
# stream is empty
#