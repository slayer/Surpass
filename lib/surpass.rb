module Surpass

  # :stopdoc:
  VERSION = '0.1.0'
  LIBPATH = ::File.expand_path(::File.dirname(__FILE__)) + ::File::SEPARATOR
  PATH = ::File.dirname(LIBPATH) + ::File::SEPARATOR
  # :startdoc:

  # Returns the version string for the library.
  #
  def self.version
    VERSION
  end

  # Returns the library path for the module. If any arguments are given,
  # they will be joined to the end of the libray path using
  # <tt>File.join</tt>.
  #
  def self.libpath( *args )
    args.empty? ? LIBPATH : ::File.join(LIBPATH, args.flatten)
  end

  # Returns the lpath for the module. If any arguments are given,
  # they will be joined to the end of the path using
  # <tt>File.join</tt>.
  #
  def self.path( *args )
    args.empty? ? PATH : ::File.join(PATH, args.flatten)
  end

  # Utility method used to require all files ending in .rb that lie in the
  # directory below this file that has the same name as the filename passed
  # in. Optionally, a specific _directory_ name can be passed in such that
  # the _filename_ does not have to be equivalent to the directory.
  #
  def self.require_all_libs_relative_to( fname, dir = "." )
    dir ||= ::File.basename(fname, '.*')
    search_me = ::File.expand_path(
        ::File.join(::File.dirname(fname), dir, '**', '*.rb'))

    Dir.glob(search_me).sort.each do |rb|
      next if File.basename(rb) === File.basename(__FILE__) # skip surpass.rb
      next if File.basename(rb) =~ /^ExcelFormula/ unless FORMULAS_AVAILABLE
      next if File.basename(rb) =~ /^excel_magic/ # already loaded this
      require rb
    end
  end

end  # module Surpass

begin
  require 'rubygems'
  require 'antlr3'
  FORMULAS_AVAILABLE = true
rescue Exception => e
  puts "antlr3 gem not found, formulas not available. Install antlr3 to enable formulas."
  FORMULAS_AVAILABLE = false
end

require File.join(File.dirname(__FILE__), 'surpass', 'excel_magic')
include ExcelMagic
Surpass.require_all_libs_relative_to(__FILE__)
require 'date'

