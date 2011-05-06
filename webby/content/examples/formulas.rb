require 'rubygems'
require 'surpass'

book = Workbook.new
sheet = book.add_sheet

sheet.write(0, 0, "surpass #{Surpass::VERSION} running on #{RUBY_DESCRIPTION}")

sheet.write(2, 0, Formula.new("1+1"))
sheet.write(3, 0, Formula.new("-1"))
sheet.write(4, 0, Formula.new("-(1+1)"))
sheet.write(5, 0, Formula.new("-(1+1)/(-2-2)"))

sheet.write(2, 2, Formula.new("A3*B3"))
sheet.write(3, 2, Formula.new("A3*B4"))
sheet.write(4, 2, Formula.new("A6*B6"))

sheet.write(3, 3, Formula.new("5%"))

sheet.write(3, 5, Formula.new("A4*B4*sin(pi()/4)"))
sheet.write(4, 5, Formula.new("A5%*B5*pi()/1000"))

sheet.write(9, 9, Formula.new("A3>=B3"))

sheet.write(5, 2, Formula.new("C1+C2+C3+C4+C5/(C1+C2+C3+C4/(C1+C2+C3+C4/(C1+C2+C3+C4)+C5)+C5)-20.3e-2"))
sheet.write(5, 3, Formula.new("C1^2"))
sheet.write(6, 2, Formula.new("SUM(C1;C2;;;;;C3;;;C4)"))
sheet.write(6, 3, Formula.new("SUM($A$1:$C$5)"))

sheet.write(7, 0, Formula.new('"lkjljllkllkl"'))
sheet.write(7, 1, Formula.new('"yuyiyiyiyi"'))
sheet.write(7, 2, Formula.new('A8&B8&A8'))
sheet.write(7, 3, Formula.new('A8     & B8 & A8'))

sheet.write(10, 2, Formula.new('TRUE'))
sheet.write(11, 2, Formula.new('FALSE'))
sheet.write(12, 4, Formula.new('IF(A1>A2;3;"hkjhjkhk")')) # Semicolon param delim.
sheet.write(12, 5, Formula.new('IF(A1<A2 , 3 , "hkjhjkhk")')) # Try using commas + adding whitespace.
sheet.write(12, 7, Formula.new('CHOOSE(1, "a", "b")'))
sheet.write(12, 8, Formula.new('CHOOSE(2, "a", "b")'))
sheet.write(12, 9, Formula.new("CHOOSE(15, \"#{('a'..'z').to_a.join("\", \"")}\")"))

# Formulas
sheet.write(14, 0, Formula.new("pi()"))
sheet.write(14, 1, Formula.new("2*pi()"))
sheet.write(14, 2, Formula.new("sin(0)"))
sheet.write(14, 3, Formula.new('left("abcde", 2)'))
sheet.write(14, 4, Formula.new('hyperlink("http://google.com", "google")'))
sheet.write(14, 5, Formula.new("sin(pi())"))
sheet.write(14, 6, Formula.new('now()'))

book.save(__FILE__.gsub(/rb$/, "xls"))
