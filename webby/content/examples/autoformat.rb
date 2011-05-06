require 'rubygems'
require 'surpass'

book = Workbook.new(__FILE__.gsub(/rb$/, "xls"))
sheet = book.add_sheet

row = -1

sheet.write(row += 1, 0, "surpass #{Surpass::VERSION} running on #{RUBY_DESCRIPTION}")

# Passing true for the style parameter to write will invoke autoformatting.
sheet.write(row+=2, 0, "Hello World!", true)
sheet.write(row+=1, 0, 1, true)
sheet.write(row+=1, 0, 1.0, true)
sheet.write(row+=1, 0, Date.today, true)
sheet.write(row+=1, 0, DateTime.now, true)
sheet.write(row+=1, 0, Time.now, true)

array_of_arrays = [
  [1, 2, 3],
  [1.0, 2.0, 3.0],
  [Date.today, DateTime.now],
  %w{a b c}
]

# Writing arrays will automatically autoformat...
sheet.write(row+=3, 0, "With autoformat:")
sheet.write_arrays(row+=1, 0, array_of_arrays)

# ...unless you specify your own format, or nil for a generic default.
sheet.write(row+=10, 0, "Without autoformat:")
sheet.write_arrays(row+=1, 0, array_of_arrays, nil)

sheet.set_column_widths(0..2, 20)

book.save
