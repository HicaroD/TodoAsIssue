package main

import (
    "unicode"
    "fmt"
)

type TokenKind int

const (
    IssueBody TokenKind = iota
    Hash
    OpeningPar
    ClosingPar
    IssueNumber
    Colon
)

func (token TokenKind) String() string {
    switch token {
    case IssueBody:
	return "IssueBody"
    case Hash:
	return "Hash"
    case OpeningPar:
	return "OpeningPar"
    case ClosingPar:
	return "ClosingPar"
    case IssueNumber:
	return "Number"
    case Colon:
	return "Colon"
    }
    return "unknown"
}

type Token struct {
    lexeme  string
    kind    TokenKind
}

func newToken(lexeme string, kind TokenKind) Token {
    return Token {
	lexeme: lexeme,
	kind: kind,
    }
}

type Lexer struct {
    fileContent	   string
    cursor	   uint64
    current_char   rune
    is_end_of_file bool
}

func NewLexer(content string) *Lexer {
    return &Lexer {
	fileContent: content,
	cursor: 0,
	is_end_of_file: false,
    }
}

func (lexer *Lexer) get_issue_body() string {
    lexer.advance_cursor()

    var issue_body string
    for lexer.current_char != '"' && !lexer.is_end_of_file {
	issue_body += string(lexer.current_char)
	lexer.advance_cursor()
    }
    return issue_body
}

func (lexer *Lexer) get_issue_number() string {
    var number string
    for unicode.IsDigit(lexer.current_char) && !lexer.is_end_of_file {
	fmt.Printf("current char: %c\n", lexer.current_char)
	number += string(lexer.current_char)
	lexer.advance_cursor()
    }
    return number;
}

func (lexer *Lexer) tokenize() ([]Token, error) {
    var tokens []Token
    for !lexer.is_end_of_file {
	fmt.Println(lexer.current_char)
	// TODO: refactor switch case
	switch(lexer.current_char) {
	case '#':
	    tokens = append(tokens, newToken(string(lexer.current_char), Hash))
	    lexer.advance_cursor()
	case ':':
	    tokens = append(tokens, newToken(string(lexer.current_char), Colon))
	    lexer.advance_cursor()
	case '(':
	    tokens = append(tokens, newToken(string(lexer.current_char), OpeningPar))
	    lexer.advance_cursor()
	case ')':
	    tokens = append(tokens, newToken(string(lexer.current_char), ClosingPar))
	    lexer.advance_cursor()
	case '"':
	    issue_body := lexer.get_issue_body()
	    tokens = append(tokens, newToken(issue_body, IssueBody))
	    lexer.advance_cursor()
	default:
	    if unicode.IsDigit(lexer.current_char) {
		number := lexer.get_issue_number()
		tokens = append(tokens, newToken(number, IssueNumber))
	    } else {
		lexer.advance_cursor()
	    }
	}
    }
    return tokens, nil
}

func (lexer *Lexer) advance_cursor() {
    content_length := uint64(len(lexer.fileContent)) 
    if lexer.cursor < content_length - 1 {
	lexer.current_char = rune(lexer.fileContent[lexer.cursor])
	lexer.cursor++
    } else {
	lexer.is_end_of_file = true
    }
}
