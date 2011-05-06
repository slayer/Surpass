require 'rubygems'
require 'surpass'

book = Workbook.new
sheet = book.add_sheet("Patterns")

sheet.write(0, 0, "surpass #{Surpass::VERSION} running on #{RUBY_DESCRIPTION}")

per_row = 19

Pattern.fill_directives.sort.each_with_index do |c, i|
  format = StyleFormat.new
  format.pattern.pattern = c
  
  row = i % per_row + 1
  label_column = (i/per_row)*2
  pattern_column = (i/per_row)*2 + 1
  
  sheet.write(row, label_column,  c, :font_size => 14)
  sheet.write(row, pattern_column, nil, format)
  
  sheet.write(row, pattern_column + 1, nil, :pattern_fore_colour => 'green', :fill_pattern => c)
  sheet.write(row, pattern_column + 2, nil, :pattern_fore_colour => 'yellow', :pattern_back_colour => 'blue', :fill_pattern => c)
  
  sheet.set_column_width(label_column, 30)
end

book.save(__FILE__.gsub(/rb$/, "xls"))
