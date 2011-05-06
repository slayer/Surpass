require File.dirname(__FILE__) + '/spec_helper'

describe NumberCell, "to_biff" do
  before(:all) do
    @w = Workbook.new
    @s = @w.add_sheet('rk_tests')
  end
  
  it "should encode with rk_encode" do
    TEST_VALUES.each_with_index do |x, i|
      # Write original test values
      @s.write(i, 0, x)

      # Write test values divided by 100
      @s.write(i, 3, x/100.00)

      # Write negative of test values
      @s.write(i, 6, x)

      # Write negative test values divided by 100
      @s.write(i, 9, -x/100.00)
    end
  end
  
  after(:all) do
    @w.save("spec/output/cells-rk.xls")
  end
end

TEST_VALUES = [
    130.63999999999999,
    130.64,
    -18.649999999999999,
    -18.65,
    137.19999999999999,
    137.20,
    -16.079999999999998,
    -16.08,
    0,
    1,
    2,
    3,
    0x1fffffff,
    0x20000000,
    0x20000001,
    1000999999,
    0x3fffffff,
    0x40000000,
    0x40000001,
    0x7fffffff,
    0x80000000,
    0x80000001,
    0xffffffff,
    0x100000000,
    0x100000001
]