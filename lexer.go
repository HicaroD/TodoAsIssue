package main

import "fmt"

type TokenKind int

const (
    Word TokenKind = iota
    Hash
    DoubleQuotes
    OpeningPar
    ClosingPar
    Number
    Colon
)

type Token struct {
    lexeme         string
    tokenKind	   TokenKind
}

func newToken(lexeme string, tokenKind TokenKind) Token {
    return Token {
	lexeme: lexeme,
	tokenKind: tokenKind,
    }
}

type Lexer struct {
    fileContent string
    cursor uint64
    current_char byte
    is_end_of_file bool
}

func NewLexer(content string) *Lexer {
    return &Lexer {
	fileContent: content,
	cursor: 0,
	is_end_of_file: false,
    }
}

func (lexer *Lexer) tokenize() ([]Token, error) {
    var tokens []Token
    for !lexer.is_end_of_file {
	fmt.Println(string(lexer.current_char))
	lexer.advance_cursor()
    }
    return tokens, nil
}

func (lexer *Lexer) advance_cursor() {
    content_length := uint64(len(lexer.fileContent)) 
    if lexer.cursor < content_length - 1 {
	lexer.cursor++
	lexer.current_char = lexer.fileContent[lexer.cursor]
    } else {
	lexer.is_end_of_file = true
    }
}
