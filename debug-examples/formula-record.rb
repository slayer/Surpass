require "lib/surpass"

class Parent
  def index
    0
  end
end

rpn = ExcelFormula.new("1").to_biff
record = FormulaRecord.new(0, 0, 0, rpn)

File.open("formula-record.bin", "w") do |f|
  f.write record.to_biff
end

