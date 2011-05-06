# Look in the tasks/setup.rb file for the various options that can be
# configured in this Rakefile. The .rake files in the tasks directory
# are where the options are used.

begin
  require 'bones'
rescue LoadError
  abort '### Please install the "bones" gem ###'
end

require 'lib/surpass'

Bones {
  name     'surpass'
  authors  'Ana Nelson'
  email    'ana@ananelson.com'
  url      'http://surpass.rubyforge.org'
  version  Surpass::VERSION
}

task :default => 'spec:run'
task 'gem:release' => 'test:run'

desc "run antlr compiler"
task :antlr do
  `cd lib/surpass; antlr4ruby ExcelFormula.g`
end

desc "run examples"
task :examples do
  `rm examples/*.xls`
  `cd examples; ls *.rb`.chomp.split.each do |f|
      next if f =~ /big/
     `jruby #{File.expand_path(f, "examples")}`
  end
end
