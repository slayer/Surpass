require "lib/surpass"

book = Workbook.new
sheet = book.add_sheet

sheet.write(0, 0, "Hello World")

book.save(__FILE__.gsub(/rb$/, "xls"))
