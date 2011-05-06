require File.dirname(__FILE__) + '/spec_helper'


describe Formula, "parsing primary objects" do
  it "should parse the TRUE constant" do
    Formula.new("TRUE").to_biff.should eql("\002\000\035\001")
  end
  
  it "should parse the FALSE constant" do
    Formula.new("FALSE").to_biff.should eql("\002\000\035\000")
  end

  it "should parse a short string" do
    Formula.new('"x"').to_biff.should eql("\004\000\027\001\000x")
  end

  it "should parse a string" do
    Formula.new('"Oklahoma!!!"').to_biff.should eql("\016\000\027\v\000Oklahoma!!!")
  end

  it "should parse single digit integers" do
    Formula.new("1").to_biff.should eql("\003\000\036\001\000")
  end

  it "should parse two digit integers" do
    Formula.new("11").to_biff.should eql("\003\000\036\v\000")
  end

  it "should parse big integers" do
    Formula.new("70000").to_biff.should eql("\t\000\037\000\000\000\000\000\027\361@")
  end

  it "should parse numbers with decimals" do
    Formula.new("1.5").to_biff.should eql("\t\000\037\000\000\000\000\000\000\370?")
  end
end

describe Formula, "parsing expr" do
  it "should parse equality" do
    Formula.new("1=1").to_biff.should eql("\a\000\036\001\000\036\001\000\v")
  end

  it "should parse sum" do
    Formula.new("1+1").to_biff.should eql("\a\000\036\001\000\036\001\000\003") #TODO check
  end
end
