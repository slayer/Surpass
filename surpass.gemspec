# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{surpass}
  s.version = "0.0.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ana Nelson"]
  s.date = %q{2010-04-23}
  s.default_executable = %q{surpass}
  s.description = %q{Surpass is writing (and eventually reading) excel workbooks in pure Ruby. Surpass is based on xlwt (and pyExcelerator).

For comprehensive documentation, please refer to the PDF manual which is available from http://surpass.rubyforge.org or in the root directory of the source code repository.

If you like to learn from playing with working examples, then there are plenty in the examples/ and webby/examples directories of the source code.}
  s.email = %q{ana@ananelson.com}
  s.executables = ["surpass"]
  s.extra_rdoc_files = ["History.txt", "LICENSE.txt", "README.txt", "bin/surpass", "lib/surpass/ExcelFormula.g", "lib/surpass/ExcelFormulaGrammar.g", "lib/surpass/ExcelFormulaGrammar.tokens", "lib/surpass/tokens.txt"]
  s.files = ["History.txt", "LICENSE.txt", "README.txt", "Rakefile", "bin/surpass", "lib/surpass.rb", "lib/surpass/ExcelFormula.g", "lib/surpass/ExcelFormulaGrammar.g", "lib/surpass/ExcelFormulaGrammar.tokens", "lib/surpass/ExcelFormulaGrammarLexer.rb", "lib/surpass/ExcelFormulaGrammarParser.rb", "lib/surpass/biff_record.rb", "lib/surpass/bitmap.rb", "lib/surpass/cell.rb", "lib/surpass/chart.rb", "lib/surpass/column.rb", "lib/surpass/document.rb", "lib/surpass/excel_formula.rb", "lib/surpass/excel_magic.rb", "lib/surpass/formatting.rb", "lib/surpass/row.rb", "lib/surpass/style.rb", "lib/surpass/tokens.txt", "lib/surpass/utilities.rb", "lib/surpass/workbook.rb", "lib/surpass/worksheet.rb", "surpass.gemspec"]
  s.homepage = %q{http://surpass.rubyforge.org}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{surpass}
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Surpass is writing (and eventually reading) excel workbooks in pure Ruby}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bones>, [">= 3.4.1"])
    else
      s.add_dependency(%q<bones>, [">= 3.4.1"])
    end
  else
    s.add_dependency(%q<bones>, [">= 3.4.1"])
  end
end
