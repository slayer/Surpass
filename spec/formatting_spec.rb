require File.dirname(__FILE__) + '/spec_helper'

describe Alignment do
  before(:each) do
    @a = Alignment.new
  end

  it "should not wrap text by default" do
    @a.wrap.should eql(Alignment::NOT_WRAP_AT_RIGHT)
  end

  it "should wrap text when wrap = true" do
    @a.wrap = true
    @a.wrap.should eql(Alignment::WRAP_AT_RIGHT)
  end
  
  it "should wrap text when wrap = WRAP_AT_RIGHT" do
    @a.wrap = Alignment::WRAP_AT_RIGHT
    @a.wrap.should eql(Alignment::WRAP_AT_RIGHT)
  end
  
  it "should not wrap text when wrap = false" do
    @a.wrap = true
    @a.wrap = false
    @a.wrap.should eql(Alignment::NOT_WRAP_AT_RIGHT)
  end

  it "should not wrap text when wrap = NOT_WRAP_AT_RIGHT" do
    @a.wrap = true
    @a.wrap = Alignment::NOT_WRAP_AT_RIGHT
    @a.wrap.should eql(Alignment::NOT_WRAP_AT_RIGHT)
  end
  
  it "should raise an error if anything else passed" do
    lambda {@a.wrap = :yes}.should raise_error("I don't know how to set wrap to :yes.")
  end
end

describe Font do
  it "should raise a helpful error if someone tries to pass a string to font family" do
    font = Font.new
    lambda { font.family = 'Arial' }.should raise_error "Oops, font_family doesn't take a string. Do you want font_name instead?"
  end

  it "should raise a helpful error if someone tries to initialize a font with a string for font family" do
    lambda{ StyleFormat.new(:font_family => "Arial") }.should raise_error "Oops, font_family doesn't take a string. Do you want font_name instead?"
  end
  
  it "should not raise an error if you properly initialize font family" do
    font = Font.new
    lambda { font.family = 1 }.should_not raise_error
  end
end
