require "lib/surpass"

book = Workbook.new
sheet = book.add_sheet

sheet.write(0, 0, "surpass #{Surpass::VERSION} running on #{RUBY_DESCRIPTION}")

style0 = StyleFormat.new(:font_name => 'Times New Roman', :font_struck_out => true, :font_bold => true)

sheet.write(1, 1, 'Test', style0)

(0...14).each do |i|
  style = StyleFormat.new(:font_name => 'Arial', :font_color_index => i, :font_outline => true)

  borders = Borders.new
  borders.left = i

  style.borders = borders

  sheet.write(i, 2, 'colour', style)
  sheet.write(i, 3, hex(i), style0)
end

book.save(__FILE__.gsub(/rb$/, "xls"))
