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


MARKER_VALUE=[^,;\ \t\r\n\f]+ //[A-Za-z_][A-Za-z0-9_]*
IDENTIFIER=[^,;!.:\ \t\r\n\f]+ //[A-Za-z_][A-Za-z0-9_]*

WHITE_SPACE=[\ \t]+
COMMENT="!"[^\r\n\f]*
SEPARATOR=[,;]
PUNCTUATION={SEPARATOR}|[.!:]
EOL= (\r|\n|\r\n|\f)
ACTIONS= "click" | "clicks" | "clicked"
          | "type" | "types" | "typed"
          | "displayed" | "not_displayed"
ACTION= \*?{ACTIONS}

%state MARKER_VALUE
%state PARAGRAPH
%state STATIC_DATA
%state DATA_FEED
%state CODE_BLOCK

%%

<YYINITIAL> {
    {WHITE_SPACE}          { return com.intellij.psi.TokenType.WHITE_SPACE; }
    {EOL}+                 { return PomidorTypes.EOL; }
    ^{COMMENT}             { return PomidorTypes.COMMENT; }

    "@feature"             { yybegin(MARKER_VALUE); return PomidorTypes.FEATURE; }
    "@data"                { yybegin(MARKER_VALUE); return PomidorTypes.DATA; }
    "@url"                 { yybegin(MARKER_VALUE); return PomidorTypes.URL; }

// first possible item in paragraph
    {ACTION}               { yybegin(PARAGRAPH); return PomidorTypes.ACTION; }
    {PUNCTUATION}          { yybegin(PARAGRAPH); return PomidorTypes.PUNCTUATION; }
    "#" /{IDENTIFIER}      { yybegin(PARAGRAPH); return PomidorTypes.PAGE_OBJECT_MARKER; }
    "[" /{IDENTIFIER}      { yybegin(STATIC_DATA); return PomidorTypes.STATIC_DATA_LEFT_MARKER; }
    "<<" /{IDENTIFIER}     { yybegin(DATA_FEED); return PomidorTypes.DATA_FEED_LEFT_MARKER; }
    \"\"\" /[^]            { yybegin(CODE_BLOCK); return PomidorTypes.CODE_BLOCK_LEFT_MARKER; }
    {IDENTIFIER}           { yybegin(PARAGRAPH); return PomidorTypes.IDENTIFIER; }
}

<MARKER_VALUE> {
    {EOL}+                 { yybegin(YYINITIAL); return PomidorTypes.EOL; }
    {WHITE_SPACE}          { return com.intellij.psi.TokenType.WHITE_SPACE; }
    ^{COMMENT}             { return PomidorTypes.COMMENT; }

    {SEPARATOR}            { return PomidorTypes.PUNCTUATION; }
    {MARKER_VALUE}         { return PomidorTypes.MARKER_VALUE; }
}

<PARAGRAPH> {
    {EOL}{EOL}+            { yybegin(YYINITIAL); return PomidorTypes.EOL; }
    {WHITE_SPACE}|{EOL}    { return com.intellij.psi.TokenType.WHITE_SPACE; }
    ^{COMMENT}             { return PomidorTypes.COMMENT; }

    {ACTION}               { return PomidorTypes.ACTION; }
    {PUNCTUATION}          { return PomidorTypes.PUNCTUATION; }
    "#" /{IDENTIFIER}      { return PomidorTypes.PAGE_OBJECT_MARKER; }
    "[" /{IDENTIFIER}      { yybegin(STATIC_DATA); return PomidorTypes.STATIC_DATA_LEFT_MARKER; }
    "<<" /{IDENTIFIER}     { yybegin(DATA_FEED); return PomidorTypes.DATA_FEED_LEFT_MARKER; }
    \"\"\" /~(\"\"\")      { yybegin(CODE_BLOCK); return PomidorTypes.CODE_BLOCK_LEFT_MARKER; }

    {IDENTIFIER}           { return PomidorTypes.IDENTIFIER; }
}

<STATIC_DATA> {
    "]"                    { yybegin(PARAGRAPH); return PomidorTypes.STATIC_DATA_RIGHT_MARKER; }
    {WHITE_SPACE}|{EOL}    { return com.intellij.psi.TokenType.WHITE_SPACE; }
    {PUNCTUATION} /"]"     { return PomidorTypes.PUNCTUATION; }

    {IDENTIFIER} /("]"|{PUNCTUATION})       { return PomidorTypes.IDENTIFIER; }
}

<DATA_FEED> {
    ">>"                   { yybegin(PARAGRAPH); return PomidorTypes.DATA_FEED_RIGHT_MARKER; }
    {WHITE_SPACE}|{EOL}    { return com.intellij.psi.TokenType.WHITE_SPACE; }
    {PUNCTUATION} /">>"    { return PomidorTypes.PUNCTUATION; }

    {IDENTIFIER} /(">>"|{PUNCTUATION})      { return PomidorTypes.IDENTIFIER; }
}

<CODE_BLOCK> {
    \"\"\"                 { yybegin(PARAGRAPH); return PomidorTypes.CODE_BLOCK_RIGHT_MARKER; }
    [^]+ /\"\"\"           { return PomidorTypes.CODE_SOURCE; }
}

[^] { return com.intellij.psi.TokenType.BAD_CHARACTER; }
