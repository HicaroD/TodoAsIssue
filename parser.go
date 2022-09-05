package main

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

func (parser *Parser) ParseTodos() []Todo {
	var todos []Todo
	for parser.cursor < uint(len(parser.tokens)) {
		// TODO: Parse list of tokens into a list of TODOs
		parser.advanceCursor()
	}
	return todos
}
