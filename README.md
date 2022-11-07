# :pencil: TODOasIssue

## Summary

1. [Description](#description)
2. [Installation](#installation)
3. [Project architecture](#project-architecture)
4. [Design patterns used](#design-patterns-used)
5. [License](#license)

## Description

From a list of TODOs to a list of issues on your GitHub or GitLab repository.

```
#(1)[~]: "This is my first TODO and it is completed"
#(2)[]: "This is my second TODO and it is not completed"
```

GitHub and Gitlab projects can have issues created by developers / users to report errors, bugs and etcetera. The idea of building `TODOasIssue` is to automate the creation of issues locally by writing everything that you need in a simple text file and publishing it to your GitHub / GitLab project without even opening your browser to do that.

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
-  [`lib/core`](./lib/core/): Code that is common across all the source code.
   -  [`lib/core/http_client`](./lib/core/http_client/): Implementation of an HTTP Client using [`http`](https://pub.dev/packages/http) package.
-  [`lib/lexer`](./lib/lexer/): Tool for converting a text file into a list of tokens
-  [`lib/parser`](./lib/parser/): Tool for converting a list of tokens into a list of TODOs
-  [`lib/utils`](./lib/utils/): Utility code

## Design patterns used

- [Iterator](https://refactoring.guru/design-patterns/iterator)

    Iterator pattern was used on the parser implementation. I used it for iterating over a list of tokens. You can check it out [here](https://github.com/HicaroD/TodoAsIssue/blob/fef632e69eddb22b94ad1270d8bff52b943fe969/lib/parser/parser.dart#L4).

- [Singleton](https://refactoring.guru/design-patterns/singleton)

    Singleton pattern was used on the implementation of open source plataforms, such as GitHub and GitLab. I decided to use it because I didn't want to have more than one instance of each platform on my program, it should be unique, makes no sense to have more than one of these.

## License
This project is licensed under the MIT license. See [LICENSE](LICENSE).
