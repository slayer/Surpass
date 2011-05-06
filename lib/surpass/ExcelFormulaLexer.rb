#!/usr/bin/env ruby
#
# ExcelFormula.g
# 
# Generated using ANTLR version: 3.2.1-SNAPSHOT Dec 18, 2009 04:29:28
# Ruby runtime library version: 1.3.1
# Input grammar file: ExcelFormula.g
# Generated at: 2010-06-13 10:19:27
# 

# ~~~> start load path setup
this_directory = File.expand_path( File.dirname( __FILE__ ) )
$:.unshift( this_directory ) unless $:.include?( this_directory )

antlr_load_failed = proc do
  load_path = $LOAD_PATH.map { |dir| '  - ' << dir }.join( $/ )
  raise LoadError, <<-END.strip!
  
Failed to load the ANTLR3 runtime library (version 1.3.1):

Ensure the library has been installed on your system and is available
on the load path. If rubygems is available on your system, this can
be done with the command:
  
  gem install antlr3

Current load path:
#{ load_path }

  END
end

defined?(ANTLR3) or begin
  
  # 1: try to load the ruby antlr3 runtime library from the system path
  require 'antlr3'
  
rescue LoadError
  
  # 2: try to load rubygems if it isn't already loaded
  defined?(Gem) or begin
    require 'rubygems'
  rescue LoadError
    antlr_load_failed.call
  end
  
  # 3: try to activate the antlr3 gem
  begin
    Gem.activate( 'antlr3', '= 1.3.1' )
  rescue Gem::LoadError
    antlr_load_failed.call
  end
  
  require 'antlr3'
  
end
# <~~~ end load path setup


