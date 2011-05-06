require "lib/surpass"

book = Workbook.new
sheet = book.add_sheet

sheet.write(0, 0, "surpass #{Surpass::VERSION} running on #{RUBY_DESCRIPTION}")

fnt1 = Font.new
fnt1.name = 'Verdana'
fnt1.bold = true
fnt1.height = 18*0x14

pat1 = Pattern.new
pat1.pattern = Pattern::SOLID_PATTERN
pat1.pattern_fore_colour = 0x16

brd1 = Borders.new
brd1.left = 0x06
brd1.right = 0x06
brd1.top = 0x06
brd1.bottom = 0x06

fnt2 = Font.new
fnt2.name = 'Verdana'
fnt2.bold = true
fnt2.height = 14*0x14

brd2 = Borders.new
brd2.left = 0x01
brd2.right = 0x01
brd2.top = 0x01
brd2.bottom = 0x01

pat2 = Pattern.new
pat2.pattern = Pattern::SOLID_PATTERN
pat2.pattern_fore_colour = 0x01F

fnt3 = Font.new
fnt3.name = 'Verdana'
fnt3.bold = true
fnt3.italic = true
fnt3.height = 12*0x14

brd3 = Borders.new
brd3.left = 0x07
brd3.right = 0x07
brd3.top = 0x07
brd3.bottom = 0x07

fnt4 = Font.new

al1 = Alignment.new
al1.horz = Alignment::HORZ_CENTER
al1.vert = Alignment::VERT_CENTER

al2 = Alignment.new
al2.horz = Alignment::HORZ_RIGHT
al2.vert = Alignment::VERT_CENTER

al3 = Alignment.new
al3.horz = Alignment::HORZ_LEFT
al3.vert = Alignment::VERT_CENTER

style1 = StyleFormat.new
style1.font = fnt1
style1.alignment = al1
style1.pattern = pat1
style1.borders = brd1

style2 = StyleFormat.new
style2.font = fnt2
style2.alignment = al1
style2.pattern = pat2
style2.borders = brd2

style3 = StyleFormat.new
style3.font = fnt3
style3.alignment = al1
style3.pattern = pat2
style3.borders = brd3

price_style = StyleFormat.new
price_style.font = fnt4
price_style.alignment = al2
price_style.borders = brd3
price_style.number_format_string = '_(#,##0.00_) "money"'

ware_style = StyleFormat.new
ware_style.font = fnt4
ware_style.alignment = al3
ware_style.borders = brd3


sheet.merge(3, 3, 1, 5, style1)
sheet.merge(4, 10, 1, 6, style2)
sheet.merge(14, 16, 1, 7, style3)
sheet.set_column_width(1, 0x0d00)


book.save(__FILE__.gsub(/rb$/, "xls"))

