require "lib/surpass"

book = Workbook.new
sheet = book.add_sheet

sheet.write(0, 0, "surpass #{Surpass::VERSION} running on #{RUBY_DESCRIPTION}")

font0 = Font.new
font0.name = 'Times New Roman'
font0.struck_out = true
font0.bold = true

style0 = StyleFormat.new
style0.font = font0

sheet.write(1, 1, 'Test', style0)

0.upto(13) do |i|
    borders = Borders.new
    borders.left = i
    borders.right = i
    borders.top = i
    borders.bottom = i

    style = StyleFormat.new
    style.borders = borders

    sheet.write(i+1, 2, '', style)
    sheet.write(i+1, 3, hex(i), style0)
end

sheet.write_merge(5, 8, 6, 10, "")

book.save(__FILE__.gsub(/rb$/, "xls"))
