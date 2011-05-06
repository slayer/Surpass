require 'rubygems'
require 'surpass'

book = Workbook.new
sheet = book.add_sheet

sheet.write(0, 0, "Hello World!")

File.open(__FILE__.gsub(/rb$/, "xls"), "w") do |f|
  f.write book.data
end
