require "lib/surpass"

book = Workbook.new

sheet1 = book.add_sheet
sheet2 = book.add_sheet
sheet3 = book.add_sheet
sheet4 = book.add_sheet
sheet5 = book.add_sheet
sheet6 = book.add_sheet

sheet1.write(0, 0, "surpass #{Surpass::VERSION} running on #{RUBY_DESCRIPTION}")

0.upto(0x100) do |i|
  sheet1.write(i/0x10+1, i%0x10, i)
  sheet2.write(i/0x10+1, i%0x10, i)
  sheet3.write(i/0x10+1, i%0x10, i)
  sheet4.write(i/0x10+1, i%0x10, i)
  sheet5.write(i/0x10+1, i%0x10, i)
  sheet6.write(i/0x10+1, i%0x10, i)
end

sheet1.panes_frozen = true
sheet1.horz_split_pos = 2

sheet2.panes_frozen = true
sheet2.vert_split_pos = 2

sheet3.panes_frozen = true
sheet3.horz_split_pos = 1
sheet3.vert_split_pos = 1

sheet4.panes_frozen = false
sheet4.horz_split_pos = 12
sheet4.horz_split_first_visible = 2

sheet5.panes_frozen = false
sheet5.vert_split_pos = 40
sheet4.vert_split_first_visible = 2

sheet6.panes_frozen = false
sheet6.horz_split_pos = 12
sheet4.horz_split_first_visible = 2
sheet6.vert_split_pos = 40
sheet4.vert_split_first_visible = 2

book.save(__FILE__.gsub(/rb$/, "xls"))

