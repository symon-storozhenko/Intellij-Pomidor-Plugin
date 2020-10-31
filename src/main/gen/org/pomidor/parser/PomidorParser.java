// This is a generated file. Not intended for manual editing.
package org.pomidor.parser;

import com.intellij.lang.PsiBuilder;
import com.intellij.lang.PsiBuilder.Marker;
import static org.pomidor.psi.PomidorTypes.*;
import static com.intellij.lang.parser.GeneratedParserUtilBase.*;
import com.intellij.psi.tree.IElementType;
import com.intellij.lang.ASTNode;
import com.intellij.psi.tree.TokenSet;
import com.intellij.lang.PsiParser;
import com.intellij.lang.LightPsiParser;

@SuppressWarnings({"SimplifiableIfStatement", "UnusedAssignment"})
public class PomidorParser implements PsiParser, LightPsiParser {

  public ASTNode parse(IElementType t, PsiBuilder b) {
    parseLight(t, b);
    return b.getTreeBuilt();
  }

  public void parseLight(IElementType t, PsiBuilder b) {
    boolean r;
    b = adapt_builder_(t, b, this, null);
    Marker m = enter_section_(b, 0, _COLLAPSE_, null);
    r = parse_root_(t, b);
    exit_section_(b, 0, m, t, r, true, TRUE_CONDITION);
  }

  protected boolean parse_root_(IElementType t, PsiBuilder b) {
    return parse_root_(t, b, 0);
  }

  static boolean parse_root_(IElementType t, PsiBuilder b, int l) {
    return paragraphs(b, l + 1);
  }

  /* ********************************************************** */
  // (marker_line | CODE | COMMENT)*
  public static boolean line(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "line")) return false;
    Marker m = enter_section_(b, l, _NONE_, LINE, "<line>");
    while (true) {
      int c = current_position_(b);
      if (!line_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "line", c)) break;
    }
    exit_section_(b, l, m, true, false, null);
    return true;
  }

  // marker_line | CODE | COMMENT
  private static boolean line_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "line_0")) return false;
    boolean r;
    r = marker_line(b, l + 1);
    if (!r) r = consumeToken(b, CODE);
    if (!r) r = consumeToken(b, COMMENT);
    return r;
  }

  /* ********************************************************** */
  // MARKERS SEPARATOR VALUE
  public static boolean marker_line(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "marker_line")) return false;
    if (!nextTokenIs(b, MARKERS)) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeTokens(b, 0, MARKERS, SEPARATOR, VALUE);
    exit_section_(b, m, MARKER_LINE, r);
    return r;
  }

  /* ********************************************************** */
  // line (CRLF line)*
  public static boolean paragraph(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "paragraph")) return false;
    boolean r;
    Marker m = enter_section_(b, l, _NONE_, PARAGRAPH, "<paragraph>");
    r = line(b, l + 1);
    r = r && paragraph_1(b, l + 1);
    exit_section_(b, l, m, r, false, null);
    return r;
  }

  // (CRLF line)*
  private static boolean paragraph_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "paragraph_1")) return false;
    while (true) {
      int c = current_position_(b);
      if (!paragraph_1_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "paragraph_1", c)) break;
    }
    return true;
  }

  // CRLF line
  private static boolean paragraph_1_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "paragraph_1_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, CRLF);
    r = r && line(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  /* ********************************************************** */
  // paragraph (EMPTY_LINE paragraph)*
  static boolean paragraphs(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "paragraphs")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = paragraph(b, l + 1);
    r = r && paragraphs_1(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

  // (EMPTY_LINE paragraph)*
  private static boolean paragraphs_1(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "paragraphs_1")) return false;
    while (true) {
      int c = current_position_(b);
      if (!paragraphs_1_0(b, l + 1)) break;
      if (!empty_element_parsed_guard_(b, "paragraphs_1", c)) break;
    }
    return true;
  }

  // EMPTY_LINE paragraph
  private static boolean paragraphs_1_0(PsiBuilder b, int l) {
    if (!recursion_guard_(b, l, "paragraphs_1_0")) return false;
    boolean r;
    Marker m = enter_section_(b);
    r = consumeToken(b, EMPTY_LINE);
    r = r && paragraph(b, l + 1);
    exit_section_(b, m, null, r);
    return r;
  }

}
