package org.pomidor.psi;

import com.intellij.extapi.psi.PsiFileBase;
import com.intellij.openapi.fileTypes.FileType;
import com.intellij.psi.FileViewProvider;
import org.pomidor.PomidorFileType;
import org.pomidor.PomidorLanguage;
import org.jetbrains.annotations.NotNull;

public class PomidorFile extends PsiFileBase{
    public PomidorFile(@NotNull FileViewProvider viewProvider) {
        super(viewProvider, PomidorLanguage.INSTANCE);
    }
    @NotNull
    @Override
    public FileType getFileType() {
        return PomidorFileType.INSTANCE;
    }

    @Override
    public String toString() {
        return "Pomidor File";
    }
}
