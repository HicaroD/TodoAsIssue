package main

import (
	"fmt"
	"log"
	"os"
	"strings"
)

func main() {
	file, err := os.ReadFile("examples/todo.txt")
	if err != nil {
		log.Fatal(err)
	}
	content := strings.TrimSpace(string(file))
	if content == "" {
		log.Fatal(fmt.Errorf("file is empty"))
	}

	lexer := NewLexer(content)
	tokens, err := lexer.tokenize()
	if err != nil {
		log.Fatal(err)
	}
	if len(tokens) == 0 {
		os.Exit(1)
	}

	for _, token := range tokens {
		fmt.Printf("%s: '%s'\n", token.kind, token.lexeme)
	}

	parser := NewParser(tokens)
	todos, err := parser.ParseTodos()
	if err != nil {
		log.Fatal(err)
	}

	for _, todo := range todos {
		fmt.Println(todo.Title)
	}
}
