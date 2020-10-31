package org.pomidor;

import com.intellij.openapi.fileTypes.LanguageFileType;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import javax.swing.Icon;

public class PomidorFileType extends LanguageFileType {
    public static final PomidorFileType INSTANCE = new PomidorFileType();

    private PomidorFileType() {
        super(PomidorLanguage.INSTANCE);
    }

    @NotNull
    @Override
    public String getName() {
        return "Pomidor file";
    }

    @NotNull
    @Override
    public String getDescription() {
        return "Pomidor language file";
    }

    @NotNull
    @Override
    public String getDefaultExtension() {
        return "pomidor";
    }

    @Nullable
    @Override
    public Icon getIcon() {
        return PomidorIcons.FILE;
    }

}
