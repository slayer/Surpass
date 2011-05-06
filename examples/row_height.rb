require 'rubygems'
require 'surpass'

book = Workbook.new
sheet = book.add_sheet

top_align = StyleFormat.new(:text_align => 'top')
bottom_align = StyleFormat.new(:text_align => 'bottom')

(10..40).each do |i|
  sheet.write(i-10, 0, i)
  sheet.write(i-10, 1, 'top', top_align)
  sheet.write(i-10, 2, 'bottom', bottom_align)

  sheet.row(i-10).set_height i
end

book.save(__FILE__.gsub(/rb$/, "xls"))
