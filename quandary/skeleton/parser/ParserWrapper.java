https://powcoder.com
代写代考加微信 powcoder
Assignment Project Exam Help
Add WeChat powcoder
https://powcoder.com
代写代考加微信 powcoder
Assignment Project Exam Help
Add WeChat powcoder
package parser;

import java.io.Reader;

import java_cup.runtime.*;

import ast.Program;

public class ParserWrapper {

    public static Program parse(Reader reader) throws Exception {
        ComplexSymbolFactory csf = new ComplexSymbolFactory();
        Lexer scanner = new Lexer(reader, csf);
        Parser parser = new Parser(scanner, csf);
        return (Program)parser.parse().value;
    }
}
