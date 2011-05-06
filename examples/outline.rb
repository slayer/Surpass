require "lib/surpass"

book = Workbook.new
sheet = book.add_sheet("Rows Outline")

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

book = Workbook.new

sheet = book.add_sheet('Rows Outline')

sheet.write_merge(1, 1, 1, 5, 'test 1', style)
sheet.write_merge(2, 2, 1, 4, 'test 1', style)
sheet.write_merge(3, 3, 1, 3, 'test 2', style)
sheet.write_merge(4, 4, 1, 4, 'test 1', style)
sheet.write_merge(5, 5, 1, 4, 'test 3', style)
sheet.write_merge(6, 6, 1, 5, 'test 1', style)
sheet.write_merge(7, 7, 1, 5, 'test 4', style)
sheet.write_merge(8, 8, 1, 4, 'test 1', style)
sheet.write_merge(9, 9, 1, 3, 'test 5', style)

sheet.row(1).level = 1
sheet.row(2).level = 1
sheet.row(3).level = 2
sheet.row(4).level = 2
sheet.row(5).level = 2
sheet.row(6).level = 2
sheet.row(7).level = 2
sheet.row(8).level = 1
sheet.row(9).level = 1


ws1 = book.add_sheet('Columns Outline')

ws1.write_merge(1, 1, 1, 5, 'test 1', style)
ws1.write_merge(2, 2, 1, 4, 'test 1', style)
ws1.write_merge(3, 3, 1, 3, 'test 2', style)
ws1.write_merge(4, 4, 1, 4, 'test 1', style)
ws1.write_merge(5, 5, 1, 4, 'test 3', style)
ws1.write_merge(6, 6, 1, 5, 'test 1', style)
ws1.write_merge(7, 7, 1, 5, 'test 4', style)
ws1.write_merge(8, 8, 1, 4, 'test 1', style)
ws1.write_merge(9, 9, 1, 3, 'test 5', style)

ws1.col(1).level = 1
ws1.col(2).level = 1
ws1.col(3).level = 2
ws1.col(4).level = 2
ws1.col(5).level = 2
ws1.col(6).level = 2
ws1.col(7).level = 2
ws1.col(8).level = 1
ws1.col(9).level = 1


ws2 = book.add_sheet('Rows and Columns Outline')

ws2.write_merge(1, 1, 1, 5, 'test 1', style)
ws2.write_merge(2, 2, 1, 4, 'test 1', style)
ws2.write_merge(3, 3, 1, 3, 'test 2', style)
ws2.write_merge(4, 4, 1, 4, 'test 1', style)
ws2.write_merge(5, 5, 1, 4, 'test 3', style)
ws2.write_merge(6, 6, 1, 5, 'test 1', style)
ws2.write_merge(7, 7, 1, 5, 'test 4', style)
ws2.write_merge(8, 8, 1, 4, 'test 1', style)
ws2.write_merge(9, 9, 1, 3, 'test 5', style)

ws2.row(1).level = 1
ws2.row(2).level = 1
ws2.row(3).level = 2
ws2.row(4).level = 2
ws2.row(5).level = 2
ws2.row(6).level = 2
ws2.row(7).level = 2
ws2.row(8).level = 1
ws2.row(9).level = 1

ws2.write_merge(1, 1, 1, 5, 'test 1', style)
ws2.write_merge(2, 2, 1, 4, 'test 1', style)
ws2.write_merge(3, 3, 1, 3, 'test 2', style)
ws2.write_merge(4, 4, 1, 4, 'test 1', style)
ws2.write_merge(5, 5, 1, 4, 'test 3', style)
ws2.write_merge(6, 6, 1, 5, 'test 1', style)
ws2.write_merge(7, 7, 1, 5, 'test 4', style)
ws2.write_merge(8, 8, 1, 4, 'test 1', style)
ws2.write_merge(9, 9, 1, 3, 'test 5', style)

ws2.col(1).level = 1
ws2.col(2).level = 1
ws2.col(3).level = 2
ws2.col(4).level = 2
ws2.col(5).level = 2
ws2.col(6).level = 2
ws2.col(7).level = 2
ws2.col(8).level = 1
ws2.col(9).level = 1


book.save(__FILE__.gsub(/rb$/, "xls"))
