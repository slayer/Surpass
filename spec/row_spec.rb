require File.dirname(__FILE__) + '/spec_helper'

describe Row, "various classes of input" do
  it "should write" do
    @w = Workbook.new
    @s = @w.add_sheet
    
    data = []
    data << ["Empty String", ""]
    data << ["Nil", nil]
    
    data.each_with_index do |a, i|
      label, value = a
      @s.write(i, 0, label + ":")
      @s.write(i, 1, value)
    end
    @w.save("spec/output/cells.xls")
  end
end