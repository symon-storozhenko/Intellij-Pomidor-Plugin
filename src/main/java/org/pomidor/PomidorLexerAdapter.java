package org.pomidor;

import com.intellij.lexer.FlexAdapter;
import java.io.Reader;

public class PomidorLexerAdapter extends FlexAdapter {
    public PomidorLexerAdapter() {
        super(new PomidorLexer(null));
    }
}
