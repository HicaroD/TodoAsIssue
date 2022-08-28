package main

import (
    "fmt"
    "os"
    "log"
    "strings"
)

func main() {
    file, err := os.ReadFile("examples/todo.txt")
    if err != nil {
	log.Fatal(err)
    }
    content := string(file)
    if strings.TrimSpace(content) == "" {
	log.Fatal(fmt.Errorf("File is empty"));
    }

    lexer := NewLexer(content)
    tokens, err := lexer.tokenize()
    if err != nil {
	log.Fatal(err)
    }

    for _, token := range(tokens) {
	fmt.Println(token.lexeme)
    }
}
