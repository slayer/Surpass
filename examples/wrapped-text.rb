require "lib/surpass"

book = Workbook.new
sheet = book.add_sheet

sheet.write(0, 0, "surpass #{Surpass::VERSION} running on #{RUBY_DESCRIPTION}")

text = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

wrapped_text_format = StyleFormat.new(:text_wrap => true, :text_align => 'justify')

sheet.set_column_width(0, 40)
sheet.write(2, 0, text, wrapped_text_format)

book.save(__FILE__.gsub(/rb$/, "xls"))
