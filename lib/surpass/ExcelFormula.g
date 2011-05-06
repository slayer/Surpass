grammar ExcelFormula;

options {
  language  = Ruby;
  k = 2;
}

@header {
  RVA_DELTA = {"R" => 0, "V" => 0x20, "A" => 0x40}
  RVA_DELTA_REF = {"R" => 0, "V" => 0x20, "A" => 0x40, "D" => 0x20}
  RVA_DELTA_AREA = {"R" => 0, "V" => 0x20, "A" => 0x40, "D" => 0}
}

@init {
  @rpn = ''
  @sheet_references = []
  @xcall_references = []
}

@members {
  attr_accessor :rpn
}

/// @export "formula"
formula
    : expr["V"]
    ;

/// @export "expr"
expr[arg_type]
    : prec0_expr[arg_type]
        (
            (
                  EQ { op = [PTGEQ].pack('C') }
                | NE { op = [PTGNE].pack('C') }
                | GT { op = [PTGGT].pack('C') }
                | LT { op = [PTGLT].pack('C') }
                | GE { op = [PTGGE].pack('C') }
                | LE { op = [PTGLE].pack('C') }

            )
            prec0_expr[arg_type] { @rpn += op }
        )*
    ;
/// @export "prec0_expr"
prec0_expr[arg_type]
    : prec1_expr[arg_type]
        (
            (
                CONCAT { op = [PTGCONCAT].pack('C') }
            )
            prec1_expr[arg_type] { @rpn += op }
        )*
    ;
/// @export "prec1_expr"
prec1_expr[arg_type]
    : prec2_expr[arg_type]
        (
            (
                  ADD { op = [PTGADD].pack('C') }
                | SUB { op = [PTGSUB].pack('C') }
            )
            prec2_expr[arg_type] { @rpn += op }
        )*
    ;
/// @export "prec2_expr"
prec2_expr[arg_type]
    : prec3_expr[arg_type]
        (
            (
                  MUL { op = [PTGMUL].pack('C') }
                | DIV { op = [PTGDIV].pack('C') }
            )
            prec3_expr[arg_type] { @rpn += op }
        )*
    ;

/// @export "prec3_expr"
prec3_expr[arg_type]
    : prec4_expr[arg_type]
        (
            (
                POWER { op = [PTGPOWER].pack('C') }
            )
            prec4_expr[arg_type] { @rpn += op }
        )*
    ;
/// @export "prec4_expr"
prec4_expr[arg_type]
    : prec5_expr[arg_type]
        (
            PERCENT { @rpn += [PTGPERCENT].pack('C') }
        )?
    ;
/// @export "prec5_expr"
prec5_expr[arg_type]
    : primary[arg_type]
    | SUB primary[arg_type] { @rpn += [PTGUMINUS].pack('C') }
    ;
/// @end
primary[arg_type]
/// @export "boolean-string"
    : TRUE_CONST
        {
            @rpn += [PTGBOOL, 1].pack("C2")
        }
    | FALSE_CONST
        {
            @rpn += [PTGBOOL, 0].pack("C2")
        }
    | str_tok = STR_CONST
        {
            s = str_tok.text.gsub("\"", "")
            @rpn += [PTGSTR].pack("C") + [s.length].pack('v') + s
        }
/// @export "numeric"
    | int_tok = INT_CONST
    {
        int_value = int_tok.text.to_i
        if int_value <= 65535
            @rpn += [PTGINT, int_value].pack("Cv")
        else
            @rpn += [PTGNUM, int_value.to_f].pack("CE")
        end
    }
    | num_tok = NUM_CONST
        {
            @rpn += [PTGNUM, num_tok.text.to_f].pack("CE")
        }
/// @end
    | ref2d_tok = REF2D
        {
          r, c = Utilities.cell_to_packed_rowcol(ref2d_tok.text) 
          ptg = PTGREFR + RVA_DELTA_REF[arg_type]
          @rpn += [ptg, r, c].pack("Cv2")
        }
    | ref2d1_tok = REF2D COLON ref2d2_tok = REF2D
        {
            r1, c1 = Utilities.cell_to_packed_rowcol(ref2d1_tok.text) 
            r2, c2 = Utilities.cell_to_packed_rowcol(ref2d2_tok.text)
            ptg = PTGAREAR + RVA_DELTA_AREA[arg_type]
            @rpn += [ptg, r1, r2, c1, c2].pack("Cv4")
        }
/// @export "parens"
    | LP expr[arg_type] RP
        {
            @rpn += [PTGPAREN].pack('C')
        } 
/// @end
    | sheet1 = sheet
        { 
            sheet2 = sheet1
        }
        ( COLON sheet2 = sheet )? BANG ref3d_ref2d=REF2D
        {
            ptg = PTGREF3DR + RVA_DELTA_REF[arg_type]
            r1, c1 = Utilities.cell_to_packed_rowcol(ref3d_ref2d.text)
            rpn_ref2d = [0x0000, r1, c1].pack("v3")
        }
        ( COLON ref3d_ref2d2= REF2D
            {
                ptg = PTGAREA3DR + RVA_DELTA_AREA[arg_type]
                r2, c2 = Utilities.cell_to_packed_rowcol(ref3d_ref2d2.text)
                rpn_ref2d = [0x0000, r1, r2, c1, c2].pack("v5")
            }
        )?
        {
            @rpn += [ptg].pack("C")
            @sheet_references << [sheet1, sheet2, @rpn.size]
            @rpn += rpn_ref2d
        }
