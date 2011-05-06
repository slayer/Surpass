require "lib/surpass"

book = Workbook.new
sheet = book.add_sheet

sheet.write(0, 0, "surpass #{Surpass::VERSION} running on #{RUBY_DESCRIPTION}")


sheet.write(0, 0, 1)
sheet.write(1, 0, 1.23)
sheet.write(2, 0, 12345678)
sheet.write(3, 0, 123456.78)

sheet.write(0, 1, -1)
sheet.write(1, 1, -1.23)
sheet.write(2, 1, -12345678)
sheet.write(3, 1, -123456.78)

sheet.write(0, 2, -17867868678687.0)
sheet.write(1, 2, -1.23e-5)
sheet.write(2, 2, -12345678.90780980)
sheet.write(3, 2, -123456.78)

sheet.write(0, 4, true)

book.save(__FILE__.gsub(/rb$/, "xls"))
