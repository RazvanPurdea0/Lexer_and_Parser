import java_cup.runtime.*;

%%

%class Lexer
%unicode
%line
%column
%cup

%{
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }

    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}

Letter = [a-zA-Z]
Digit = [0-9]
Punctuation = [!\"#\$%&\'()\*\+\,\-\.\/:;<=>\?@\[\]\\\^_`{}\~�]

Character = '{Letter}' | '{Punctuation}' | '{Digit}'
Integer = 0|[1-9]{Digit}*
Float = {Integer}(\.{Digit}*)?
Rational = {Integer}"/"{Digit}{Digit}* | ({Integer}_){Digit}"/"{Digit}{Digit}*
Number = {Integer} | {Rational} | {Float}
Boolean = T | F 
String = \"(\\.|[^\"])*\"

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace     = {LineTerminator} | [   \t\f]

Comment = {MultilineComment} | {EndOfLineComment}
MultilineComment = "/#" [^#] ~"#/" | "/#" "#" + "/"
EndOfLineComment = "#" {InputCharacter}* {LineTerminator}?

IdentifierCharacter = {Letter} | {Digit} | "_"
Identifier = {Letter}{IdentifierCharacter}*

%%

<YYINITIAL> {

    ":="               { return symbol(sym.EQ); }
    "::"               { return symbol(sym.CONCAT); }
    ":"                { return symbol(sym.POINTS); }
    "="                { return symbol(sym.EQEQ); }
    "!="               { return symbol(sym.NOT_EQ); }
    "&&"               { return symbol(sym.AND); }
    "||"               { return symbol(sym.OR); }
    "!"                { return symbol(sym.NOT); }
    "+"                { return symbol(sym.PLUS); }
    "-"                { return symbol(sym.MINUS); }
    "*"                { return symbol(sym.TIMES); }
    "/"                { return symbol(sym.DIVIDE); }
    "("                { return symbol(sym.PARENTHESESLEFT); }
    ")"                { return symbol(sym.PARENTHESESRIGHT); }
    "{"                { return symbol(sym.BRACESLEFT); }
    "}"                { return symbol(sym.BRACESRIGHT); }
    "["                { return symbol(sym.BRACKETSLEFT); }
    "]"                { return symbol(sym.BRACKETSRIGHT); }
    "<="               { return symbol(sym.LESS_THAN_EQUAL); }
    "<"                { return symbol(sym.LESS_THAN); }
    ">"                { return symbol(sym.BIGGER_THAN); }
    ","                { return symbol(sym.COMMA); }
    "^"                { return symbol(sym.CARET); }
    "."                { return symbol(sym.DOT); }
    ";"                { return symbol(sym.END); }

    "L"                { return symbol(sym.L); }
    "H"                { return symbol(sym.H); }

    "int"              { return symbol(sym.INTEGER); }
    "char"             { return symbol(sym.CHARACTER); }
    "rat"              { return symbol(sym.RATIONAL); }
    "float"            { return symbol(sym.FLOAT); }
    "bool"             { return symbol(sym.BOOLEAN); }
    "seq"              { return symbol(sym.SEQ); }
    "top"              { return symbol(sym.TOP); }

    "main"             { return symbol(sym.MAIN); }
    "tdef"             { return symbol(sym.TYPE_DEF); }
    "fdef"             { return symbol(sym.FUNCTION_DEF); }
    "in"               { return symbol(sym.IN); }
    "alias"            { return symbol(sym.ALIAS); }
    "if"               { return symbol(sym.IF); }
    "fi"               { return symbol(sym.FI); }
    "then"             { return symbol(sym.THEN); }
    "else"             { return symbol(sym.ELSE); }
    "read"             { return symbol(sym.READ); }
    "print"            { return symbol(sym.PRINT); }
    "return"           { return symbol(sym.RETURN); }
    "break"            { return symbol(sym.BREAK); }
    "loop"             { return symbol(sym.LOOP); }
    "pool"             { return symbol(sym.POOL); }

    {Boolean}          { return symbol(sym.BOOLEAN); }
    {String}           { return symbol(sym.STRING); }
    {Number}           { return symbol(sym.NUMBER); }
    {Character}        { return symbol(sym.CHARACTER); }
    {Identifier}       { return symbol(sym.IDENTIFIER);}
    {Comment}          { /* ignore*/ }
    {WhiteSpace}       { /* ignore */ }
}

[^]                    { throw new Error("Illegal character <"+yytext()+">"); }