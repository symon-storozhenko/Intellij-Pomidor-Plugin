// This is a generated file. Not intended for manual editing.
package org.pomidor.psi;

import com.intellij.psi.tree.IElementType;
import com.intellij.psi.PsiElement;
import com.intellij.lang.ASTNode;
import org.pomidor.psi.impl.*;

public interface PomidorTypes {

  IElementType LINE = new PomidorElementType("LINE");
  IElementType MARKER_LINE = new PomidorElementType("MARKER_LINE");
  IElementType PARAGRAPH = new PomidorElementType("PARAGRAPH");

  IElementType CODE = new PomidorTokenType("CODE");
  IElementType COMMENT = new PomidorTokenType("COMMENT");
  IElementType CRLF = new PomidorTokenType("CRLF");
  IElementType EMPTY_LINE = new PomidorTokenType("EMPTY_LINE");
  IElementType MARKERS = new PomidorTokenType("MARKERS");
  IElementType SEPARATOR = new PomidorTokenType("SEPARATOR");
  IElementType VALUE = new PomidorTokenType("VALUE");

  class Factory {
    public static PsiElement createElement(ASTNode node) {
      IElementType type = node.getElementType();
      if (type == LINE) {
        return new PomidorLineImpl(node);
      }
      else if (type == MARKER_LINE) {
        return new PomidorMarkerLineImpl(node);
      }
      else if (type == PARAGRAPH) {
        return new PomidorParagraphImpl(node);
      }
      throw new AssertionError("Unknown element type: " + type);
    }
  }
}
