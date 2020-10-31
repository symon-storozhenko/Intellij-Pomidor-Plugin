package org.pomidor.psi;

import com.intellij.psi.tree.IElementType;
import org.pomidor.PomidorLanguage;
import org.jetbrains.annotations.NonNls;
import org.jetbrains.annotations.NotNull;

public class PomidorTokenType extends IElementType {
    public PomidorTokenType(@NotNull @NonNls String debugName) {
        super(debugName, PomidorLanguage.INSTANCE);
    }

    @Override
    public String toString() {
        return "PomidorTokenType." + super.toString();
    }
}
