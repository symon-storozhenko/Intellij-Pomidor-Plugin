package org.pomidor;

import com.intellij.lang.Language;

public class PomidorLanguage extends Language{
    public static final PomidorLanguage INSTANCE = new PomidorLanguage();

    private PomidorLanguage() {
        super("Pomidor");
    }
}
