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
%ignorecase
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
IDENTIFIER=[^,;\ \t\r\n\f]+ //[A-Za-z_][A-Za-z0-9_]*

//CRLF=\R
WHITE_SPACE=[\ \t]+
//WHITE_SPACE=[\ \n\t\f]
//FIRST_VALUE_CHARACTER=[^ \n\f\\] | "\\"{CRLF} | "\\".
//VALUE_CHARACTER=[^\n\f\\] | "\\"{CRLF} | "\\".
//COMMENT=("#"|"!")[^\r\n\f]*
COMMENT="!"[^\r\n\f]*
SEPARATOR=[,;]
EOL= (\r|\n|\r\n|\f)
//KEY_CHARACTER=[^:=\ \n\t\f\\] | "\\ "

%state MARKER_VALUE
%state PARAGRAPH

%%

<YYINITIAL> {
    {WHITE_SPACE}          { return com.intellij.psi.TokenType.WHITE_SPACE; }
    {EOL}+                 { return PomidorTypes.EOL; }
    {COMMENT}              { return PomidorTypes.COMMENT; }

    "@feature"             { yybegin(MARKER_VALUE); return PomidorTypes.FEATURE; }
    "@data"                { yybegin(MARKER_VALUE); return PomidorTypes.DATA; }
    "@url"                 { yybegin(MARKER_VALUE); return PomidorTypes.URL; }

    {IDENTIFIER}           { yybegin(PARAGRAPH); return PomidorTypes.IDENTIFIER; }
}

<MARKER_VALUE> {
    {EOL}+                 { yybegin(YYINITIAL); return PomidorTypes.EOL; }
    {WHITE_SPACE}          { return com.intellij.psi.TokenType.WHITE_SPACE; }
    {COMMENT}              { return PomidorTypes.COMMENT; }

    {SEPARATOR}            { return PomidorTypes.SEPARATOR; }
    {IDENTIFIER}           { return PomidorTypes.IDENTIFIER; }
}

<PARAGRAPH> {
    {EOL}{EOL}+            { yybegin(YYINITIAL); return PomidorTypes.EOL; }
    {WHITE_SPACE}|{EOL}    { return com.intellij.psi.TokenType.WHITE_SPACE; }
    {COMMENT}              { return PomidorTypes.COMMENT; }

    {SEPARATOR}            { return PomidorTypes.SEPARATOR; }
    {IDENTIFIER}           { return PomidorTypes.IDENTIFIER; }
}

//<YYINITIAL> {EMPTY_LINE}*      { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }
//<WAITING_VALUE> {SEPARATOR}     {yybegin(WAITING_VALUE); return PomidorTypes.SEPARATOR;}
//<YYINITIAL> {MARKER_ID}{SEPARATOR}     {yybegin(WAITING_VALUE); return PomidorTypes.SEPARATOR;}
//<WAITING_VALUE> {MARKER_ID}*   { yybegin(WAITING_VALUE); return PomidorTypes.MARKERS; }
//<WAITING_VALUE> {WHITE_SPACE}+ { yybegin(WAITING_VALUE); return TokenType.WHITE_SPACE; }
//<WAITING_VALUE> {VALUE_CHARACTER}*   { yybegin(YYINITIAL); return PomidorTypes.VALUE; }

//[^]                             { return PomidorTypes.CODE; }
[^] { return com.intellij.psi.TokenType.BAD_CHARACTER; }