/// @export "if-fn"
    | FUNC_IF
        LP expr["V"] (SEMICOLON | COMMA)
        {
            @rpn += [PTGATTR, 0x02, 0].pack("C2v") # tAttrIf
            pos0 = @rpn.size - 2
        }
        expr[arg_type] (SEMICOLON | COMMA)
        {
            @rpn += [PTGATTR, 0x08, 0].pack("C2v") # tAttrSkip
            pos1 = @rpn.size - 2

            @rpn = @rpn[0...pos0] + [pos1-pos0].pack("v") + @rpn[(pos0+2)...(@rpn.size)] 
        }
        expr[arg_type] RP
        {
            @rpn += [PTGATTR, 0x08, 3].pack("C2v") # tAttrSkip
            @rpn += [PTGFUNCVARR, 3, 1].pack("C2v") # 3 = nargs, 1 = IF func
            pos2 = @rpn.size

            @rpn = @rpn[0...pos1] + [pos2-(pos1+2)-1].pack("v") + @rpn[(pos1+2)...(@rpn.size)]
        }
/// @end
    | FUNC_CHOOSE
        {
            arg_type = "R"
            rpn_chunks = []
        }
        LP expr["V"]
        {
            rpn_start = @rpn.size
            ref_markers = [@sheet_references.size]
        }
        (
            (SEMICOLON | COMMA)
                { mark = @rpn.size }
                (
                  expr[arg_type]
                | { @rpn += [PTGMISSARG].pack("C") }
                )
                {
                    rem = @rpn.size - mark
                    rpn_chunks << @rpn[mark, rem]
                    ref_markers << @sheet_references.size
                }
        )*
        RP
        {
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
        }
    | name_tok = NAME
        {
          raise "[formula] found unexpected NAME token #{name_tok.text}"
        }
    | func_tok = NAME
        {
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
        }
        LP arg_count = expr_list[arg_type_list, min_argc, max_argc] RP
        {
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
        }
    ;

// Process arguments to a function.
/// @export "expr_list"
expr_list[arg_type_list, min_argc, max_argc] returns [arg_cnt]
@init
{
  arg_cnt = 0

  # Set these for processing first argument, 
  # it's simpler because first argument type can't be '...'
  arg_type = arg_type_list.first

  # need to check for '-' for a fn with no arguments
  arg_cnt += 1 unless arg_type === '-'
}
    : 
    (expr[arg_type]
        (
             (SEMICOLON | COMMA) { arg_cnt += 1 }
                ( 
                 // *either* we find an argument after the comma/semicolon in which case process it...
                     expr[arg_type]
                     {
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
                     }
                     // ... *or* we have a missing argument and need to insert a placeholder
                | { @rpn += [PTGMISSARG].pack("C") } 
                )
         )*
    )
    | // Some functions have no arguments e.g. pi()
    ;
/// @end
sheet returns[ref]
    : sheet_ref_name = NAME
      { ref = sheet_ref_name.text }
    | sheet_ref_int = INT_CONST
      { ref = sheet_ref_int.text }
    | sheet_ref_quote = QUOTENAME
      { ref = sheet_ref_quote.text[1, len(sheet_ref_quote.text) - 1].replace("''", "'") }
    ;

/// @export "expr-tokens"
EQ: '=';
LT: '<';
GT: '>';
NE: '<>';
LE: '<=';
GE: '>=';
/// @export "prec0_expr-tokens"
CONCAT: '&';
/// @export "prec1_expr-tokens"
ADD: '+';
SUB: '-';
/// @export "prec2_expr-tokens"
MUL: '*';
DIV: '/';
/// @export "prec3_expr-tokens"
POWER: '^';
/// @export "prec4_expr-tokens"
PERCENT: '\%';
/// @end

COLON: ':';
SEMICOLON: ';';
COMMA: ',';

LP: '(';
RP: ')';
BANG: '!';

fragment DIGIT: '0'..'9';

INT_CONST: DIGIT+ ;
NUM_CONST: DIGIT* '.' DIGIT+ (('E'|'e') ('+'|'-')? DIGIT+)?; 
STR_CONST: '"' (~'"')+ '"';
REF2D: '$'? ('A'..'I')? ('A'..'Z') '$'? DIGIT+;
TRUE_CONST: ('T'|'t') ('R'|'r') ('U'|'u') ('E'|'e') ;
FALSE_CONST: ('F'|'f') ('A'|'a') ('L'|'l') ('S'|'s') ('E'|'e') ;
QUOTENAME: '\'(?:[^\']|\'\')*\'';
FUNC_IF: 'IF';
FUNC_CHOOSE: 'CHOOSE';

fragment ALPHA: 'a'..'z' | 'A'..'Z';
NAME: ALPHA+ ;

WS: (' ')+ {skip()};
