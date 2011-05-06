require "lib/surpass"

book = Workbook.new
sheet = book.add_sheet

sheet.write(0, 0, "surpass #{Surpass::VERSION} running on #{RUBY_DESCRIPTION}")

strings = File.read("spec/data/random-strings.txt").split("\n")

colcount = 100 + 1
rowcount = 100 + 1

start = Time.now
puts "starting at #{start.to_s}"

colcount.times do |c|
  rowcount.times do |r|
    i = c * rowcount + r
    sheet.write(r+1, c, strings[i])
  end
end

t = Time.now - start
puts "time elapsed (writing data to workbook) #{t.to_s}"

book.save(__FILE__.gsub(/rb$/, "xls"))

t = Time.now - start
puts "time elapsed (writing workbook to file) #{t.to_s}"
