require 'rubygems'
require 'surpass'

book = Workbook.new(__FILE__.gsub(/rb$/, "xls"))
sheet = book.add_sheet

sheet.write(0, 0, "surpass #{Surpass::VERSION} running on #{RUBY_DESCRIPTION}")

date_format = StyleFormat.new(:number_format_string => 'DDD MMM YYYY')
sheet.write(2, 0, Date.today, date_format)

two_dp_format = StyleFormat.new
two_dp_format.number_format_string = "#,##0.00"
sheet.write(2, 1, 1002.71828, two_dp_format)

book.save
