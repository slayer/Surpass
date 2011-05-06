require "lib/surpass"

class Parent
  def index
    0
  end
end

cell = FormulaCell.new(Parent.new, 0, 0, ExcelFormula.new("1"))

File.open("formula-cell.bin", "w") do |f|
  f.write cell.to_biff
end

