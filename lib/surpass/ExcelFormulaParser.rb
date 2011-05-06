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

# - - - - - - begin action @parser::header - - - - - -
# ExcelFormula.g


  RVA_DELTA = {"R" => 0, "V" => 0x20, "A" => 0x40}
  RVA_DELTA_REF = {"R" => 0, "V" => 0x20, "A" => 0x40, "D" => 0x20}
  RVA_DELTA_AREA = {"R" => 0, "V" => 0x20, "A" => 0x40, "D" => 0}

# - - - - - - end action @parser::header - - - - - - -


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
                  :MUL => 13, :ALPHA => 34, :COLON => 23, :NAME => 31, :FALSE_CONST => 18, 
                  :WS => 35, :COMMA => 29, :GT => 6, :DIGIT => 33, :EQ => 4, 
                  :DIV => 14, :FUNC_IF => 27, :QUOTENAME => 32, :LE => 9, 
                  :NE => 5, :ADD => 11)

    # register the proper human-readable name or literal value
    # for each token type
    #
    # this is necessary because anonymous tokens, which are
    # created from literal values in the grammar, do not
    # have descriptive names
    register_names("EQ", "NE", "GT", "LT", "GE", "LE", "CONCAT", "ADD", 
                   "SUB", "MUL", "DIV", "POWER", "PERCENT", "TRUE_CONST", 
                   "FALSE_CONST", "STR_CONST", "INT_CONST", "NUM_CONST", 
                   "REF2D", "COLON", "LP", "RP", "BANG", "FUNC_IF", "SEMICOLON", 
                   "COMMA", "FUNC_CHOOSE", "NAME", "QUOTENAME", "DIGIT", 
                   "ALPHA", "WS")
    
  end


  class Parser < ANTLR3::Parser
    @grammar_home = ExcelFormula

    RULE_METHODS = [:formula, :expr, :prec0_expr, :prec1_expr, :prec2_expr, 
                    :prec3_expr, :prec4_expr, :prec5_expr, :primary, :expr_list, 
                    :sheet].freeze


    include TokenData

    generated_using( "ExcelFormula.g", "3.2.1-SNAPSHOT Dec 18, 2009 04:29:28", "1.3.1" )

    def initialize(input, options = {})
      super(input, options)

      # - - - - - - begin action @parser::init - - - - - -
      # ExcelFormula.g


        @rpn = ''
        @sheet_references = []
        @xcall_references = []

      # - - - - - - end action @parser::init - - - - - - -


    end

      attr_accessor :rpn

    # - - - - - - - - - - - - Rules - - - - - - - - - - - - -

    # parser rule formula
    # 
    # (in ExcelFormula.g)
    # 24:1: formula : expr[\"V\"] ;
    def formula
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 1)

      begin
        # at line 25:7: expr[\"V\"]
        @state.following.push(TOKENS_FOLLOWING_expr_IN_formula_56)
        expr("V")
        @state.following.pop

      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)

      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out(__method__, 1)

      end
      
      return 
    end


    # parser rule expr
    # 
    # (in ExcelFormula.g)
    # 28:1: expr[arg_type] : prec0_expr[arg_type] ( ( EQ | NE | GT | LT | GE | LE ) prec0_expr[arg_type] )* ;
    def expr(arg_type)
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 2)

      begin
        # at line 29:7: prec0_expr[arg_type] ( ( EQ | NE | GT | LT | GE | LE ) prec0_expr[arg_type] )*
        @state.following.push(TOKENS_FOLLOWING_prec0_expr_IN_expr_75)
        prec0_expr(arg_type)
        @state.following.pop
        # at line 30:9: ( ( EQ | NE | GT | LT | GE | LE ) prec0_expr[arg_type] )*
        loop do # decision 2
          alt_2 = 2
          alt_2 = @dfa2.predict(@input)
          case alt_2
          when 1
            # at line 31:13: ( EQ | NE | GT | LT | GE | LE ) prec0_expr[arg_type]
            # at line 31:13: ( EQ | NE | GT | LT | GE | LE )
            alt_1 = 6
            case look_1 = @input.peek(1)
            when EQ then alt_1 = 1
            when NE then alt_1 = 2
            when GT then alt_1 = 3
            when LT then alt_1 = 4
            when GE then alt_1 = 5
            when LE then alt_1 = 6
            else
              nvae = NoViableAlternative("", 1, 0)
              raise nvae
            end
            case alt_1
            when 1
              # at line 32:19: EQ
              match(EQ, TOKENS_FOLLOWING_EQ_IN_expr_120)
              # --> action
               op = [PTGEQ].pack('C') 
              # <-- action

            when 2
              # at line 33:19: NE
              match(NE, TOKENS_FOLLOWING_NE_IN_expr_142)
              # --> action
               op = [PTGNE].pack('C') 
              # <-- action

            when 3
              # at line 34:19: GT
              match(GT, TOKENS_FOLLOWING_GT_IN_expr_164)
              # --> action
               op = [PTGGT].pack('C') 
              # <-- action

            when 4
              # at line 35:19: LT
              match(LT, TOKENS_FOLLOWING_LT_IN_expr_186)
              # --> action
               op = [PTGLT].pack('C') 
              # <-- action

            when 5
              # at line 36:19: GE
              match(GE, TOKENS_FOLLOWING_GE_IN_expr_208)
              # --> action
               op = [PTGGE].pack('C') 
              # <-- action

            when 6
              # at line 37:19: LE
              match(LE, TOKENS_FOLLOWING_LE_IN_expr_230)
              # --> action
               op = [PTGLE].pack('C') 
              # <-- action

            end
            @state.following.push(TOKENS_FOLLOWING_prec0_expr_IN_expr_261)
            prec0_expr(arg_type)
            @state.following.pop
            # --> action
             @rpn += op 
            # <-- action

          else
            break # out of loop for decision 2
          end
        end # loop for decision 2

      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)

      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out(__method__, 2)

      end
      
      return 
    end


    # parser rule prec0_expr
    # 
    # (in ExcelFormula.g)
    # 44:1: prec0_expr[arg_type] : prec1_expr[arg_type] ( ( CONCAT ) prec1_expr[arg_type] )* ;
    def prec0_expr(arg_type)
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 3)

      begin
        # at line 45:7: prec1_expr[arg_type] ( ( CONCAT ) prec1_expr[arg_type] )*
        @state.following.push(TOKENS_FOLLOWING_prec1_expr_IN_prec0_expr_293)
        prec1_expr(arg_type)
        @state.following.pop
        # at line 46:9: ( ( CONCAT ) prec1_expr[arg_type] )*
        loop do # decision 3
          alt_3 = 2
          alt_3 = @dfa3.predict(@input)
          case alt_3
          when 1
            # at line 47:13: ( CONCAT ) prec1_expr[arg_type]
            # at line 47:13: ( CONCAT )
            # at line 48:17: CONCAT
            match(CONCAT, TOKENS_FOLLOWING_CONCAT_IN_prec0_expr_336)
            # --> action
             op = [PTGCONCAT].pack('C') 
            # <-- action

            @state.following.push(TOKENS_FOLLOWING_prec1_expr_IN_prec0_expr_366)
            prec1_expr(arg_type)
            @state.following.pop
            # --> action
             @rpn += op 
            # <-- action

          else
            break # out of loop for decision 3
          end
        end # loop for decision 3

      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)

      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out(__method__, 3)

      end
      
      return 
    end


    # parser rule prec1_expr
    # 
    # (in ExcelFormula.g)
    # 54:1: prec1_expr[arg_type] : prec2_expr[arg_type] ( ( ADD | SUB ) prec2_expr[arg_type] )* ;
    def prec1_expr(arg_type)
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 4)

      begin
        # at line 55:7: prec2_expr[arg_type] ( ( ADD | SUB ) prec2_expr[arg_type] )*
        @state.following.push(TOKENS_FOLLOWING_prec2_expr_IN_prec1_expr_398)
        prec2_expr(arg_type)
        @state.following.pop
        # at line 56:9: ( ( ADD | SUB ) prec2_expr[arg_type] )*
        loop do # decision 5
          alt_5 = 2
          alt_5 = @dfa5.predict(@input)
          case alt_5
          when 1
            # at line 57:13: ( ADD | SUB ) prec2_expr[arg_type]
            # at line 57:13: ( ADD | SUB )
            alt_4 = 2
            look_4_0 = @input.peek(1)

            if (look_4_0 == ADD) 
              alt_4 = 1
            elsif (look_4_0 == SUB) 
              alt_4 = 2
            else
            nvae = NoViableAlternative("", 4, 0)
              raise nvae
            end
            case alt_4
            when 1
              # at line 58:19: ADD
              match(ADD, TOKENS_FOLLOWING_ADD_IN_prec1_expr_443)
              # --> action
               op = [PTGADD].pack('C') 
              # <-- action

            when 2
              # at line 59:19: SUB
              match(SUB, TOKENS_FOLLOWING_SUB_IN_prec1_expr_465)
              # --> action
               op = [PTGSUB].pack('C') 
              # <-- action

            end
            @state.following.push(TOKENS_FOLLOWING_prec2_expr_IN_prec1_expr_495)
            prec2_expr(arg_type)
            @state.following.pop
            # --> action
             @rpn += op 
            # <-- action

          else
            break # out of loop for decision 5
          end
        end # loop for decision 5

      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)

      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out(__method__, 4)

      end
      
      return 
    end


    # parser rule prec2_expr
    # 
    # (in ExcelFormula.g)
    # 66:1: prec2_expr[arg_type] : prec3_expr[arg_type] ( ( MUL | DIV ) prec3_expr[arg_type] )* ;
    def prec2_expr(arg_type)
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 5)

      begin
        # at line 67:7: prec3_expr[arg_type] ( ( MUL | DIV ) prec3_expr[arg_type] )*
        @state.following.push(TOKENS_FOLLOWING_prec3_expr_IN_prec2_expr_528)
        prec3_expr(arg_type)
        @state.following.pop
        # at line 68:9: ( ( MUL | DIV ) prec3_expr[arg_type] )*
        loop do # decision 7
          alt_7 = 2
          alt_7 = @dfa7.predict(@input)
          case alt_7
          when 1
            # at line 69:13: ( MUL | DIV ) prec3_expr[arg_type]
            # at line 69:13: ( MUL | DIV )
            alt_6 = 2
            look_6_0 = @input.peek(1)

            if (look_6_0 == MUL) 
              alt_6 = 1
            elsif (look_6_0 == DIV) 
              alt_6 = 2
            else
            nvae = NoViableAlternative("", 6, 0)
              raise nvae
            end
            case alt_6
            when 1
              # at line 70:19: MUL
              match(MUL, TOKENS_FOLLOWING_MUL_IN_prec2_expr_573)
              # --> action
               op = [PTGMUL].pack('C') 
              # <-- action

            when 2
              # at line 71:19: DIV
              match(DIV, TOKENS_FOLLOWING_DIV_IN_prec2_expr_595)
              # --> action
               op = [PTGDIV].pack('C') 
              # <-- action

            end
            @state.following.push(TOKENS_FOLLOWING_prec3_expr_IN_prec2_expr_625)
            prec3_expr(arg_type)
            @state.following.pop
            # --> action
             @rpn += op 
            # <-- action

          else
            break # out of loop for decision 7
          end
        end # loop for decision 7

      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)

      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out(__method__, 5)

      end
      
      return 
    end


    # parser rule prec3_expr
    # 
    # (in ExcelFormula.g)
    # 77:1: prec3_expr[arg_type] : prec4_expr[arg_type] ( ( POWER ) prec4_expr[arg_type] )* ;
    def prec3_expr(arg_type)
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 6)

      begin
        # at line 78:7: prec4_expr[arg_type] ( ( POWER ) prec4_expr[arg_type] )*
        @state.following.push(TOKENS_FOLLOWING_prec4_expr_IN_prec3_expr_657)
        prec4_expr(arg_type)
        @state.following.pop
        # at line 79:9: ( ( POWER ) prec4_expr[arg_type] )*
        loop do # decision 8
          alt_8 = 2
          alt_8 = @dfa8.predict(@input)
          case alt_8
          when 1
            # at line 80:13: ( POWER ) prec4_expr[arg_type]
            # at line 80:13: ( POWER )
            # at line 81:17: POWER
            match(POWER, TOKENS_FOLLOWING_POWER_IN_prec3_expr_700)
            # --> action
             op = [PTGPOWER].pack('C') 
            # <-- action

            @state.following.push(TOKENS_FOLLOWING_prec4_expr_IN_prec3_expr_730)
            prec4_expr(arg_type)
            @state.following.pop
            # --> action
             @rpn += op 
            # <-- action

          else
            break # out of loop for decision 8
          end
        end # loop for decision 8

      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)

      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out(__method__, 6)

      end
      
      return 
    end


    # parser rule prec4_expr
    # 
    # (in ExcelFormula.g)
    # 87:1: prec4_expr[arg_type] : prec5_expr[arg_type] ( PERCENT )? ;
    def prec4_expr(arg_type)
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 7)

      begin
        # at line 88:7: prec5_expr[arg_type] ( PERCENT )?
        @state.following.push(TOKENS_FOLLOWING_prec5_expr_IN_prec4_expr_762)
        prec5_expr(arg_type)
        @state.following.pop
        # at line 89:9: ( PERCENT )?
        alt_9 = 2
        alt_9 = @dfa9.predict(@input)
        case alt_9
        when 1
          # at line 90:13: PERCENT
          match(PERCENT, TOKENS_FOLLOWING_PERCENT_IN_prec4_expr_787)
          # --> action
           @rpn += [PTGPERCENT].pack('C') 
          # <-- action

        end

      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)

      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out(__method__, 7)

      end
      
      return 
    end


    # parser rule prec5_expr
    # 
    # (in ExcelFormula.g)
    # 94:1: prec5_expr[arg_type] : ( primary[arg_type] | SUB primary[arg_type] );
    def prec5_expr(arg_type)
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 8)

      begin
        # at line 95:5: ( primary[arg_type] | SUB primary[arg_type] )
        alt_10 = 2
        alt_10 = @dfa10.predict(@input)
        case alt_10
        when 1
          # at line 95:7: primary[arg_type]
          @state.following.push(TOKENS_FOLLOWING_primary_IN_prec5_expr_818)
          primary(arg_type)
          @state.following.pop

        when 2
          # at line 96:7: SUB primary[arg_type]
          match(SUB, TOKENS_FOLLOWING_SUB_IN_prec5_expr_827)
          @state.following.push(TOKENS_FOLLOWING_primary_IN_prec5_expr_829)
          primary(arg_type)
          @state.following.pop
          # --> action
           @rpn += [PTGUMINUS].pack('C') 
          # <-- action

        end
      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)

      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out(__method__, 8)

      end
      
      return 
    end


    # parser rule primary
    # 
    # (in ExcelFormula.g)
    # 99:1: primary[arg_type] : ( TRUE_CONST | FALSE_CONST | str_tok= STR_CONST | int_tok= INT_CONST | num_tok= NUM_CONST | ref2d_tok= REF2D | ref2d1_tok= REF2D COLON ref2d2_tok= REF2D | LP expr[arg_type] RP | sheet1= sheet ( COLON sheet2= sheet )? BANG ref3d_ref2d= REF2D ( COLON ref3d_ref2d2= REF2D )? | FUNC_IF LP expr[\"V\"] ( SEMICOLON | COMMA ) expr[arg_type] ( SEMICOLON | COMMA ) expr[arg_type] RP | FUNC_CHOOSE LP expr[\"V\"] ( ( SEMICOLON | COMMA ) ( expr[arg_type] | ) )* RP | name_tok= NAME | func_tok= NAME LP arg_count= expr_list[arg_type_list, min_argc, max_argc] RP );
    def primary(arg_type)
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 9)
      str_tok = nil
      int_tok = nil
      num_tok = nil
      ref2d_tok = nil
      ref2d1_tok = nil
      ref2d2_tok = nil
      ref3d_ref2d = nil
      ref3d_ref2d2 = nil
      name_tok = nil
      func_tok = nil
      sheet1 = nil
      sheet2 = nil
      arg_count = nil

      begin
        # at line 100:5: ( TRUE_CONST | FALSE_CONST | str_tok= STR_CONST | int_tok= INT_CONST | num_tok= NUM_CONST | ref2d_tok= REF2D | ref2d1_tok= REF2D COLON ref2d2_tok= REF2D | LP expr[arg_type] RP | sheet1= sheet ( COLON sheet2= sheet )? BANG ref3d_ref2d= REF2D ( COLON ref3d_ref2d2= REF2D )? | FUNC_IF LP expr[\"V\"] ( SEMICOLON | COMMA ) expr[arg_type] ( SEMICOLON | COMMA ) expr[arg_type] RP | FUNC_CHOOSE LP expr[\"V\"] ( ( SEMICOLON | COMMA ) ( expr[arg_type] | ) )* RP | name_tok= NAME | func_tok= NAME LP arg_count= expr_list[arg_type_list, min_argc, max_argc] RP )
        alt_15 = 13
        alt_15 = @dfa15.predict(@input)
        case alt_15
        when 1
          # at line 100:7: TRUE_CONST
          match(TRUE_CONST, TOKENS_FOLLOWING_TRUE_CONST_IN_primary_850)
          # --> action

                      @rpn += [PTGBOOL, 1].pack("C2")
                  
          # <-- action

        when 2
          # at line 104:7: FALSE_CONST
          match(FALSE_CONST, TOKENS_FOLLOWING_FALSE_CONST_IN_primary_868)
          # --> action

                      @rpn += [PTGBOOL, 0].pack("C2")
                  
          # <-- action

        when 3
          # at line 108:7: str_tok= STR_CONST
          str_tok = match(STR_CONST, TOKENS_FOLLOWING_STR_CONST_IN_primary_890)
          # --> action

                      s = str_tok.text.gsub("\"", "")
                      @rpn += [PTGSTR].pack("C") + [s.length].pack('v') + s
                  
          # <-- action

        when 4
          # at line 113:7: int_tok= INT_CONST
          int_tok = match(INT_CONST, TOKENS_FOLLOWING_INT_CONST_IN_primary_912)
          # --> action

                  int_value = int_tok.text.to_i
                  if int_value <= 65535
                      @rpn += [PTGINT, int_value].pack("Cv")
                  else
                      @rpn += [PTGNUM, int_value.to_f].pack("CE")
                  end
              
          # <-- action

        when 5
          # at line 122:7: num_tok= NUM_CONST
          num_tok = match(NUM_CONST, TOKENS_FOLLOWING_NUM_CONST_IN_primary_930)
          # --> action

                      @rpn += [PTGNUM, num_tok.text.to_f].pack("CE")
                  
          # <-- action

        when 6
          # at line 126:7: ref2d_tok= REF2D
          ref2d_tok = match(REF2D, TOKENS_FOLLOWING_REF2D_IN_primary_952)
          # --> action

                    r, c = Utilities.cell_to_packed_rowcol(ref2d_tok.text) 
                    ptg = PTGREFR + RVA_DELTA_REF[arg_type]
                    @rpn += [ptg, r, c].pack("Cv2")
                  
          # <-- action

        when 7
          # at line 132:7: ref2d1_tok= REF2D COLON ref2d2_tok= REF2D
          ref2d1_tok = match(REF2D, TOKENS_FOLLOWING_REF2D_IN_primary_974)
          match(COLON, TOKENS_FOLLOWING_COLON_IN_primary_976)
          ref2d2_tok = match(REF2D, TOKENS_FOLLOWING_REF2D_IN_primary_982)
          # --> action

                      r1, c1 = Utilities.cell_to_packed_rowcol(ref2d1_tok.text) 
                      r2, c2 = Utilities.cell_to_packed_rowcol(ref2d2_tok.text)
                      ptg = PTGAREAR + RVA_DELTA_AREA[arg_type]
                      @rpn += [ptg, r1, r2, c1, c2].pack("Cv4")
                  
          # <-- action

        when 8
          # at line 139:7: LP expr[arg_type] RP
          match(LP, TOKENS_FOLLOWING_LP_IN_primary_1000)
          @state.following.push(TOKENS_FOLLOWING_expr_IN_primary_1002)
          expr(arg_type)
          @state.following.pop
          match(RP, TOKENS_FOLLOWING_RP_IN_primary_1005)
          # --> action

                      @rpn += [PTGPAREN].pack('C')
                  
          # <-- action

        when 9
          # at line 143:7: sheet1= sheet ( COLON sheet2= sheet )? BANG ref3d_ref2d= REF2D ( COLON ref3d_ref2d2= REF2D )?
          @state.following.push(TOKENS_FOLLOWING_sheet_IN_primary_1028)
          sheet1 = sheet
          @state.following.pop
          # --> action
           
                      sheet2 = sheet1
                  
          # <-- action
          # at line 147:9: ( COLON sheet2= sheet )?
          alt_11 = 2
          look_11_0 = @input.peek(1)

          if (look_11_0 == COLON) 
            alt_11 = 1
          end
          case alt_11
          when 1
            # at line 147:11: COLON sheet2= sheet
            match(COLON, TOKENS_FOLLOWING_COLON_IN_primary_1050)
            @state.following.push(TOKENS_FOLLOWING_sheet_IN_primary_1056)
            sheet2 = sheet
            @state.following.pop

          end
          match(BANG, TOKENS_FOLLOWING_BANG_IN_primary_1061)
          ref3d_ref2d = match(REF2D, TOKENS_FOLLOWING_REF2D_IN_primary_1065)
          # --> action

                      ptg = PTGREF3DR + RVA_DELTA_REF[arg_type]
                      r1, c1 = Utilities.cell_to_packed_rowcol(ref3d_ref2d.text)
                      rpn_ref2d = [0x0000, r1, c1].pack("v3")
                  
          # <-- action
          # at line 153:9: ( COLON ref3d_ref2d2= REF2D )?
          alt_12 = 2
          alt_12 = @dfa12.predict(@input)
          case alt_12
          when 1
            # at line 153:11: COLON ref3d_ref2d2= REF2D
            match(COLON, TOKENS_FOLLOWING_COLON_IN_primary_1087)
            ref3d_ref2d2 = match(REF2D, TOKENS_FOLLOWING_REF2D_IN_primary_1092)
            # --> action

                            ptg = PTGAREA3DR + RVA_DELTA_AREA[arg_type]
                            r2, c2 = Utilities.cell_to_packed_rowcol(ref3d_ref2d2.text)
                            rpn_ref2d = [0x0000, r1, r2, c1, c2].pack("v5")
                        
            # <-- action

          end
          # --> action

                      @rpn += [ptg].pack("C")
                      @sheet_references << [sheet1, sheet2, @rpn.size]
                      @rpn += rpn_ref2d
                  
          # <-- action

        when 10
          # at line 165:7: FUNC_IF LP expr[\"V\"] ( SEMICOLON | COMMA ) expr[arg_type] ( SEMICOLON | COMMA ) expr[arg_type] RP
          match(FUNC_IF, TOKENS_FOLLOWING_FUNC_IF_IN_primary_1135)
          match(LP, TOKENS_FOLLOWING_LP_IN_primary_1145)
          @state.following.push(TOKENS_FOLLOWING_expr_IN_primary_1147)
          expr("V")
          @state.following.pop
          if @input.peek(1).between?(SEMICOLON, COMMA)
            @input.consume
            @state.error_recovery = false
          else
            mse = MismatchedSet(nil)
            raise mse
          end


          # --> action

                      @rpn += [PTGATTR, 0x02, 0].pack("C2v") # tAttrIf
                      pos0 = @rpn.size - 2
                  
          # <-- action
          @state.following.push(TOKENS_FOLLOWING_expr_IN_primary_1176)
          expr(arg_type)
          @state.following.pop
          if @input.peek(1).between?(SEMICOLON, COMMA)
            @input.consume
            @state.error_recovery = false
          else
            mse = MismatchedSet(nil)
            raise mse
          end


          # --> action

                      @rpn += [PTGATTR, 0x08, 0].pack("C2v") # tAttrSkip
                      pos1 = @rpn.size - 2

                      @rpn = @rpn[0...pos0] + [pos1-pos0].pack("v") + @rpn[(pos0+2)...(@rpn.size)] 
                  
          # <-- action
          @state.following.push(TOKENS_FOLLOWING_expr_IN_primary_1205)
          expr(arg_type)
          @state.following.pop
          match(RP, TOKENS_FOLLOWING_RP_IN_primary_1208)
          # --> action

                      @rpn += [PTGATTR, 0x08, 3].pack("C2v") # tAttrSkip
                      @rpn += [PTGFUNCVARR, 3, 1].pack("C2v") # 3 = nargs, 1 = IF func
                      pos2 = @rpn.size

                      @rpn = @rpn[0...pos1] + [pos2-(pos1+2)-1].pack("v") + @rpn[(pos1+2)...(@rpn.size)]
                  
          # <-- action

        when 11
          # at line 186:7: FUNC_CHOOSE LP expr[\"V\"] ( ( SEMICOLON | COMMA ) ( expr[arg_type] | ) )* RP
          match(FUNC_CHOOSE, TOKENS_FOLLOWING_FUNC_CHOOSE_IN_primary_1226)
          # --> action

                      arg_type = "R"
                      rpn_chunks = []
                  
          # <-- action
          match(LP, TOKENS_FOLLOWING_LP_IN_primary_1246)
          @state.following.push(TOKENS_FOLLOWING_expr_IN_primary_1248)
          expr("V")
          @state.following.pop
          # --> action

                      rpn_start = @rpn.size
                      ref_markers = [@sheet_references.size]
                  
          # <-- action
          # at line 196:9: ( ( SEMICOLON | COMMA ) ( expr[arg_type] | ) )*
          loop do # decision 14
            alt_14 = 2
            look_14_0 = @input.peek(1)

            if (look_14_0.between?(SEMICOLON, COMMA)) 
              alt_14 = 1

            end
            case alt_14
            when 1
              # at line 197:13: ( SEMICOLON | COMMA ) ( expr[arg_type] | )
              if @input.peek(1).between?(SEMICOLON, COMMA)
                @input.consume
                @state.error_recovery = false
              else
                mse = MismatchedSet(nil)
                raise mse
              end


              # --> action
               mark = @rpn.size 
              # <-- action
              # at line 199:17: ( expr[arg_type] | )
              alt_13 = 2
              alt_13 = @dfa13.predict(@input)
              case alt_13
              when 1
                # at line 200:19: expr[arg_type]
                @state.following.push(TOKENS_FOLLOWING_expr_IN_primary_1345)
                expr(arg_type)
                @state.following.pop

              when 2
                # at line 201:19: 
                # --> action
                 @rpn += [PTGMISSARG].pack("C") 
                # <-- action

              end
              # --> action

                                  rem = @rpn.size - mark
                                  rpn_chunks << @rpn[mark, rem]
                                  ref_markers << @sheet_references.size
                              
              # <-- action

            else
              break # out of loop for decision 14
            end
          end # loop for decision 14
          match(RP, TOKENS_FOLLOWING_RP_IN_primary_1423)
          # --> action

                      @rpn = @rpn[0...rpn_start]
                      nc = rpn_chunks.length
                      chunklens = rpn_chunks.collect {|c| c.length}
                      skiplens = [0] * nc
                      skiplens[nc-1] = 3

                      (nc-1).downto(1) do |i|
                        skiplens[i-1] = skiplens[i] + chunklens[i] + 4
                      end
                      jump_pos = [2*nc + 2]

                      (0...nc).each do |i|
                        jump_pos << (jump_pos.last + chunklens[i] + 4)
                      end
                      chunk_shift = 2*nc + 6 # size of tAttrChoose

                      (0...nc).each do |i|
                        (ref_markers[i]...ref_markers[i+1]).each do |r|
                          ref = @sheet_references[r]
                          @sheet_references[r] = [ref[0], ref[1], ref[2] + chunk_shift]
                        end
                        chunk_shift += 4 # size of tAttrSkip
                      end

                      choose_rpn = []
                      choose_rpn << [PTGATTR, 0x04, nc].pack("CCv") # 0x04 is tAttrChoose
                      choose_rpn << jump_pos.pack("v*")
                      
                      (0...nc).each do |i|
                        choose_rpn << rpn_chunks[i]
                        choose_rpn << [PTGATTR, 0x08, skiplens[i]].pack("CCv") # 0x08 is tAttrSkip
                      end
                      choose_rpn << [PTGFUNCVARV, nc+1, 100].pack("CCv") # 100 is CHOOSE fn
                      @rpn += choose_rpn.join
                  
          # <-- action

        when 12
          # at line 246:7: name_tok= NAME
          name_tok = match(NAME, TOKENS_FOLLOWING_NAME_IN_primary_1445)
          # --> action

                    raise "[formula] found unexpected NAME token #{name_tok.text}"
                  
          # <-- action

        when 13
          # at line 250:7: func_tok= NAME LP arg_count= expr_list[arg_type_list, min_argc, max_argc] RP
          func_tok = match(NAME, TOKENS_FOLLOWING_NAME_IN_primary_1467)
          # --> action

                    func_toku = func_tok.text.upcase
                    if STD_FUNC_BY_NAME.has_key?(func_toku)
                        opcode, min_argc, max_argc, func_type, arg_type_str = STD_FUNC_BY_NAME[func_toku]
                        arg_type_list = arg_type_str.split
                    else
                        raise "[formula] unknown function #{func_tok.text}"
                    end
                    xcall = (opcode < 0)

                    if xcall
                      @xcall_references << [func_toku, @rpn.size + 1]
                      @rpn += [PTGNAMEXR, 0xadde, 0xefbe, 0x0000].pack("Cvvv")
                    end
                  
          # <-- action
          match(LP, TOKENS_FOLLOWING_LP_IN_primary_1487)
          @state.following.push(TOKENS_FOLLOWING_expr_list_IN_primary_1493)
          arg_count = expr_list(arg_type_list, min_argc, max_argc)
          @state.following.pop
          match(RP, TOKENS_FOLLOWING_RP_IN_primary_1496)
          # --> action

                    if (arg_count > max_argc) || (arg_count < min_argc)
                       raise "incorrect number #{arg_count} of parameters for function: #{func_tok.text}"
                    end

                    if xcall
                        func_ptg = PTGFUNCVARR + RVA_DELTA[func_type]
                        @rpn += [func_ptg, arg_count + 1, 255].pack("CCv") # 255 is magic XCALL function
                    elsif (min_argc == max_argc)
                        func_ptg = PTGFUNCR + RVA_DELTA[func_type]
                        @rpn += [func_ptg, opcode].pack("Cv") 
                    elsif (arg_count == 1) && (func_tok.text.upcase === "SUM")
                        @rpn += [PTGATTR, 0x10, 0].pack("CCv") # tAttrSum
                    else
                        func_ptg = PTGFUNCVARR + RVA_DELTA[func_type]
                        @rpn += [func_ptg, arg_count, opcode].pack("CCv")
                    end
                  
          # <-- action

        end
      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)

      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out(__method__, 9)

      end
      
      return 
    end


    # parser rule expr_list
    # 
    # (in ExcelFormula.g)
    # 288:1: expr_list[arg_type_list, min_argc, max_argc] returns [arg_cnt] : ( ( expr[arg_type] ( ( SEMICOLON | COMMA ) ( expr[arg_type] | ) )* ) | );
    def expr_list(arg_type_list, min_argc, max_argc)
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 10)
      arg_cnt = nil
      # - - - - @init action - - - -

        arg_cnt = 0

        # Set these for processing first argument, 
        # it's simpler because first argument type can't be '...'
        arg_type = arg_type_list.first

        # need to check for '-' for a fn with no arguments
        arg_cnt += 1 unless arg_type === '-'


      begin
        # at line 300:5: ( ( expr[arg_type] ( ( SEMICOLON | COMMA ) ( expr[arg_type] | ) )* ) | )
        alt_18 = 2
        alt_18 = @dfa18.predict(@input)
        case alt_18
        when 1
          # at line 301:5: ( expr[arg_type] ( ( SEMICOLON | COMMA ) ( expr[arg_type] | ) )* )
          # at line 301:5: ( expr[arg_type] ( ( SEMICOLON | COMMA ) ( expr[arg_type] | ) )* )
          # at line 301:6: expr[arg_type] ( ( SEMICOLON | COMMA ) ( expr[arg_type] | ) )*
          @state.following.push(TOKENS_FOLLOWING_expr_IN_expr_list_1540)
          expr(arg_type)
          @state.following.pop
          # at line 302:9: ( ( SEMICOLON | COMMA ) ( expr[arg_type] | ) )*
          loop do # decision 17
            alt_17 = 2
            look_17_0 = @input.peek(1)

            if (look_17_0.between?(SEMICOLON, COMMA)) 
              alt_17 = 1

            end
            case alt_17
            when 1
              # at line 303:14: ( SEMICOLON | COMMA ) ( expr[arg_type] | )
              if @input.peek(1).between?(SEMICOLON, COMMA)
                @input.consume
                @state.error_recovery = false
              else
                mse = MismatchedSet(nil)
                raise mse
              end


              # --> action
               arg_cnt += 1 
              # <-- action
              # at line 304:17: ( expr[arg_type] | )
              alt_16 = 2
              alt_16 = @dfa16.predict(@input)
              case alt_16
              when 1
                # at line 306:22: expr[arg_type]
                @state.following.push(TOKENS_FOLLOWING_expr_IN_expr_list_1634)
                expr(arg_type)
                @state.following.pop
                # --> action

                                        if arg_cnt - 2 < arg_type_list.size
                                           arg_type = arg_type_list[arg_cnt - 2]
                                        else
                                          if arg_type_list.last === "..."
                                             # e.g. "V R ..." arbitrary number of args of type R
                                             # this will always be last element in arg_type_list
                                             # 2nd to last element will provide type
                                             arg_type = arg_type_list[arg_type_list.size - 2]
                                          else
                                            # Just read last element normally.
                                            arg_type = arg_type_list[arg_cnt - 2]
                                          end
                                        end
                                     
                # <-- action

              when 2
                # at line 323:19: 
                # --> action
                 @rpn += [PTGMISSARG].pack("C") 
                # <-- action

              end

            else
              break # out of loop for decision 17
            end
          end # loop for decision 17


        when 2
          # at line 328:5: 

        end
      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)

      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out(__method__, 10)

      end
      
      return arg_cnt
    end


    # parser rule sheet
    # 
    # (in ExcelFormula.g)
    # 330:1: sheet returns [ref] : (sheet_ref_name= NAME | sheet_ref_int= INT_CONST | sheet_ref_quote= QUOTENAME );
    def sheet
      # -> uncomment the next line to manually enable rule tracing
      # trace_in(__method__, 11)
      ref = nil
      sheet_ref_name = nil
      sheet_ref_int = nil
      sheet_ref_quote = nil

      begin
        # at line 331:5: (sheet_ref_name= NAME | sheet_ref_int= INT_CONST | sheet_ref_quote= QUOTENAME )
        alt_19 = 3
        case look_19 = @input.peek(1)
        when NAME then alt_19 = 1
        when INT_CONST then alt_19 = 2
        when QUOTENAME then alt_19 = 3
        else
          nvae = NoViableAlternative("", 19, 0)
          raise nvae
        end
        case alt_19
        when 1
          # at line 331:7: sheet_ref_name= NAME
          sheet_ref_name = match(NAME, TOKENS_FOLLOWING_NAME_IN_sheet_1768)
          # --> action
           ref = sheet_ref_name.text 
          # <-- action

        when 2
          # at line 333:7: sheet_ref_int= INT_CONST
          sheet_ref_int = match(INT_CONST, TOKENS_FOLLOWING_INT_CONST_IN_sheet_1788)
          # --> action
           ref = sheet_ref_int.text 
          # <-- action

        when 3
          # at line 335:7: sheet_ref_quote= QUOTENAME
          sheet_ref_quote = match(QUOTENAME, TOKENS_FOLLOWING_QUOTENAME_IN_sheet_1808)
          # --> action
           ref = sheet_ref_quote.text[1, len(sheet_ref_quote.text) - 1].replace("''", "'") 
          # <-- action

        end
      rescue ANTLR3::Error::RecognitionError => re
        report_error(re)
        recover(re)

      ensure
        # -> uncomment the next line to manually enable rule tracing
        # trace_out(__method__, 11)

      end
      
      return ref
    end



    # - - - - - - - - - - DFA definitions - - - - - - - - - - -
    class DFA2 < ANTLR3::DFA
      EOT = unpack(10, -1)
      EOF = unpack(1, 1, 9, -1)
      MIN = unpack(1, 4, 9, -1)
      MAX = unpack(1, 29, 9, -1)
      ACCEPT = unpack(1, -1, 1, 2, 2, -1, 1, 1, 5, -1)
      SPECIAL = unpack(10, -1)
      TRANSITION = [
        unpack(6, 4, 15, -1, 1, 1, 2, -1, 2, 1),
        unpack(),
        unpack(),
        unpack(),
        unpack(),
        unpack(),
        unpack(),
        unpack(),
        unpack(),
        unpack()
      ].freeze
      
      ( 0 ... MIN.length ).zip( MIN, MAX ) do | i, a, z |
        if a > 0 and z < 0
          MAX[ i ] %= 0x10000
        end
      end
      
      @decision = 2
      

      def description
        <<-'__dfa_description__'.strip!
          ()* loopback of 30:9: ( ( EQ | NE | GT | LT | GE | LE ) prec0_expr[arg_type] )*
        __dfa_description__
      end
    end
    class DFA3 < ANTLR3::DFA
      EOT = unpack(11, -1)
      EOF = unpack(1, 1, 10, -1)
      MIN = unpack(1, 4, 10, -1)
      MAX = unpack(1, 29, 10, -1)
      ACCEPT = unpack(1, -1, 1, 2, 8, -1, 1, 1)
      SPECIAL = unpack(11, -1)
      TRANSITION = [
        unpack(6, 1, 1, 10, 14, -1, 1, 1, 2, -1, 2, 1),
        unpack(),
        unpack(),
        unpack(),
        unpack(),
        unpack(),
        unpack(),
        unpack(),
        unpack(),
        unpack(),
        unpack()
      ].freeze
      
      ( 0 ... MIN.length ).zip( MIN, MAX ) do | i, a, z |
        if a > 0 and z < 0
          MAX[ i ] %= 0x10000
        end
      end
      
      @decision = 3
      

      def description
        <<-'__dfa_description__'.strip!
          ()* loopback of 46:9: ( ( CONCAT ) prec1_expr[arg_type] )*
        __dfa_description__
      end
    end
    class DFA5 < ANTLR3::DFA
      EOT = unpack(13, -1)
      EOF = unpack(1, 1, 12, -1)
      MIN = unpack(1, 4, 12, -1)
      MAX = unpack(1, 29, 12, -1)
      ACCEPT = unpack(1, -1, 1, 2, 9, -1, 1, 1, 1, -1)
      SPECIAL = unpack(13, -1)
      TRANSITION = [
        unpack(7, 1, 2, 11, 12, -1, 1, 1, 2, -1, 2, 1),
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
        unpack()
      ].freeze
      
      ( 0 ... MIN.length ).zip( MIN, MAX ) do | i, a, z |
        if a > 0 and z < 0
          MAX[ i ] %= 0x10000
        end
      end
      
      @decision = 5
      

      def description
        <<-'__dfa_description__'.strip!
          ()* loopback of 56:9: ( ( ADD | SUB ) prec2_expr[arg_type] )*
        __dfa_description__
      end
    end
    class DFA7 < ANTLR3::DFA
      EOT = unpack(15, -1)
      EOF = unpack(1, 1, 14, -1)
      MIN = unpack(1, 4, 14, -1)
      MAX = unpack(1, 29, 14, -1)
      ACCEPT = unpack(1, -1, 1, 2, 11, -1, 1, 1, 1, -1)
      SPECIAL = unpack(15, -1)
      TRANSITION = [
        unpack(9, 1, 2, 13, 10, -1, 1, 1, 2, -1, 2, 1),
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
        unpack()
      ].freeze
      
      ( 0 ... MIN.length ).zip( MIN, MAX ) do | i, a, z |
        if a > 0 and z < 0
          MAX[ i ] %= 0x10000
        end
      end
      
      @decision = 7
      

      def description
        <<-'__dfa_description__'.strip!
          ()* loopback of 68:9: ( ( MUL | DIV ) prec3_expr[arg_type] )*
        __dfa_description__
      end
    end
    class DFA8 < ANTLR3::DFA
      EOT = unpack(16, -1)
      EOF = unpack(1, 1, 15, -1)
      MIN = unpack(1, 4, 15, -1)
      MAX = unpack(1, 29, 15, -1)
      ACCEPT = unpack(1, -1, 1, 2, 13, -1, 1, 1)
      SPECIAL = unpack(16, -1)
      TRANSITION = [
        unpack(11, 1, 1, 15, 9, -1, 1, 1, 2, -1, 2, 1),
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
        unpack(),
        unpack()
      ].freeze
      
      ( 0 ... MIN.length ).zip( MIN, MAX ) do | i, a, z |
        if a > 0 and z < 0
          MAX[ i ] %= 0x10000
        end
      end
      
      @decision = 8
      

      def description
        <<-'__dfa_description__'.strip!
          ()* loopback of 79:9: ( ( POWER ) prec4_expr[arg_type] )*
        __dfa_description__
      end
    end
    class DFA9 < ANTLR3::DFA
      EOT = unpack(17, -1)
      EOF = unpack(1, 2, 16, -1)
      MIN = unpack(1, 4, 16, -1)
      MAX = unpack(1, 29, 16, -1)
      ACCEPT = unpack(1, -1, 1, 1, 1, 2, 14, -1)
      SPECIAL = unpack(17, -1)
      TRANSITION = [
        unpack(12, 2, 1, 1, 8, -1, 1, 2, 2, -1, 2, 2),
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
        unpack(),
        unpack(),
        unpack()
      ].freeze
      
      ( 0 ... MIN.length ).zip( MIN, MAX ) do | i, a, z |
        if a > 0 and z < 0
          MAX[ i ] %= 0x10000
        end
      end
      
      @decision = 9
      

      def description
        <<-'__dfa_description__'.strip!
          89:9: ( PERCENT )?
        __dfa_description__
      end
    end
    class DFA10 < ANTLR3::DFA
      EOT = unpack(13, -1)
      EOF = unpack(13, -1)
      MIN = unpack(1, 12, 12, -1)
      MAX = unpack(1, 32, 12, -1)
      ACCEPT = unpack(1, -1, 1, 1, 10, -1, 1, 2)
      SPECIAL = unpack(13, -1)
      TRANSITION = [
        unpack(1, 12, 4, -1, 6, 1, 1, -1, 1, 1, 2, -1, 1, 1, 2, -1, 3, 1),
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
        unpack()
      ].freeze
      
      ( 0 ... MIN.length ).zip( MIN, MAX ) do | i, a, z |
        if a > 0 and z < 0
          MAX[ i ] %= 0x10000
        end
      end
      
      @decision = 10
      

      def description
        <<-'__dfa_description__'.strip!
          94:1: prec5_expr[arg_type] : ( primary[arg_type] | SUB primary[arg_type] );
        __dfa_description__
      end
    end
    class DFA15 < ANTLR3::DFA
      EOT = unpack(66, -1)
      EOF = unpack(4, -1, 1, 12, 1, -1, 1, 31, 1, -1, 1, 49, 57, -1)
      MIN = unpack(1, 17, 3, -1, 1, 4, 1, -1, 1, 4, 1, -1, 1, 4, 57, -1)
      MAX = unpack(1, 32, 3, -1, 1, 29, 1, -1, 1, 29, 1, -1, 1, 29, 57, 
                   -1)
      ACCEPT = unpack(1, -1, 1, 1, 1, 2, 1, 3, 1, -1, 1, 5, 1, -1, 1, 8, 
                      1, -1, 1, 9, 1, 10, 1, 11, 1, 4, 17, -1, 1, 7, 1, 
                      6, 17, -1, 1, 12, 15, -1, 1, 13)
      SPECIAL = unpack(66, -1)
      TRANSITION = [
        unpack(1, 1, 1, 2, 1, 3, 1, 4, 1, 5, 1, 6, 1, -1, 1, 7, 2, -1, 1, 
               10, 2, -1, 1, 11, 1, 8, 1, 9),
        unpack(),
        unpack(),
        unpack(),
        unpack(13, 12, 6, -1, 1, 9, 1, -1, 1, 12, 1, 9, 1, -1, 2, 12),
        unpack(),
        unpack(13, 31, 6, -1, 1, 30, 1, -1, 1, 31, 2, -1, 2, 31),
        unpack(),
        unpack(13, 49, 6, -1, 1, 9, 1, 65, 1, 49, 1, 9, 1, -1, 2, 49),
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
        unpack(),
        unpack(),
        unpack(),
        unpack(),
        unpack()
      ].freeze
      
      ( 0 ... MIN.length ).zip( MIN, MAX ) do | i, a, z |
        if a > 0 and z < 0
          MAX[ i ] %= 0x10000
        end
      end
      
      @decision = 15
      

      def description
        <<-'__dfa_description__'.strip!
          99:1: primary[arg_type] : ( TRUE_CONST | FALSE_CONST | str_tok= STR_CONST | int_tok= INT_CONST | num_tok= NUM_CONST | ref2d_tok= REF2D | ref2d1_tok= REF2D COLON ref2d2_tok= REF2D | LP expr[arg_type] RP | sheet1= sheet ( COLON sheet2= sheet )? BANG ref3d_ref2d= REF2D ( COLON ref3d_ref2d2= REF2D )? | FUNC_IF LP expr[\"V\"] ( SEMICOLON | COMMA ) expr[arg_type] ( SEMICOLON | COMMA ) expr[arg_type] RP | FUNC_CHOOSE LP expr[\"V\"] ( ( SEMICOLON | COMMA ) ( expr[arg_type] | ) )* RP | name_tok= NAME | func_tok= NAME LP arg_count= expr_list[arg_type_list, min_argc, max_argc] RP );
        __dfa_description__
      end
    end
    class DFA12 < ANTLR3::DFA
      EOT = unpack(18, -1)
      EOF = unpack(1, 2, 17, -1)
      MIN = unpack(1, 4, 17, -1)
      MAX = unpack(1, 29, 17, -1)
      ACCEPT = unpack(1, -1, 1, 1, 1, 2, 15, -1)
      SPECIAL = unpack(18, -1)
      TRANSITION = [
        unpack(13, 2, 6, -1, 1, 1, 1, -1, 1, 2, 2, -1, 2, 2),
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
        unpack(),
        unpack(),
        unpack(),
        unpack()
      ].freeze
      
      ( 0 ... MIN.length ).zip( MIN, MAX ) do | i, a, z |
        if a > 0 and z < 0
          MAX[ i ] %= 0x10000
        end
      end
      
      @decision = 12
      

      def description
        <<-'__dfa_description__'.strip!
          153:9: ( COLON ref3d_ref2d2= REF2D )?
        __dfa_description__
      end
    end
    class DFA13 < ANTLR3::DFA
      EOT = unpack(15, -1)
      EOF = unpack(15, -1)
      MIN = unpack(1, 12, 14, -1)
      MAX = unpack(1, 32, 14, -1)
      ACCEPT = unpack(1, -1, 1, 1, 11, -1, 1, 2, 1, -1)
      SPECIAL = unpack(15, -1)
      TRANSITION = [
        unpack(1, 1, 4, -1, 6, 1, 1, -1, 1, 1, 1, 13, 1, -1, 1, 1, 2, 13, 
               3, 1),
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
        unpack()
      ].freeze
      
      ( 0 ... MIN.length ).zip( MIN, MAX ) do | i, a, z |
        if a > 0 and z < 0
          MAX[ i ] %= 0x10000
        end
      end
      
      @decision = 13
      

      def description
        <<-'__dfa_description__'.strip!
          199:17: ( expr[arg_type] | )
        __dfa_description__
      end
    end
    class DFA18 < ANTLR3::DFA
      EOT = unpack(14, -1)
      EOF = unpack(14, -1)
      MIN = unpack(1, 12, 13, -1)
      MAX = unpack(1, 32, 13, -1)
      ACCEPT = unpack(1, -1, 1, 1, 11, -1, 1, 2)
      SPECIAL = unpack(14, -1)
      TRANSITION = [
        unpack(1, 1, 4, -1, 6, 1, 1, -1, 1, 1, 1, 13, 1, -1, 1, 1, 2, -1, 
               3, 1),
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
        unpack()
      ].freeze
      
      ( 0 ... MIN.length ).zip( MIN, MAX ) do | i, a, z |
        if a > 0 and z < 0
          MAX[ i ] %= 0x10000
        end
      end
      
      @decision = 18
      

      def description
        <<-'__dfa_description__'.strip!
          288:1: expr_list[arg_type_list, min_argc, max_argc] returns [arg_cnt] : ( ( expr[arg_type] ( ( SEMICOLON | COMMA ) ( expr[arg_type] | ) )* ) | );
        __dfa_description__
      end
    end
    class DFA16 < ANTLR3::DFA
      EOT = unpack(15, -1)
      EOF = unpack(15, -1)
      MIN = unpack(1, 12, 14, -1)
      MAX = unpack(1, 32, 14, -1)
      ACCEPT = unpack(1, -1, 1, 1, 11, -1, 1, 2, 1, -1)
      SPECIAL = unpack(15, -1)
      TRANSITION = [
        unpack(1, 1, 4, -1, 6, 1, 1, -1, 1, 1, 1, 13, 1, -1, 1, 1, 2, 13, 
               3, 1),
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
        unpack()
      ].freeze
      
      ( 0 ... MIN.length ).zip( MIN, MAX ) do | i, a, z |
        if a > 0 and z < 0
          MAX[ i ] %= 0x10000
        end
      end
      
      @decision = 16
      

      def description
        <<-'__dfa_description__'.strip!
          304:17: ( expr[arg_type] | )
        __dfa_description__
      end
    end


    private

    def initialize_dfas
      super rescue nil
      @dfa2 = DFA2.new(self, 2)
      @dfa3 = DFA3.new(self, 3)
      @dfa5 = DFA5.new(self, 5)
      @dfa7 = DFA7.new(self, 7)
      @dfa8 = DFA8.new(self, 8)
      @dfa9 = DFA9.new(self, 9)
      @dfa10 = DFA10.new(self, 10)
      @dfa15 = DFA15.new(self, 15)
      @dfa12 = DFA12.new(self, 12)
      @dfa13 = DFA13.new(self, 13)
      @dfa18 = DFA18.new(self, 18)
      @dfa16 = DFA16.new(self, 16)

    end
    TOKENS_FOLLOWING_expr_IN_formula_56 = Set[1]
    TOKENS_FOLLOWING_prec0_expr_IN_expr_75 = Set[1, 4, 5, 6, 7, 8, 9]
    TOKENS_FOLLOWING_EQ_IN_expr_120 = Set[12, 17, 18, 19, 20, 21, 22, 24, 27, 30, 31, 32]
    TOKENS_FOLLOWING_NE_IN_expr_142 = Set[12, 17, 18, 19, 20, 21, 22, 24, 27, 30, 31, 32]
    TOKENS_FOLLOWING_GT_IN_expr_164 = Set[12, 17, 18, 19, 20, 21, 22, 24, 27, 30, 31, 32]
    TOKENS_FOLLOWING_LT_IN_expr_186 = Set[12, 17, 18, 19, 20, 21, 22, 24, 27, 30, 31, 32]
    TOKENS_FOLLOWING_GE_IN_expr_208 = Set[12, 17, 18, 19, 20, 21, 22, 24, 27, 30, 31, 32]
    TOKENS_FOLLOWING_LE_IN_expr_230 = Set[12, 17, 18, 19, 20, 21, 22, 24, 27, 30, 31, 32]
    TOKENS_FOLLOWING_prec0_expr_IN_expr_261 = Set[1, 4, 5, 6, 7, 8, 9]
    TOKENS_FOLLOWING_prec1_expr_IN_prec0_expr_293 = Set[1, 10]
    TOKENS_FOLLOWING_CONCAT_IN_prec0_expr_336 = Set[12, 17, 18, 19, 20, 21, 22, 24, 27, 30, 31, 32]
    TOKENS_FOLLOWING_prec1_expr_IN_prec0_expr_366 = Set[1, 10]
    TOKENS_FOLLOWING_prec2_expr_IN_prec1_expr_398 = Set[1, 11, 12]
    TOKENS_FOLLOWING_ADD_IN_prec1_expr_443 = Set[12, 17, 18, 19, 20, 21, 22, 24, 27, 30, 31, 32]
    TOKENS_FOLLOWING_SUB_IN_prec1_expr_465 = Set[12, 17, 18, 19, 20, 21, 22, 24, 27, 30, 31, 32]
    TOKENS_FOLLOWING_prec2_expr_IN_prec1_expr_495 = Set[1, 11, 12]
    TOKENS_FOLLOWING_prec3_expr_IN_prec2_expr_528 = Set[1, 13, 14]
    TOKENS_FOLLOWING_MUL_IN_prec2_expr_573 = Set[12, 17, 18, 19, 20, 21, 22, 24, 27, 30, 31, 32]
    TOKENS_FOLLOWING_DIV_IN_prec2_expr_595 = Set[12, 17, 18, 19, 20, 21, 22, 24, 27, 30, 31, 32]
    TOKENS_FOLLOWING_prec3_expr_IN_prec2_expr_625 = Set[1, 13, 14]
    TOKENS_FOLLOWING_prec4_expr_IN_prec3_expr_657 = Set[1, 15]
    TOKENS_FOLLOWING_POWER_IN_prec3_expr_700 = Set[12, 17, 18, 19, 20, 21, 22, 24, 27, 30, 31, 32]
    TOKENS_FOLLOWING_prec4_expr_IN_prec3_expr_730 = Set[1, 15]
    TOKENS_FOLLOWING_prec5_expr_IN_prec4_expr_762 = Set[1, 16]
    TOKENS_FOLLOWING_PERCENT_IN_prec4_expr_787 = Set[1]
    TOKENS_FOLLOWING_primary_IN_prec5_expr_818 = Set[1]
    TOKENS_FOLLOWING_SUB_IN_prec5_expr_827 = Set[17, 18, 19, 20, 21, 22, 24, 27, 30, 31, 32]
    TOKENS_FOLLOWING_primary_IN_prec5_expr_829 = Set[1]
    TOKENS_FOLLOWING_TRUE_CONST_IN_primary_850 = Set[1]
    TOKENS_FOLLOWING_FALSE_CONST_IN_primary_868 = Set[1]
    TOKENS_FOLLOWING_STR_CONST_IN_primary_890 = Set[1]
    TOKENS_FOLLOWING_INT_CONST_IN_primary_912 = Set[1]
    TOKENS_FOLLOWING_NUM_CONST_IN_primary_930 = Set[1]
    TOKENS_FOLLOWING_REF2D_IN_primary_952 = Set[1]
    TOKENS_FOLLOWING_REF2D_IN_primary_974 = Set[23]
    TOKENS_FOLLOWING_COLON_IN_primary_976 = Set[22]
    TOKENS_FOLLOWING_REF2D_IN_primary_982 = Set[1]
    TOKENS_FOLLOWING_LP_IN_primary_1000 = Set[12, 17, 18, 19, 20, 21, 22, 24, 27, 30, 31, 32]
    TOKENS_FOLLOWING_expr_IN_primary_1002 = Set[25]
    TOKENS_FOLLOWING_RP_IN_primary_1005 = Set[1]
    TOKENS_FOLLOWING_sheet_IN_primary_1028 = Set[23, 26]
    TOKENS_FOLLOWING_COLON_IN_primary_1050 = Set[20, 31, 32]
    TOKENS_FOLLOWING_sheet_IN_primary_1056 = Set[26]
    TOKENS_FOLLOWING_BANG_IN_primary_1061 = Set[22]
    TOKENS_FOLLOWING_REF2D_IN_primary_1065 = Set[1, 23]
    TOKENS_FOLLOWING_COLON_IN_primary_1087 = Set[22]
    TOKENS_FOLLOWING_REF2D_IN_primary_1092 = Set[1]
    TOKENS_FOLLOWING_FUNC_IF_IN_primary_1135 = Set[24]
    TOKENS_FOLLOWING_LP_IN_primary_1145 = Set[12, 17, 18, 19, 20, 21, 22, 24, 27, 30, 31, 32]
    TOKENS_FOLLOWING_expr_IN_primary_1147 = Set[28, 29]
    TOKENS_FOLLOWING_set_IN_primary_1150 = Set[12, 17, 18, 19, 20, 21, 22, 24, 27, 30, 31, 32]
    TOKENS_FOLLOWING_expr_IN_primary_1176 = Set[28, 29]
    TOKENS_FOLLOWING_set_IN_primary_1179 = Set[12, 17, 18, 19, 20, 21, 22, 24, 27, 30, 31, 32]
    TOKENS_FOLLOWING_expr_IN_primary_1205 = Set[25]
    TOKENS_FOLLOWING_RP_IN_primary_1208 = Set[1]
    TOKENS_FOLLOWING_FUNC_CHOOSE_IN_primary_1226 = Set[24]
    TOKENS_FOLLOWING_LP_IN_primary_1246 = Set[12, 17, 18, 19, 20, 21, 22, 24, 27, 30, 31, 32]
    TOKENS_FOLLOWING_expr_IN_primary_1248 = Set[25, 28, 29]
    TOKENS_FOLLOWING_set_IN_primary_1283 = Set[12, 17, 18, 19, 20, 21, 22, 24, 25, 27, 28, 29, 30, 31, 32]
    TOKENS_FOLLOWING_expr_IN_primary_1345 = Set[25, 28, 29]
    TOKENS_FOLLOWING_RP_IN_primary_1423 = Set[1]
    TOKENS_FOLLOWING_NAME_IN_primary_1445 = Set[1]
    TOKENS_FOLLOWING_NAME_IN_primary_1467 = Set[24]
    TOKENS_FOLLOWING_LP_IN_primary_1487 = Set[12, 17, 18, 19, 20, 21, 22, 24, 25, 27, 30, 31, 32]
    TOKENS_FOLLOWING_expr_list_IN_primary_1493 = Set[25]
    TOKENS_FOLLOWING_RP_IN_primary_1496 = Set[1]
    TOKENS_FOLLOWING_expr_IN_expr_list_1540 = Set[1, 28, 29]
    TOKENS_FOLLOWING_set_IN_expr_list_1566 = Set[1, 12, 17, 18, 19, 20, 21, 22, 24, 27, 28, 29, 30, 31, 32]
    TOKENS_FOLLOWING_expr_IN_expr_list_1634 = Set[1, 28, 29]
    TOKENS_FOLLOWING_NAME_IN_sheet_1768 = Set[1]
    TOKENS_FOLLOWING_INT_CONST_IN_sheet_1788 = Set[1]
    TOKENS_FOLLOWING_QUOTENAME_IN_sheet_1808 = Set[1]

  end # class Parser < ANTLR3::Parser

  at_exit { Parser.main(ARGV) } if __FILE__ == $0
end

