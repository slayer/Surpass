require "lib/surpass"

book = Workbook.new
sheet = book.add_sheet

sheet.write(0, 0, "surpass #{Surpass::VERSION} running on #{RUBY_DESCRIPTION}")


font0 = Font.new
font0.name = 'Times New Roman'

style0 = StyleFormat.new
style0.font = font0


sheet.write_array_to_column(methods.sort, 0, 0, style0)

sheet.write(5, 5, methods.sort)

sheet.write(7, 3, %w{a b c d e})

sheet.write(9, 3, [%w{x y z}, [1, 2, 3]])

book.save(__FILE__.gsub(/rb$/, "xls"))
