class Formula
  NO_CALCS=0x00
  RECALC_ALWAYS=0x01
  CALC_ON_OPEN=0x02
  PART_OF_SHARED_FORMULA=0x08

  attr_reader :parser

  def initialize(formula_string)
    raise "formulas not available" unless FORMULAS_AVAILABLE
    @lexer = ExcelFormula::Lexer.new(formula_string)
    @parser = ExcelFormula::Parser.new(@lexer)
    begin
      @parser.formula
    rescue RuntimeError => e
      puts e
      raise "invalid Excel formula"
    end
  end

  def to_biff
    rpn = @parser.rpn
    [rpn.length].pack('v') + rpn
  end
end