module ExcelFormula
  # TokenData defines all of the token type integer values
  # as constants, which will be included in all 
  # ANTLR-generated recognizers.
  const_defined?(:TokenData) or TokenData = ANTLR3::TokenScheme.new

  module TokenData

    # define the token constants
    define_tokens(:GE => 8, :LT => 7, :NUM_CONST => 21, :PERCENT => 16, 
                  :REF2D => 22, :CONCAT => 10, :RP => 25, :LP => 24, :INT_CONST => 20, 
                  :STR_CONST => 19, :POWER => 15, :SUB => 12, :FUNC_CHOOSE => 30, 
                  :SEMICOLON => 28, :BANG => 26, :TRUE_CONST => 17, :EOF => -1, 
                  :MUL => 13, :ALPHA => 34, :COLON => 23, :FALSE_CONST => 18, 
                  :NAME => 31, :WS => 35, :COMMA => 29, :GT => 6, :DIGIT => 33, 
                  :DIV => 14, :EQ => 4, :FUNC_IF => 27, :QUOTENAME => 32, 
                  :LE => 9, :ADD => 11, :NE => 5)
    
  end


  class Lexer < ANTLR3::Lexer
    @grammar_home = ExcelFormula
    include TokenData

    begin
      generated_using( "ExcelFormula.g", "3.2.1-SNAPSHOT Dec 18, 2009 04:29:28", "1.3.1" )
    rescue NoMethodError => error
      error.name.to_sym == :generated_using or raise
    end
    
    RULE_NAMES   = ["EQ", "LT", "GT", "NE", "LE", "GE", "ADD", "SUB", "MUL", 
                    "DIV", "COLON", "SEMICOLON", "COMMA", "LP", "RP", "CONCAT", 
                    "PERCENT", "POWER", "BANG", "DIGIT", "INT_CONST", "NUM_CONST", 
                    "STR_CONST", "REF2D", "TRUE_CONST", "FALSE_CONST", "QUOTENAME", 
                    "FUNC_IF", "FUNC_CHOOSE", "ALPHA", "NAME", "WS"].freeze
    RULE_METHODS = [:eq!, :lt!, :gt!, :ne!, :le!, :ge!, :add!, :sub!, :mul!, 
                    :div!, :colon!, :semicolon!, :comma!, :lp!, :rp!, :concat!, 
                    :percent!, :power!, :bang!, :digit!, :int_const!, :num_const!, 
                    :str_const!, :ref_2_d!, :true_const!, :false_const!, 
                    :quotename!, :func_if!, :func_choose!, :alpha!, :name!, 
                    :ws!].freeze

    
    def initialize(input=nil, options = {})
      super(input, options)

    end
    
    # - - - - - - - - - - - lexer rules - - - - - - - - - - - -
    # lexer rule eq! (EQ)
    # (in ExcelFormula.g)
    def eq!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 1)

      type = EQ
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 340:5: '='
      match(?=)

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 1)

    end

    # lexer rule lt! (LT)
    # (in ExcelFormula.g)
    def lt!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 2)

      type = LT
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 341:5: '<'
      match(?<)

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 2)

    end

    # lexer rule gt! (GT)
    # (in ExcelFormula.g)
    def gt!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 3)

      type = GT
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 342:5: '>'
      match(?>)

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 3)

    end

    # lexer rule ne! (NE)
    # (in ExcelFormula.g)
    def ne!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 4)

      type = NE
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 343:5: '<>'
      match("<>")

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 4)

    end

    # lexer rule le! (LE)
    # (in ExcelFormula.g)
    def le!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 5)

      type = LE
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 344:5: '<='
      match("<=")

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 5)

    end

    # lexer rule ge! (GE)
    # (in ExcelFormula.g)
    def ge!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 6)

      type = GE
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 345:5: '>='
      match(">=")

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 6)

    end

    # lexer rule add! (ADD)
    # (in ExcelFormula.g)
    def add!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 7)

      type = ADD
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 347:6: '+'
      match(?+)

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 7)

    end

    # lexer rule sub! (SUB)
    # (in ExcelFormula.g)
    def sub!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 8)

      type = SUB
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 348:6: '-'
      match(?-)

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 8)

    end

    # lexer rule mul! (MUL)
    # (in ExcelFormula.g)
    def mul!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 9)

      type = MUL
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 349:6: '*'
      match(?*)

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 9)

    end

    # lexer rule div! (DIV)
    # (in ExcelFormula.g)
    def div!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 10)

      type = DIV
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 350:6: '/'
      match(?/)

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 10)

    end

    # lexer rule colon! (COLON)
    # (in ExcelFormula.g)
    def colon!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 11)

      type = COLON
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 352:8: ':'
      match(?:)

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 11)

    end

    # lexer rule semicolon! (SEMICOLON)
    # (in ExcelFormula.g)
    def semicolon!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 12)

      type = SEMICOLON
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 353:12: ';'
      match(?;)

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 12)

    end

    # lexer rule comma! (COMMA)
    # (in ExcelFormula.g)
    def comma!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 13)

      type = COMMA
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 354:8: ','
      match(?,)

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 13)

    end

    # lexer rule lp! (LP)
    # (in ExcelFormula.g)
    def lp!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 14)

      type = LP
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 356:5: '('
      match(?()

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 14)

    end

    # lexer rule rp! (RP)
    # (in ExcelFormula.g)
    def rp!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 15)

      type = RP
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 357:5: ')'
      match(?))

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 15)

    end

    # lexer rule concat! (CONCAT)
    # (in ExcelFormula.g)
    def concat!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 16)

      type = CONCAT
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 358:9: '&'
      match(?&)

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 16)

    end

    # lexer rule percent! (PERCENT)
    # (in ExcelFormula.g)
    def percent!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 17)

      type = PERCENT
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 359:10: '\\%'
      match(?\%)

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 17)

    end

    # lexer rule power! (POWER)
    # (in ExcelFormula.g)
    def power!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 18)

      type = POWER
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 360:8: '^'
      match(?^)

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 18)

    end

    # lexer rule bang! (BANG)
    # (in ExcelFormula.g)
    def bang!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 19)

      type = BANG
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 361:7: '!'
      match(?!)

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 19)

    end

    # lexer rule digit! (DIGIT)
    # (in ExcelFormula.g)
    def digit!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 20)

      
      # - - - - main rule block - - - -
      # at line 363:17: '0' .. '9'
      match_range(?0, ?9)

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 20)

    end

    # lexer rule int_const! (INT_CONST)
    # (in ExcelFormula.g)
    def int_const!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 21)

      type = INT_CONST
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 365:12: ( DIGIT )+
      # at file 365:12: ( DIGIT )+
      match_count_1 = 0
      loop do
        alt_1 = 2
        look_1_0 = @input.peek(1)

        if (look_1_0.between?(?0, ?9)) 
          alt_1 = 1

        end
        case alt_1
        when 1
          # at line 365:12: DIGIT
          digit!

        else
          match_count_1 > 0 and break
          eee = EarlyExit(1)


          raise eee
        end
        match_count_1 += 1
      end


      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 21)

    end

    # lexer rule num_const! (NUM_CONST)
    # (in ExcelFormula.g)
    def num_const!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 22)

      type = NUM_CONST
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 366:12: ( DIGIT )* '.' ( DIGIT )+ ( ( 'E' | 'e' ) ( '+' | '-' )? ( DIGIT )+ )?
      # at line 366:12: ( DIGIT )*
      loop do # decision 2
        alt_2 = 2
        look_2_0 = @input.peek(1)

        if (look_2_0.between?(?0, ?9)) 
          alt_2 = 1

        end
        case alt_2
        when 1
          # at line 366:12: DIGIT
          digit!

        else
          break # out of loop for decision 2
        end
      end # loop for decision 2
      match(?.)
      # at file 366:23: ( DIGIT )+
      match_count_3 = 0
      loop do
        alt_3 = 2
        look_3_0 = @input.peek(1)

        if (look_3_0.between?(?0, ?9)) 
          alt_3 = 1

        end
        case alt_3
        when 1
          # at line 366:23: DIGIT
          digit!

        else
          match_count_3 > 0 and break
          eee = EarlyExit(3)


          raise eee
        end
        match_count_3 += 1
      end

      # at line 366:30: ( ( 'E' | 'e' ) ( '+' | '-' )? ( DIGIT )+ )?
      alt_6 = 2
      look_6_0 = @input.peek(1)

      if (look_6_0 == ?E || look_6_0 == ?e) 
        alt_6 = 1
      end
      case alt_6
      when 1
        # at line 366:31: ( 'E' | 'e' ) ( '+' | '-' )? ( DIGIT )+
        if @input.peek(1) == ?E || @input.peek(1) == ?e
          @input.consume
        else
          mse = MismatchedSet(nil)
          recover(mse)
          raise mse
        end


        # at line 366:41: ( '+' | '-' )?
        alt_4 = 2
        look_4_0 = @input.peek(1)

        if (look_4_0 == ?+ || look_4_0 == ?-) 
          alt_4 = 1
        end
        case alt_4
        when 1
          # at line 
          if @input.peek(1) == ?+ || @input.peek(1) == ?-
            @input.consume
          else
            mse = MismatchedSet(nil)
            recover(mse)
            raise mse
          end



        end
        # at file 366:52: ( DIGIT )+
        match_count_5 = 0
        loop do
          alt_5 = 2
          look_5_0 = @input.peek(1)

          if (look_5_0.between?(?0, ?9)) 
            alt_5 = 1

          end
          case alt_5
          when 1
            # at line 366:52: DIGIT
            digit!

          else
            match_count_5 > 0 and break
            eee = EarlyExit(5)


            raise eee
          end
          match_count_5 += 1
        end


      end

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 22)

    end

    # lexer rule str_const! (STR_CONST)
    # (in ExcelFormula.g)
    def str_const!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 23)

      type = STR_CONST
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 367:12: '\"' (~ '\"' )+ '\"'
      match(?")
      # at file 367:16: (~ '\"' )+
      match_count_7 = 0
      loop do
        alt_7 = 2
        look_7_0 = @input.peek(1)

        if (look_7_0.between?(0x0000, ?!) || look_7_0.between?(?#, 0xFFFF)) 
          alt_7 = 1

        end
        case alt_7
        when 1
          # at line 367:17: ~ '\"'
          if @input.peek(1).between?(0x0000, ?!) || @input.peek(1).between?(?#, 0x00FF)
            @input.consume
          else
            mse = MismatchedSet(nil)
            recover(mse)
            raise mse
          end



        else
          match_count_7 > 0 and break
          eee = EarlyExit(7)


          raise eee
        end
        match_count_7 += 1
      end

      match(?")

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 23)

    end

    # lexer rule ref_2_d! (REF2D)
    # (in ExcelFormula.g)
    def ref_2_d!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 24)

      type = REF2D
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 368:8: ( '$' )? ( 'A' .. 'I' )? ( 'A' .. 'Z' ) ( '$' )? ( DIGIT )+
      # at line 368:8: ( '$' )?
      alt_8 = 2
      look_8_0 = @input.peek(1)

      if (look_8_0 == ?$) 
        alt_8 = 1
      end
      case alt_8
      when 1
        # at line 368:8: '$'
        match(?$)

      end
      # at line 368:13: ( 'A' .. 'I' )?
      alt_9 = 2
      look_9_0 = @input.peek(1)

      if (look_9_0.between?(?A, ?I)) 
        look_9_1 = @input.peek(2)

        if (look_9_1.between?(?A, ?Z)) 
          alt_9 = 1
        end
      end
      case alt_9
      when 1
        # at line 368:14: 'A' .. 'I'
        match_range(?A, ?I)

      end
      # at line 368:25: ( 'A' .. 'Z' )
      # at line 368:26: 'A' .. 'Z'
      match_range(?A, ?Z)

      # at line 368:36: ( '$' )?
      alt_10 = 2
      look_10_0 = @input.peek(1)

      if (look_10_0 == ?$) 
        alt_10 = 1
      end
      case alt_10
      when 1
        # at line 368:36: '$'
        match(?$)

      end
      # at file 368:41: ( DIGIT )+
      match_count_11 = 0
      loop do
        alt_11 = 2
        look_11_0 = @input.peek(1)

        if (look_11_0.between?(?0, ?9)) 
          alt_11 = 1

        end
        case alt_11
        when 1
          # at line 368:41: DIGIT
          digit!

        else
          match_count_11 > 0 and break
          eee = EarlyExit(11)


          raise eee
        end
        match_count_11 += 1
      end


      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 24)

    end

    # lexer rule true_const! (TRUE_CONST)
    # (in ExcelFormula.g)
    def true_const!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 25)

      type = TRUE_CONST
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 369:13: ( 'T' | 't' ) ( 'R' | 'r' ) ( 'U' | 'u' ) ( 'E' | 'e' )
      if @input.peek(1) == ?T || @input.peek(1) == ?t
        @input.consume
      else
        mse = MismatchedSet(nil)
        recover(mse)
        raise mse
      end


      if @input.peek(1) == ?R || @input.peek(1) == ?r
        @input.consume
      else
        mse = MismatchedSet(nil)
        recover(mse)
        raise mse
      end


      if @input.peek(1) == ?U || @input.peek(1) == ?u
        @input.consume
      else
        mse = MismatchedSet(nil)
        recover(mse)
        raise mse
      end


      if @input.peek(1) == ?E || @input.peek(1) == ?e
        @input.consume
      else
        mse = MismatchedSet(nil)
        recover(mse)
        raise mse
      end



      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 25)

    end

    # lexer rule false_const! (FALSE_CONST)
    # (in ExcelFormula.g)
    def false_const!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 26)

      type = FALSE_CONST
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 370:14: ( 'F' | 'f' ) ( 'A' | 'a' ) ( 'L' | 'l' ) ( 'S' | 's' ) ( 'E' | 'e' )
      if @input.peek(1) == ?F || @input.peek(1) == ?f
        @input.consume
      else
        mse = MismatchedSet(nil)
        recover(mse)
        raise mse
      end


      if @input.peek(1) == ?A || @input.peek(1) == ?a
        @input.consume
      else
        mse = MismatchedSet(nil)
        recover(mse)
        raise mse
      end


      if @input.peek(1) == ?L || @input.peek(1) == ?l
        @input.consume
      else
        mse = MismatchedSet(nil)
        recover(mse)
        raise mse
      end


      if @input.peek(1) == ?S || @input.peek(1) == ?s
        @input.consume
      else
        mse = MismatchedSet(nil)
        recover(mse)
        raise mse
      end


      if @input.peek(1) == ?E || @input.peek(1) == ?e
        @input.consume
      else
        mse = MismatchedSet(nil)
        recover(mse)
        raise mse
      end



      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 26)

    end

    # lexer rule quotename! (QUOTENAME)
    # (in ExcelFormula.g)
    def quotename!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 27)

      type = QUOTENAME
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 371:12: '\\'(?:[^\\']|\\'\\')*\\''
      match("'(?:[^']|'')*'")

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 27)

    end

    # lexer rule func_if! (FUNC_IF)
    # (in ExcelFormula.g)
    def func_if!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 28)

      type = FUNC_IF
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 372:10: 'IF'
      match("IF")

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 28)

    end

    # lexer rule func_choose! (FUNC_CHOOSE)
    # (in ExcelFormula.g)
    def func_choose!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 29)

      type = FUNC_CHOOSE
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 373:14: 'CHOOSE'
      match("CHOOSE")

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 29)

    end

    # lexer rule alpha! (ALPHA)
    # (in ExcelFormula.g)
    def alpha!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 30)

      
      # - - - - main rule block - - - -
      # at line 
      if @input.peek(1).between?(?A, ?Z) || @input.peek(1).between?(?a, ?z)
        @input.consume
      else
        mse = MismatchedSet(nil)
        recover(mse)
        raise mse
      end



    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 30)

    end

    # lexer rule name! (NAME)
    # (in ExcelFormula.g)
    def name!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 31)

      type = NAME
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 376:7: ( ALPHA )+
      # at file 376:7: ( ALPHA )+
      match_count_12 = 0
      loop do
        alt_12 = 2
        look_12_0 = @input.peek(1)

        if (look_12_0.between?(?A, ?Z) || look_12_0.between?(?a, ?z)) 
          alt_12 = 1

        end
        case alt_12
        when 1
          # at line 376:7: ALPHA
          alpha!

        else
          match_count_12 > 0 and break
          eee = EarlyExit(12)


          raise eee
        end
        match_count_12 += 1
      end


      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 31)

    end

    # lexer rule ws! (WS)
    # (in ExcelFormula.g)
    def ws!
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 32)

      type = WS
      channel = ANTLR3::DEFAULT_CHANNEL

      
      # - - - - main rule block - - - -
      # at line 378:5: ( ' ' )+
      # at file 378:5: ( ' ' )+
      match_count_13 = 0
      loop do
        alt_13 = 2
        look_13_0 = @input.peek(1)

        if (look_13_0 == ?\s) 
          alt_13 = 1

        end
        case alt_13
        when 1
          # at line 378:6: ' '
          match(?\s)

        else
          match_count_13 > 0 and break
          eee = EarlyExit(13)


          raise eee
        end
        match_count_13 += 1
      end

      # --> action
      skip()
      # <-- action

      
      @state.type = type
      @state.channel = channel

    ensure
      # -> uncomment the next line to manually enable rule tracing
      # trace_out(__method__, 32)

    end

    # main rule used to study the input at the current position,
    # and choose the proper lexer rule to call in order to
    # fetch the next token
    # 
    # usually, you don't make direct calls to this method,
    # but instead use the next_token method, which will
    # build and emit the actual next token
    def token!
      # at line 1:8: ( EQ | LT | GT | NE | LE | GE | ADD | SUB | MUL | DIV | COLON | SEMICOLON | COMMA | LP | RP | CONCAT | PERCENT | POWER | BANG | INT_CONST | NUM_CONST | STR_CONST | REF2D | TRUE_CONST | FALSE_CONST | QUOTENAME | FUNC_IF | FUNC_CHOOSE | NAME | WS )
      alt_14 = 30
      alt_14 = @dfa14.predict(@input)
      case alt_14
      when 1
        # at line 1:10: EQ
        eq!

      when 2
        # at line 1:13: LT
        lt!

      when 3
        # at line 1:16: GT
        gt!

      when 4
        # at line 1:19: NE
        ne!

      when 5
        # at line 1:22: LE
        le!

      when 6
        # at line 1:25: GE
        ge!

      when 7
        # at line 1:28: ADD
        add!

      when 8
        # at line 1:32: SUB
        sub!

      when 9
        # at line 1:36: MUL
        mul!

      when 10
        # at line 1:40: DIV
        div!

      when 11
        # at line 1:44: COLON
        colon!

      when 12
        # at line 1:50: SEMICOLON
        semicolon!

      when 13
        # at line 1:60: COMMA
        comma!

      when 14
        # at line 1:66: LP
        lp!

      when 15
        # at line 1:69: RP
        rp!

      when 16
        # at line 1:72: CONCAT
        concat!

      when 17
        # at line 1:79: PERCENT
        percent!

      when 18
        # at line 1:87: POWER
        power!

      when 19
        # at line 1:93: BANG
        bang!

      when 20
        # at line 1:98: INT_CONST
        int_const!

      when 21
        # at line 1:108: NUM_CONST
        num_const!

      when 22
        # at line 1:118: STR_CONST
        str_const!

      when 23
        # at line 1:128: REF2D
        ref_2_d!

      when 24
        # at line 1:134: TRUE_CONST
        true_const!

      when 25
        # at line 1:145: FALSE_CONST
        false_const!

      when 26
        # at line 1:157: QUOTENAME
        quotename!

      when 27
        # at line 1:167: FUNC_IF
        func_if!

      when 28
        # at line 1:175: FUNC_CHOOSE
        func_choose!

      when 29
        # at line 1:187: NAME
        name!

      when 30
        # at line 1:192: WS
        ws!

      end
    end

    
    # - - - - - - - - - - DFA definitions - - - - - - - - - - -
    class DFA14 < ANTLR3::DFA
      EOT = unpack(2, -1, 1, 34, 1, 36, 13, -1, 1, 37, 3, -1, 6, 30, 1, 
                   -1, 2, 30, 8, -1, 3, 30, 1, 45, 3, 30, 1, -1, 2, 30, 
                   1, 51, 1, 30, 1, 53, 1, -1, 1, 30, 1, -1, 1, 55, 1, -1)
      EOF = unpack(56, -1)
      MIN = unpack(1, 32, 1, -1, 2, 61, 13, -1, 1, 46, 3, -1, 3, 36, 1, 
                   82, 1, 36, 1, 65, 1, -1, 2, 36, 8, -1, 1, 36, 1, 76, 
                   1, 85, 2, 36, 1, 83, 1, 69, 1, -1, 1, 79, 1, 69, 1, 65, 
                   1, 83, 1, 65, 1, -1, 1, 69, 1, -1, 1, 65, 1, -1)
      MAX = unpack(1, 122, 1, -1, 1, 62, 1, 61, 13, -1, 1, 57, 3, -1, 1, 
                   97, 1, 114, 1, 57, 1, 114, 1, 90, 1, 97, 1, -1, 2, 90, 
                   8, -1, 2, 108, 1, 117, 1, 122, 1, 79, 1, 115, 1, 101, 
                   1, -1, 1, 79, 1, 101, 1, 122, 1, 83, 1, 122, 1, -1, 1, 
                   69, 1, -1, 1, 122, 1, -1)
      ACCEPT = unpack(1, -1, 1, 1, 2, -1, 1, 7, 1, 8, 1, 9, 1, 10, 1, 11, 
                      1, 12, 1, 13, 1, 14, 1, 15, 1, 16, 1, 17, 1, 18, 1, 
                      19, 1, -1, 1, 21, 1, 22, 1, 23, 6, -1, 1, 26, 2, -1, 
                      1, 29, 1, 30, 1, 4, 1, 5, 1, 2, 1, 6, 1, 3, 1, 20, 
                      7, -1, 1, 27, 5, -1, 1, 24, 1, -1, 1, 25, 1, -1, 1, 
                      28)
      SPECIAL = unpack(56, -1)
      TRANSITION = [
        unpack(1, 31, 1, 16, 1, 19, 1, -1, 1, 20, 1, 14, 1, 13, 1, 27, 1, 
               11, 1, 12, 1, 6, 1, 4, 1, 10, 1, 5, 1, 18, 1, 7, 10, 17, 
               1, 8, 1, 9, 1, 2, 1, 1, 1, 3, 2, -1, 2, 29, 1, 28, 2, 29, 
               1, 21, 2, 29, 1, 25, 10, 23, 1, 22, 6, 23, 3, -1, 1, 15, 
               2, -1, 5, 30, 1, 26, 13, 30, 1, 24, 6, 30),
        unpack(),
        unpack(1, 33, 1, 32),
        unpack(1, 35),
        unpack(),
        unpack(),
        unpack(),
        unpack(),
        unpack(),
        unpack(),
        unpack(),
        unpack(),
        unpack(),
        unpack(),
        unpack(),
        unpack(),
        unpack(),
        unpack(1, 18, 1, -1, 10, 17),
        unpack(),
        unpack(),
        unpack(),
        unpack(1, 20, 11, -1, 10, 20, 7, -1, 1, 38, 25, 23, 6, -1, 1, 39),
        unpack(1, 20, 11, -1, 10, 20, 24, -1, 1, 40, 31, -1, 1, 40),
        unpack(1, 20, 11, -1, 10, 20),
        unpack(1, 40, 31, -1, 1, 40),
        unpack(1, 20, 11, -1, 10, 20, 7, -1, 5, 23, 1, 41, 20, 23),
        unpack(1, 39, 31, -1, 1, 39),
        unpack(),
        unpack(1, 20, 11, -1, 10, 20, 7, -1, 7, 23, 1, 42, 18, 23),
        unpack(1, 20, 11, -1, 10, 20, 7, -1, 26, 23),
        unpack(),
        unpack(),
        unpack(),
        unpack(),
        unpack(),
        unpack(),
        unpack(),
        unpack(),
        unpack(1, 20, 11, -1, 10, 20, 18, -1, 1, 43, 31, -1, 1, 43),
        unpack(1, 43, 31, -1, 1, 43),
        unpack(1, 44, 31, -1, 1, 44),
        unpack(1, 20, 11, -1, 10, 20, 7, -1, 26, 30, 6, -1, 26, 30),
        unpack(1, 20, 11, -1, 10, 20, 21, -1, 1, 46),
        unpack(1, 47, 31, -1, 1, 47),
        unpack(1, 48, 31, -1, 1, 48),
        unpack(),
        unpack(1, 49),
        unpack(1, 50, 31, -1, 1, 50),
        unpack(26, 30, 6, -1, 26, 30),
        unpack(1, 52),
        unpack(26, 30, 6, -1, 26, 30),
        unpack(),
        unpack(1, 54),
        unpack(),
        unpack(26, 30, 6, -1, 26, 30),
        unpack()
      ].freeze
      
      ( 0 ... MIN.length ).zip( MIN, MAX ) do | i, a, z |
        if a > 0 and z < 0
          MAX[ i ] %= 0x10000
        end
      end
      
      @decision = 14
      

      def description
        <<-'__dfa_description__'.strip!
          1:1: Tokens : ( EQ | LT | GT | NE | LE | GE | ADD | SUB | MUL | DIV | COLON | SEMICOLON | COMMA | LP | RP | CONCAT | PERCENT | POWER | BANG | INT_CONST | NUM_CONST | STR_CONST | REF2D | TRUE_CONST | FALSE_CONST | QUOTENAME | FUNC_IF | FUNC_CHOOSE | NAME | WS );
        __dfa_description__
      end
    end

    
    private
    
    def initialize_dfas
      super rescue nil
      @dfa14 = DFA14.new(self, 14)

    end
  end # class Lexer < ANTLR3::Lexer

  at_exit { Lexer.main(ARGV) } if __FILE__ == $0
end

