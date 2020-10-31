package org.pomidor.psi;

import com.intellij.psi.tree.IElementType;
import org.pomidor.PomidorLanguage;
import org.jetbrains.annotations.NonNls;
import org.jetbrains.annotations.NotNull;

public class PomidorElementType extends  IElementType {

    public PomidorElementType(@NotNull @NonNls String debugName) {

        super(debugName, PomidorLanguage.INSTANCE);
    }
}
