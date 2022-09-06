package main

import (
	"unicode"
)

type TokenKind int

const (
	IssueTitle TokenKind = iota
	Hash
	OpeningParenthesis
	ClosingParenthesis
	IssueNumber
	Colon
	OpeningSquareBracket
	ClosingSquareBracket
	CompletedMark // X
)

func (token TokenKind) String() string {
	switch token {
	case IssueTitle:
		return "IssueTitle"
	case Hash:
		return "Hash"
	case OpeningParenthesis:
		return "OpeningPar"
	case ClosingParenthesis:
		return "ClosingPar"
	case OpeningSquareBracket:
		return "OpeningSquareBracket"
	case ClosingSquareBracket:
		return "ClosingSquareBracket"
	case IssueNumber:
		return "Number"
	case Colon:
		return "Colon"
	case CompletedMark:
		return "CompletedMark"
	}
	return "unknown"
}

type Token struct {
	lexeme string
	kind   TokenKind
}

func newToken(lexeme string, kind TokenKind) Token {
	return Token{
		lexeme: lexeme,
		kind:   kind,
	}
}

type Lexer struct {
	fileContent    string
	cursor         uint64
	current_char   rune
	is_end_of_file bool
}

func NewLexer(content string) *Lexer {
	return &Lexer{
		fileContent:    content,
		cursor:         0,
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
		number += string(lexer.current_char)
		lexer.advance_cursor()
	}
	return number
}

func (lexer *Lexer) skipAnyWhitespace() {
	if unicode.IsSpace(lexer.current_char) {
		lexer.advance_cursor()
	}
}

func (lexer *Lexer) tokenize() ([]Token, error) {
	var tokens []Token
	for !lexer.is_end_of_file {
		// TODO: refactor switch case (if I need)
		lexer.skipAnyWhitespace()
		switch lexer.current_char {
		case '#':
			tokens = append(tokens, newToken(string(lexer.current_char), Hash))
			lexer.advance_cursor()
		case ':':
			tokens = append(tokens, newToken(string(lexer.current_char), Colon))
			lexer.advance_cursor()
		case '(':
			tokens = append(tokens, newToken(string(lexer.current_char), OpeningParenthesis))
			lexer.advance_cursor()
		case ')':
			tokens = append(tokens, newToken(string(lexer.current_char), ClosingParenthesis))
			lexer.advance_cursor()
		case '[':
			tokens = append(tokens, newToken(string(lexer.current_char), OpeningSquareBracket))
			lexer.advance_cursor()
		case ']':
			tokens = append(tokens, newToken(string(lexer.current_char), ClosingSquareBracket))
			lexer.advance_cursor()
		case '"':
			issue_body := lexer.get_issue_body()
			tokens = append(tokens, newToken(issue_body, IssueTitle))
			lexer.advance_cursor()
		default:
			if unicode.IsDigit(lexer.current_char) {
				number := lexer.get_issue_number()
				tokens = append(tokens, newToken(number, IssueNumber))
			} else if lexer.current_char == 'X' {
				tokens = append(tokens, newToken(string(lexer.current_char), CompletedMark))
				lexer.advance_cursor()
			} else {
				lexer.advance_cursor()
			}
		}
	}
	return tokens, nil
}

func (lexer *Lexer) advance_cursor() {
	content_length := uint64(len(lexer.fileContent))
	if lexer.cursor < content_length-1 {
		lexer.current_char = rune(lexer.fileContent[lexer.cursor])
		lexer.cursor++
	} else {
		lexer.is_end_of_file = true
	}
}
