package org.pomidor;

import com.intellij.lexer.FlexLexer;
import com.intellij.psi.tree.IElementType;
import org.pomidor.psi.PomidorTypes;
import com.intellij.psi.TokenType;

%%

%class PomidorLexer
%implements FlexLexer
%unicode
%function advance
%type IElementType
%eof{  return;
%eof}

CRLF=\R
WHITE_SPACE=[\ \n\t\f]
FIRST_VALUE_CHARACTER=[_a-zA-Z][_zA-z0-9]*
//VALUE_CHARACTER=[\n\f\\] | "\\"{CRLF} | "\\".

END_OF_LINE_COMMENT=("#"|"!")[^\r\n]*
//FEATURE = ("@Feature") | (@Url) | (@data) ("@Feature"|"@Url"|"@data")
SEPARATOR=[:= ]
KEY_CHARACTER= ("\@Feature"|"\@Url"|"\@data")[^:=\ \n\t\f\\\D]*
VALUE_CHARACTER=({KEY_CHARACTER}{SEPARATOR}).+
//VALUE_CHARACTER = (\?<={KEY_CHARACTER}).*
//

%state WAITING_VALUE

%%

<YYINITIAL> {END_OF_LINE_COMMENT}                           { yybegin(YYINITIAL); return PomidorTypes.COMMENT; }

<YYINITIAL> {SEPARATOR}                                     { yybegin(WAITING_VALUE); return PomidorTypes.SEPARATOR; }

<WAITING_VALUE> {CRLF}({CRLF}|{WHITE_SPACE})+               { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

<WAITING_VALUE> {WHITE_SPACE}+                              { yybegin(WAITING_VALUE); return TokenType.WHITE_SPACE; }

<WAITING_VALUE> {FIRST_VALUE_CHARACTER}*                    { yybegin(YYINITIAL); return PomidorTypes.TEXT; }

<WAITING_VALUE> {VALUE_CHARACTER}+           { yybegin(YYINITIAL); return PomidorTypes.VALUE; }

<YYINITIAL> {KEY_CHARACTER}+                                { yybegin(YYINITIAL); return PomidorTypes.KEY; }


({CRLF}|{WHITE_SPACE})+                                     { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

[^]                                                         { return TokenType.BAD_CHARACTER; }