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
	content := string(file)
	if strings.TrimSpace(content) == "" {
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
	parser.ParseTodos()
}
