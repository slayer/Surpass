require "lib/surpass"

book = Workbook.new
sheet0 = book.add_sheet
sheet1 = book.add_sheet
sheet2 = book.add_sheet

sheet.write(0, 0, "surpass #{Surpass::VERSION} running on #{RUBY_DESCRIPTION}")

fnt = Font.new
fnt.name = 'Arial'
fnt.colour_index = 4
fnt.bold = true

borders = Borders.new
borders.left = 6
borders.right = 6
borders.top = 6
borders.bottom = 6

al = Alignment.new
al.horz = Alignment::HORZ_CENTER
al.vert = Alignment::VERT_CENTER

style = StyleFormat.new
style.font = fnt
style.borders = borders
style.alignment = al

(0...0x200).step(2) do |i|
  sheet0.write_merge(i+1, i+1, 1, 5, "test #{i}", style)
  sheet1.write_merge(i+1, i, 1, 7, "test #{i}", style)
  sheet2.write_merge(i+1, i+1, 1, 7 + (i%10), "test #{i}", style)
end

book.save(__FILE__.gsub(/rb$/, "xls"))
