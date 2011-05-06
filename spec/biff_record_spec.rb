require File.dirname(__FILE__) + '/spec_helper'

describe InterfaceHeaderRecord do
  it "should pack correctly" do
    b = InterfaceHeaderRecord.new
    b.to_biff.unpack('M*').should === ["\341\000\002\000\260\004"]
  end
end

describe InterfaceEndRecord do
  it "should pack correctly" do
    b = InterfaceEndRecord.new
    b.to_biff.unpack('M*').should === ["\342\000\000\000"]
  end
end

describe MMSRecord do
  it "should pack correctly" do
    b = MMSRecord.new
    b.to_biff.unpack('M*').should === ["\301\000\002\000\000\000"]
  end
end

describe WriteAccessRecord do
  it "should pack correctly" do
    b = WriteAccessRecord.new("Ana")
    b.to_biff.unpack('M*').should === ["\\\000p\000Ana" + " " * 109]
  end
end

describe DSFRecord do
  it "should pack correctly" do
    b = DSFRecord.new
    b.to_biff.unpack('M*').should === ["a\001\002\000\000\000"]
  end
end

describe TabIDRecord do
  it "should pack correctly" do
    b = TabIDRecord.new(2)
    b.record_data.should === "\001\000\002\000"
    b.to_biff.unpack('A*').should === ["=\001\004\000\001\000\002"]
  end
end

describe FnGroupCountRecord do
  it "should pack correctly" do
    b = FnGroupCountRecord.new
    b.record_data.should === "\016\000"
    b.to_biff.unpack('A*').should === ["\234\000\002\000\016"]
  end
end

describe WindowProtectRecord do
  it "should pack correctly" do
    b = WindowProtectRecord.new(0)
    b.record_data.should === "\000\000"
    b.to_biff.unpack('A*').should === ["\031\000\002"]
  end
end

describe ObjectProtectRecord do
  it "should pack correctly" do
    b = ObjectProtectRecord.new(0)
    b.record_data.should === "\000\000"
    b.to_biff.unpack('A*').should === ["c\000\002"]
  end
end

describe ScenarioProtectRecord do
  it "should pack correctly" do
    b = ScenarioProtectRecord.new(0)
    b.record_data.should === "\000\000"
    b.to_biff.unpack('A*').should === ["\335\000\002"]
  end
end

describe PasswordRecord do
  before(:each) do
    @b = PasswordRecord.new
  end
  it "should pack correctly with blank password" do
    @b.password_hash("").should == 0
  end
  
  it "should pack correctly with a password of 123456" do
    @b.password_hash("123456").should === 50975
  end
  
  it "should pack correctly with a password of abcdefghij" do
    @b.password_hash("abcdefghij").should == 65265
  end
  
  it "should pack correctly with a password of ok" do
    @b.password_hash("ok").should == 53051
  end
end

describe Prot4RevRecord do
  it "should pack correctly" do
    b = Prot4RevRecord.new
    b.record_data.should === "\000\000"
    b.to_biff.unpack('A*').should === ["\257\001\002"]
  end
end

describe Prot4RevPassRecord do
  it "should pack correctly" do
    b = Prot4RevPassRecord.new
    b.record_data.should === "\000\000"
    b.to_biff.unpack('A*').should === ["\274\001\002"]
  end
end

describe BackupRecord do
  it "should pack correctly" do
    b = BackupRecord.new(0)
    b.record_data.should === "\000\000"
    b.to_biff.unpack('A*').should === ["@\000\002"]
  end
end

describe HideObjRecord do
  it "should pack correctly" do
    b = HideObjRecord.new
    b.record_data.should === "\000\000"
    b.to_biff.unpack('A*').should === ["\215\000\002"]
  end
end

describe RefreshAllRecord do
  it "should pack correctly" do
    b = RefreshAllRecord.new
    b.record_data.should === "\000\000"
    b.to_biff.unpack('A*').should === ["\267\001\002"]
  end
end

describe BookBoolRecord do
  it "should pack correctly" do
    b = BookBoolRecord.new
    b.record_data.should === "\000\000"
    b.to_biff.unpack('A*').should === ["\332\000\002"]
  end
end

