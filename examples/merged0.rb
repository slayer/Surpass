require "lib/surpass"

book = Workbook.new
sheet = book.add_sheet

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

style = StyleFormat.new
style.font = fnt
style.borders = borders

sheet.write_merge(3, 3, 1, 5, 'test1', style)
sheet.write_merge(4, 10, 1, 5, 'test2', style)
sheet.set_column_width(1, 0x0d00)

book.save(__FILE__.gsub(/rb$/, "xls"))
