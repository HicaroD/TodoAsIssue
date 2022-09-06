package main

import (
	"fmt"
	"strconv"
)

type Todo struct {
	Id          uint
	Title       string
	IsCompleted bool
}

type Parser struct {
	cursor       uint
	currentToken Token
	tokens       []Token
}

func NewParser(tokens []Token) *Parser {
	return &Parser{cursor: 0, tokens: tokens}
}

func (parser *Parser) advanceCursor() {
	if parser.cursor < uint(len(parser.tokens)) {
		parser.currentToken = parser.tokens[parser.cursor]
		parser.cursor++
	}
}

func (parser *Parser) parseToken(tokenKind TokenKind) error {
	if parser.currentToken.kind != tokenKind {
		return fmt.Errorf("error: invalid token ('%s', %s)", parser.currentToken.lexeme, parser.currentToken.kind)
	}
	return nil
}

func (parser *Parser) parseTodo() (*Todo, error) {
	// TODO: refactor (maybe it is too repetitive and big?)
	var err error

	err = parser.parseToken(Hash)
	if err != nil {
		return nil, err
	}
	parser.advanceCursor()

	err = parser.parseToken(OpeningParenthesis)
	if err != nil {
		return nil, err
	}
	parser.advanceCursor()

	err = parser.parseToken(IssueNumber)
	if err != nil {
		return nil, err
	}
	id, err := strconv.Atoi(parser.currentToken.lexeme)
	if err != nil {
		return nil, err
	}
	parser.advanceCursor()

	err = parser.parseToken(ClosingParenthesis)
	if err != nil {
		return nil, err
	}
	parser.advanceCursor()

	err = parser.parseToken(OpeningSquareBracket)
	if err != nil {
		return nil, err
	}
	parser.advanceCursor()

	isCompleted := false
	if parser.currentToken.kind == CompletedMark {
		isCompleted = true
		parser.advanceCursor()
	}
	err = parser.parseToken(ClosingSquareBracket)
	if err != nil {
		return nil, err
	}
	parser.advanceCursor()

	err = parser.parseToken(Colon)
	if err != nil {
		return nil, err
	}
	parser.advanceCursor()
	err = parser.parseToken(IssueTitle)
	if err != nil {
		return nil, err
	}
	title := parser.currentToken.lexeme
	parser.advanceCursor()

	return &Todo{
		Id:          uint(id),
		Title:       title,
		IsCompleted: isCompleted,
	}, nil
}

func (parser *Parser) ParseTodos() ([]Todo, error) {
	var todos []Todo
	parser.advanceCursor()
	for parser.cursor < uint(len(parser.tokens)) {
		todo, err := parser.parseTodo()
		if err != nil {
			return nil, err
		}
		todos = append(todos, *todo)
	}
	return todos, nil
}
