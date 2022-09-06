# TODOasIssue
From a list of TODOs to a list of issues on your GitHub.

```
#(1)[]: "This is my first TODO"
#(2)[]: "This is my second TODO"
```

## Installation
First of all, on your project folder, create a file called `todo.json` and paste the content below:

```json
{
    "owner": "YOUR_GITHUB_USERNAME",
    "repo_name": "YOUR_GITHUB_REPOSITORY_NAME",
    "token": "YOUR_PRIVATE_TOKEN"
}
```

`TODOasIssue` must have these informations to make things work.

**WARNING**: Insert this file `todo.json` on your `.gitignore` in order to keep your informations, especially your private token, safe.

## How `TODOasIssue` works?
GitHub projects can have issues created by developers / users to report errors, bugs and etcetera. The idea of building `TODOasIssue` is to automate the creation of issues locally by writing everything that you need in a simple text file and publishing it to your GitHub project without even opening your browser to do that.

## Project structure

- `lexer.go`: Convert text file to a list of tokens
- `parser.go`: From a list of tokens, build a list of TODOs
- `api.go`: From a list of TODOs, publish everything as issues on GitHub.

## License
This project is licensed under the MIT license. See [LICENSE](LICENSE).
