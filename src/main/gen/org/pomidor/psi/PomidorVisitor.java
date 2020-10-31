// This is a generated file. Not intended for manual editing.
package org.pomidor.psi;

import org.jetbrains.annotations.*;
import com.intellij.psi.PsiElementVisitor;
import com.intellij.psi.PsiElement;

public class PomidorVisitor extends PsiElementVisitor {

  public void visitLine(@NotNull PomidorLine o) {
    visitPsiElement(o);
  }

  public void visitMarkerLine(@NotNull PomidorMarkerLine o) {
    visitPsiElement(o);
  }

  public void visitParagraph(@NotNull PomidorParagraph o) {
    visitPsiElement(o);
  }

  public void visitPsiElement(@NotNull PsiElement o) {
    visitElement(o);
  }

}
