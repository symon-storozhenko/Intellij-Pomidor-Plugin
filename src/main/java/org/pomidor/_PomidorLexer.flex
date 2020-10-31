package org.pomidor;

import com.intellij.lexer.FlexLexer;
import com.intellij.psi.tree.IElementType;

import static com.intellij.psi.TokenType.BAD_CHARACTER;
import static com.intellij.psi.TokenType.WHITE_SPACE;
import static org.pomidor.psi.PomidorTypes.*;

%%

%{
  public _PomidorLexer() {
    this((java.io.Reader)null);
  }
%}

%public
%class _PomidorLexer
%implements FlexLexer
%function advance
%type IElementType
%unicode

EOL=\R
WHITE_SPACE=\s+

CRLF=\r\n
EMPTY_LINE=[^ \t\n]+
COMMENT=!.*(\n)
STRING=(.*)\n

%%
<YYINITIAL> {
  {WHITE_SPACE}      { return WHITE_SPACE; }

  "CLRF"             { return CLRF; }
  "FEATURE"          { return FEATURE; }
  "URL"              { return URL; }
  "DATA"             { return DATA; }

  {CRLF}             { return CRLF; }
  {EMPTY_LINE}       { return EMPTY_LINE; }
  {COMMENT}          { return COMMENT; }
  {STRING}           { return STRING; }

}

[^] { return BAD_CHARACTER; }
