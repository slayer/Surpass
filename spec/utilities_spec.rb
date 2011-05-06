require File.dirname(__FILE__) + '/spec_helper'

include Utilities

describe Utilities do
  it "should round trip pixels to twips" do
    pixels_to_twips(twips_to_pixels(5)).should == 5.0
  end
  
  it "should round trip points to pixels" do
    points_to_pixels(pixels_to_points(5)).should == 5.0
  end
end

describe Utilities, "Excel boolean conversion" do
  it "should convert true values to 1" do
    as_numeric(true).should == 1
  end
  
  it "should convert false values to 0" do
    as_numeric(false).should == 0
  end
  
  it "should convert 1 to true" do
    as_boolean(1).should be_true
  end

  it "should convert 0 to false" do
    as_boolean(0).should be_false
  end
  
  it "should raise an error with anything else" do
    lambda { as_boolean(5) }.should raise_error("Can't convert 5 from excel boolean!")
  end
end

describe Utilities, "Excel date converter" do
  it "should convert objects of class Date" do
    as_excel_date(Date.civil(2008,1,1)).should == 39448
  end
  
  it "should convert objects of class DateTime" do
    as_excel_date(DateTime.new(2008,1,1,12,45)).should == 39448.53125
  end
  
  it "should convert objects of class Time" do
    as_excel_date(Time.gm(2008,1,1,12,45)).should == 39448.53125
  end
end

describe Utilities, "hex function" do
  it "should description" do
    (0...200).each do |i|
      hex(i).to_i(16).should == i
    end
  end
end

describe Utilities, "cell references" do
  it "should convert column name into number" do
    col_by_name("A").should eql(0)
    col_by_name("Z").should eql(25)
    col_by_name("AA").should eql(26)
    col_by_name("AB").should eql(27)
    col_by_name("IV").should eql(MAX_COL-1)
  end

  it "should convert valid single cell references" do
    cell_to_packed_rowcol("A1")
    cell_to_packed_rowcol("$A1")
    cell_to_packed_rowcol("A$1")
    cell_to_packed_rowcol("$A$1")

    cell_to_packed_rowcol("a1")
    cell_to_packed_rowcol("Z12345")
    cell_to_packed_rowcol("aA1")
  end

  it "should raise error on invalid single cell references" do
    lambda { cell_to_rowcol("AAA1") }.should raise_error("Ill-formed single cell reference AAA1")
  end
end
