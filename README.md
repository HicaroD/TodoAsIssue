# :pencil: TODOasIssue

## Summary

1. [Description](#description)
2. [Installation](#installation)
3. [Project architecture](#project-architecture)
4. [License](#license)

## Description

From a list of TODOs to a list of issues on your GitHub or GitLab repository.

```
#(1)[]: "This is my first TODO"
#(2)[]: "This is my second TODO"
```

GitHub and Gitlab projects can have issues created by developers / users to report errors, bugs and etcetera. The idea of building `TODOasIssue` is to automate the creation of issues locally by writing everything that you need in a simple text file and publishing it to your GitHub / GitLab project without even opening your browser to do that.

Talking about GitHub's API, there is a nice support for [creating issues](https://docs.github.com/en/rest/issues/issues#create-an-issue) automatically.

## Installation
First of all, on your project root folder, create a file called `todo.json` and paste the content below:

```json
{
    "owner": "YOUR_GITHUB_USERNAME",
    "repo_name": "YOUR_GITHUB_REPOSITORY_NAME",
    "token": "YOUR_PRIVATE_TOKEN"
}
```

`TODOasIssue` must have these informations to make things work.

**WARNING**: Insert this file `todo.json` on your `.gitignore` in order to keep your informations safe, especially your private token.

## Project architecture
- [`lib/core`](./lib/core/): Code that is common across all the source code.
- [`lib/utils`](./lib/utils/): Utility code
- [`lib/lexer`](./lib/lexer/): Tool for converting a text file into a list of tokens
- [`lib/parser`](./lib/parser/): Tool for converting a list of tokens into a list of TODOs

## License
This project is licensed under the MIT license. See [LICENSE](LICENSE).
