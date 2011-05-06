require "lib/surpass"

book = Workbook.new
sheet = book.add_sheet("col widths")

sheet.write(0, 0, "surpass #{Surpass::VERSION} running on #{RUBY_DESCRIPTION}")

(6...80).each do |i|
    fnt = Font.new
    fnt.height = i*20
    style = StyleFormat.new
    style.font = fnt
    sheet.write(1, i, 'Test')
    sheet.set_column_width(i, i)
end

book.save(__FILE__.gsub(/rb$/, "xls"))
