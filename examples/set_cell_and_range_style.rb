require "lib/surpass"

book = Workbook.new
sheet = book.add_sheet

sheet.write(0, 0, "surpass #{Surpass::VERSION} running on #{RUBY_DESCRIPTION}")

sheet.write_arrays(0, 0, [%w{a b c d e}, %w{F G H I J}, %w{k l m n o}])

sheet.set_cell_style(2, 2, StyleFormat.new(:font_color => "yellow"))
sheet.set_range_style(0..1, 1..2, StyleFormat.new(:font_color => "purple"))

book.save(__FILE__.gsub(/rb$/, "xls"))
