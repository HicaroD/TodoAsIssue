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

After that, you can create a file called `todo.txt` in the project root folder to insert all your TODOs. For more informations and examples about how to create a TODO file, go [here](./examples/).

`TODOasIssue` must have these informations to make things work.

**WARNING**: Insert this file `todo.json` on your `.gitignore` in order to keep your informations safe, especially your private token.

## Project architecture
-  [`lib/api`](./lib/api/): Code that is related to the API's communication.
   - [`lib/api/api.dart`](./lib/api/api.dart): TODO
   - [`lib/api/github.dart`](./lib/api/github.dart): TODO
   - [`lib/api/gitlab.dart`](./lib/api/github.dart): TODO
   - [`lib/api/opensource_platform.dart`](./lib/api/opensource_platform.dart): TODO
-  [`lib/core`](./lib/core/): Code that is common across all the source code.
   - [`lib/core/http_client`](./lib/core/http_client/): Implementation of an HTTP Client using [`http`](https://pub.dev/packages/http) package.
     - [`lib/core/http_client/http_client_interface.dart`](./lib/core/http_client/http_client_interface.dart): TODO
     - [`lib/core/http_client/http_client.dart`](./lib/core/http_client/http_client.dart): TODO
-  [`lib/lexer`](./lib/lexer/): Tool for converting a text file into a list of tokens
   -  [`lib/lexer/lexer.dart`](./lib/lexer/lexer.dart): TODO
   -  [`lib/lexer/tokens.dart`](./lib/lexer/tokens.dart): TODO
-  [`lib/parser`](./lib/parser/): Tool for converting a list of tokens into a list of TODOs
   - [`lib/parser/error_reporter.dart`](./lib/parser/error_reporter.dart): TODO
   - [`lib/parser/parser.dart`](./lib/parser/parser.dart): TODO
   - [`lib/parser/todo.dart`](./lib/parser/todo.dart): TODO
-  [`lib/utils`](./lib/utils/): Utility code
   -  [`lib/utils/configuration.dart`](./lib/utils/configuration.dart): TODO
   -  [`lib/utils/endpoints.dart`](./lib/utils/endpoints.dart): TODO
   -  [`lib/utils/reader.dart`](./lib/utils/reader.dart): TODO

## Design patterns used

- [Iterator](https://refactoring.guru/design-patterns/iterator)

    Iterator pattern was used on the parser implementation. I used it for iterating over a list of tokens. You can check it out [here](https://github.com/HicaroD/TodoAsIssue/blob/fef632e69eddb22b94ad1270d8bff52b943fe969/lib/parser/parser.dart#L4).

- [Singleton](https://refactoring.guru/design-patterns/singleton)

    Singleton pattern was used on the implementation of open source platforms, such as GitHub and GitLab. I decided to use it because I didn't want to have more than one instance of each platform on my program, it should be unique, makes no sense to have more than one of these. You can check it out [here](https://github.com/HicaroD/TodoAsIssue/blob/63b0ba0bfb07eb3eb1a8394c0e8cd038981c9915/lib/api/github.dart#L1) and [here](https://github.com/HicaroD/TodoAsIssue/blob/aa5793998675dff1a9ab2f76de3082f69c36d8b9/lib/api/gitlab.dart#L1).

- [Strategy](https://refactoring.guru/design-patterns/strategy)
 
    Strategy pattern was used on the implementation of open source platforms as well. I decided to do this because we can have more than one kind of open source platforms, such as GitHub and GitLab. Therefore we can change the "strategy" to another open source platform. You can check it out [here](https://github.com/HicaroD/TodoAsIssue/tree/feature/api_communication/lib/api).

- [Facade](https://refactoring.guru/design-patterns/facade)

    Facade pattern was used on the implementation of `TodoAsIssue` class. This class is used for calling all the important methods, just acting like an front-facing interface masking more complex underlying code. It happens because `TodoAsIssue` doesn't know anything about the inner implementations of lexer and parser, for example, that's why it is called "Facade".

## License
This project is licensed under the MIT license. See [LICENSE](LICENSE).
