// This is a generated file. Not intended for manual editing.
package org.pomidor.psi.impl;

import java.util.List;
import org.jetbrains.annotations.*;
import com.intellij.lang.ASTNode;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiElementVisitor;
import com.intellij.psi.util.PsiTreeUtil;
import static org.pomidor.psi.PomidorTypes.*;
import com.intellij.extapi.psi.ASTWrapperPsiElement;
import org.pomidor.psi.*;

public class PomidorLineImpl extends ASTWrapperPsiElement implements PomidorLine {

  public PomidorLineImpl(@NotNull ASTNode node) {
    super(node);
  }

  public void accept(@NotNull PomidorVisitor visitor) {
    visitor.visitLine(this);
  }

  public void accept(@NotNull PsiElementVisitor visitor) {
    if (visitor instanceof PomidorVisitor) accept((PomidorVisitor)visitor);
    else super.accept(visitor);
  }

  @Override
  @NotNull
  public List<PomidorMarkerLine> getMarkerLineList() {
    return PsiTreeUtil.getChildrenOfTypeAsList(this, PomidorMarkerLine.class);
  }

}