describe CountryRecord do
  it "should pack correctly" do
    b = CountryRecord.new(1,1)
    b.record_data.should === "\001\000\001\000"
    b.to_biff.unpack('A*').should === ["\332\000\004\000\001\000\001"]
  end
end

describe UseSelfsRecord do
  it "should pack correctly" do
    b = UseSelfsRecord.new
    b.record_data.should === "\001\000"
    b.to_biff.unpack('A*').should === ["`\001\002\000\001"]
  end
end

describe EOFRecord do
  it "should pack correctly" do
    b = EOFRecord.new
    b.record_data.should === ""
    b.to_biff.unpack('A*').should === ["\n"]
  end
end

describe DateModeRecord do
  it "should pack correctly when passed true" do
    b = DateModeRecord.new(true)
    b.record_data.should === "\001\000"
    b.to_biff.unpack('A*').should === ["\"\000\002\000\001"]
  end
  it "should pack correctly when passed false" do
    b = DateModeRecord.new(false)
    b.record_data.should === "\000\000"
    b.to_biff.unpack('A*').should === ["\"\000\002"]
  end
end

describe PrecisionRecord do
  it "should pack correctly when passed true" do
    b = PrecisionRecord.new(true)
    b.record_data.should === "\001\000"
    b.to_biff.unpack('A*').should === ["\016\000\002\000\001"]
  end
  it "should pack correctly when passed false" do
    b = PrecisionRecord.new(false)
    b.record_data.should === "\000\000"
    b.to_biff.unpack('A*').should === ["\016\000\002"]
  end
end

describe CodepageBiff8Record do
  it "should pack correctly" do
    b = CodepageBiff8Record.new
    b.record_data.should === "\260\004"
    b.to_biff.unpack('A*').should === ["B\000\002\000\260\004"]
  end
end

describe Window1Record do
  it "should pack correctly" do
    b = Window1Record.new(1,1,1,1,1,1,1,1,1)
    b.record_data.should === "\001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000"
    b.to_biff.unpack('A*').should === ["=\000\022\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\001"]
  end
end

describe FontRecord do
  it "should pack correctly" do
    
    b = FontRecord.new(200,0,32767,400,0,0,0,204,"Arial")
    b.record_data.should === "\310\000\000\000\377\177\220\001\000\000\000\000\314\000\005\000Arial" 
  end
end

# describe XFRecord do
#   it "should pack correctly" do
#     b = XFRecord.new([1,1,Alignment.new,Borders.new,Pattern.new,Protection.new])
#     puts binary_string_to_hex_array(b.record_data)
#     b.record_data.should === "\001\000\001\000\001\000"
#     b.to_biff.unpack('A*').should === ["\257\001\002"]
#   end
# end

describe StyleRecord do
  it "should pack correctly" do
    b = StyleRecord.new
    b.record_data.should ===  "\000\200\000\377"
    b.to_biff.unpack('A*').should === ["\223\002\004\000\000\200\000\377"]
  end
end

describe BoundSheetRecord do
  it "should pack correctly" do
    b = BoundSheetRecord.new(0, 0, "x")
    b.record_data.should ===  "\000\000\000\000\000\000\001\000x"
    b.to_biff.unpack('A*').should === ["\205\000\t\000\000\000\000\000\000\000\001\000x"]
  end
end

# describe ExtSSTRecord do
#   it "should pack correctly" do
#     b = ExtSSTRecord.new(1,[1],1)
#     b.record_data.should === "\000\000"
#     b.to_biff.unpack('A*').should === ["\257\001\002"]
#   end
# end

describe DimensionsRecord do
  it "should pack correctly" do
    b = DimensionsRecord.new(0,0,5,5)
    b.record_data.should === "\000\000\000\000\001\000\000\000\005\000\006\000\000\000"
    b.to_biff.unpack('A*').should === ["\000\002\016\000\000\000\000\000\001\000\000\000\005\000\006"]
  end
end

# describe MergedCellsRecord do
#   it "should pack correctly" do
#     b = MergedCellsRecord.new([[1,1,2,2]])
#     b.record_data.should ===  "\345\000\n\000\001\000\001\000\001\000\002\000\002\000"
#     b.to_biff.unpack('A*').should === ["\345\000\n\000\001\000\001\000\001\000\002\000\002"] 
#   end
# end