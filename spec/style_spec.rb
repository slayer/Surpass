require File.dirname(__FILE__) + '/spec_helper'

describe StyleCollection, "initialization" do
  before(:each) do
    @s = StyleCollection.new
    @font_index, @number_format_index, @alignment, @borders, @pattern, @protection = @s.default_format
  end

  it "should properly initialize the fonts hash" do
    # There is a font no. 6 here because of @default_style = StyleFormat.new
    @s.fonts.keys.sort.should eql([0,1,2,3,5,6])
  end
  
  it "should property initialize the number_formats hash" do
    keys = (0..23).to_a + (38..49).to_a
    @s.number_formats.keys.sort.should eql(keys)
  end
  
  it "should properly initialize the styles hash" do
    @s.styles.keys.sort.should eql([16])
  end
  
  it "should property initialize a default style" do
    @s.default_style.should be_kind_of(StyleFormat)
  end
  
  it "should have a valid font_index in the default_format" do
    @font_index.should eql(6)
  end

  it "should have a valid number_format_index in the default_format" do
    @number_format_index.should eql(0)
  end
  
  it "should have a valid alignment in the default_format" do
    @alignment.should be_kind_of(Alignment)
  end
  
  it "should have a valid borders in the default_format" do
    @borders.should be_kind_of(Borders)
  end
  
  it "should have a valid pattern in the default_format" do
    @pattern.should be_kind_of(Pattern)
  end
  
  it "should have a valid protection in the default_format" do
    @protection.should be_kind_of(Protection)
  end
end

describe StyleCollection, "adding new styles" do
  before(:each) do
    @s = StyleCollection.new
    @s.styles.should have(1).elements
  end
  
  it "should return the default style index when trying to add a nil style" do
    @s.add(nil).should === 16
    @s.styles.should have(1).elements
  end
  
  it "should correctly add a new blank style" do
    @s.add(StyleFormat.new).should === 0x10 + 1
    @s.styles.should have(2).elements
  end
  
  it "should not re-add an existing number format" do
    @s.number_format_index('General').should == 0
  end
  
  it "should add a new number format" do
    @s.number_format_index('never seen this before').should == 164
  end
end

describe StyleCollection, "biff" do
  before(:each) do
    @s = StyleCollection.new
  end
  
  it "should correctly convert number format data to biff" do
    @s.number_formats_biff.should === "" # Since there are no custom number formats.
  end
  
  it "should correctly convert cell styles data to biff" do
    @s.cell_styles_biff.should === File.read("spec/reference/all-cell-styles.bin")
  end
end
