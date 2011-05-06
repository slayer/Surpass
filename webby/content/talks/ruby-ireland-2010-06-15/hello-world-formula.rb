require 'rubygems'
require 'surpass'

book = Workbook.new("hello-world-formula.xls")
sheet = book.add_sheet

sheet.write(0, 0, Formula.new("hello, world!"))

book.save

