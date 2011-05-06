require 'rubygems'
require 'surpass'

book = Workbook.new
sheet = book.add_sheet("Borders")

sheet.write(0, 0, "surpass #{Surpass::VERSION} running on #{RUBY_DESCRIPTION}")

per_row = 18

Borders.line_type_directives.sort.each_with_index do |c, i|
  format = StyleFormat.new
  format.borders.all = c
  sheet.write(i*2+2, 1, c, format)
end

book.save(__FILE__.gsub(/rb$/, "xls"))
