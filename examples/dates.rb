require "lib/surpass"

book = Workbook.new
sheet = book.add_sheet

sheet.write(0, 0, "surpass #{Surpass::VERSION} running on #{RUBY_DESCRIPTION}")

formats = [
    'M/D/YY',
    'D-MMM-YY',
    'D-MMM',
    'MMM-YY',
    'h:mm AM/PM',
    'h:mm:ss AM/PM',
    'h:mm',
    'h:mm:ss',
    'M/D/YY h:mm',
    'mm:ss',
    '[h]:mm:ss',
    'mm:ss.0',
]

formats.each_with_index do |f, i|
  sheet.write(i, 0, f)
  
  style = StyleFormat.new
  style.number_format_string = f
  
  sheet.write(i, 4, Time.now, style)
end

book.save(__FILE__.gsub(/rb$/, "xls"))
