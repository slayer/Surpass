require File.dirname(__FILE__) + '/spec_helper'

describe Workbook, "to_biff" do
  before(:each) do
    @w = Workbook.new
    ws = @w.add_sheet('Image')
    ws.insert_bitmap('examples/python.bmp', 2, 2)
    ws.insert_bitmap('examples/python.bmp', 10, 2)
    
  end
  
  # Use this to run code in python source and compare resulting binaries.
  it "should not raise an error" do
    if false
      ruby_biff = @w.to_biff
      python_biff = File.read("/Users/ana/src/pyexcelerator/trunk/workbook.bin")
    
      0.upto(ruby_biff.length) do |i|
        next if ruby_biff[0,i] === python_biff[0,i]
        puts ruby_biff[i-5, 10].inspect
        puts python_biff[i-5, 10].inspect
        raise "files are identical up to #{i.to_s}"
      end
    end
  end
end

describe Workbook, "description" do
  before(:all) do
    strings = File.read("spec/data/random-strings.txt").split("\n")

    @book = Workbook.new
    @sheet = @book.add_sheet

    colcount = 20 + 1
    rowcount = 20 + 1

    colcount.times do |c|
      rowcount.times do |r|
        i = c * rowcount + r
        @sheet.write(r, c, strings[i])
      end
    end
  end
  it "should description" do
    # @book.window_1_record
  end
end