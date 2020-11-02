package org.pomidor;

import com.intellij.lexer.FlexLexer;
import com.intellij.psi.tree.IElementType;
import org.pomidor.psi.PomidorTypes;
import com.intellij.psi.TokenType;import java.nio.file.Watchable;

%%

%class PomidorLexer
%implements FlexLexer
%unicode
%function advance
%type IElementType
%eof{  return;
%eof}


//EOL=\R
//WHITE_SPACE=\s+
//SEPARATOR='regexp:[:-]* | [\t\f]+ '
//CRLF=\r\n
//EMPTY_LINE=[^ \t\n]+
//COMMENT=!.*(\n)
//STRING=(.*)\n
//VALUE_CHAR= {STRING}*
MARKER_ID = ("@feature" | "@data" | "@url")

CRLF=\R
WHITE_SPACE=[\ \n\t\f]
FIRST_VALUE_CHARACTER=[^ \n\f\\] | "\\"{CRLF} | "\\".
VALUE_CHARACTER=[^\n\f\\] | "\\"{CRLF} | "\\".
COMMENT=("#"|"!")[^\r\n]*
SEPARATOR=[:=] | [\f\t]*
EMPTY_LINE = {CRLF}+
//KEY_CHARACTER=[^:=\ \n\t\f\\] | "\\ "

%state WAITING_VALUE

%%

<YYINITIAL> {COMMENT}      { yybegin(YYINITIAL); return PomidorTypes.COMMENT; }
//<YYINITIAL> {EMPTY_LINE}*      { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

<YYINITIAL> {MARKER_ID}{SEPARATOR}+   { yybegin(WAITING_VALUE); return PomidorTypes.MARKERS; }
//<WAITING_VALUE> {SEPARATOR}     {yybegin(WAITING_VALUE); return PomidorTypes.SEPARATOR;}
//<YYINITIAL> {MARKER_ID}{SEPARATOR}     {yybegin(WAITING_VALUE); return PomidorTypes.SEPARATOR;}

<YYINITIAL> {CRLF}* { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

//<WAITING_VALUE> {MARKER_ID}*   { yybegin(WAITING_VALUE); return PomidorTypes.MARKERS; }

<WAITING_VALUE> {CRLF}{CRLF}
                | {WHITE_SPACE}  {yybegin(YYINITIAL); return  TokenType.WHITE_SPACE;}
//<WAITING_VALUE> {WHITE_SPACE}+ { yybegin(WAITING_VALUE); return TokenType.WHITE_SPACE; }
<WAITING_VALUE> {VALUE_CHARACTER}*   { yybegin(YYINITIAL); return PomidorTypes.VALUE; }
({CRLF}|{WHITE_SPACE})+         { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

[^]                             { return PomidorTypes.CODE; }
