require "lib/surpass"

book = Workbook.new
sheet = book.add_sheet("Image")

sheet.write(0, 0, "surpass #{Surpass::VERSION} running on #{RUBY_DESCRIPTION}")

# TODO As this example shows, there is a bug in the size calculation somewhere.
sheet.set_column_width(2, 20)
sheet.insert_bitmap('examples/python.bmp', 2, 2)
sheet.insert_bitmap('examples/python.bmp', 15, 0)

book.save(__FILE__.gsub(/rb$/, "xls"))
