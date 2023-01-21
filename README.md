# :pencil: TODOasIssue

## Summary

1. [Description](#description)
2. [Installation](#installation)
3. [Setting up `todo.json`](#setting-up-todo.json)

   3.1. [Required fields for GitHub](#required-fields-for-github)

   3.2. [Required fields for GitLab](#required-fields-for-gitlab)

4. [Setting up `todo.txt`](#setting-up-todo.txt)
5. [Usage](#usage)
6. [Project architecture](#project-architecture)
7. [Supported platforms](#supported-platforms)
8. [License](#license)

## Description

From a list of TODOs to a list of issues on your GitHub or GitLab repository.

```markdown
[~]: "This is my first TODO";
[]: "This is my second TODO";
[]: "This is my third TODO" "And it also has a body text";
[]: "This is my last TODO" "And it has a body text" {"label1", "label2"};
```

GitHub and Gitlab projects can have issues created by developers / users to report errors, bugs and etcetera. The idea of building `TODOasIssue` is to automate the creation of issues locally by writing everything that you need in a simple text file and publishing it to your GitHub / GitLab project without even opening your browser to do that.

## Installation

First of all, you need to have Dart installed on your computer. See [Dart documentation](https://dart.dev/get-dart). After that, run the following command:

```bash
dart pub global activate todo_as_issue
```

Now you have `TodoAsIssue` installed.

## Setting up `todo.json`

On your project root folder, create a file called `todo.json` and paste the content below:

```json
{
  "owner": "YOUR_GITHUB_USERNAME",
  "repo_name_github": "YOUR_GITHUB_REPOSITORY_NAME",
  "repo_id_gitlab": "YOUR_GITLAB_PROJECT_ID",
  "platform": "YOUR_OPEN_SOURCE_PLATFORM",
  "github_token": "YOUR_PRIVATE_TOKEN_FROM_GITHUB",
  "gitlab_token": "YOUR_PRIVATE_TOKEN_FROM_GITLAB"
}
```

In `platform` field, you can use `github` or `gitlab`.

See the image below from my URL bar that will teach you how to identify your `owner` and `repo_name_github` fields:

![image](https://user-images.githubusercontent.com/75737377/210892430-78b320ec-bd78-451a-9b9f-ee0c7684e1f9.png)

After that, you can create a file called `todo.txt` in the project root folder to insert all your TODOs. For more informations and examples about how to create a TODO file, go [here](./examples/).

### Required fields for GitHub

- `owner`: Your GitHub username
- `repo_name_github`: Your repository name
- `platform`: It should be `github`
- `github_token`: Your private access token. See [GitHub Docs](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)

Leave the remaining ones empty (empty string).

### Required fields for GitHub

- `repo_id_gitlab`: Your repository id
- `platform`: It should be `gitlab`
- `gitlab_token`: Your private access token. See [GitLab Docs](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html)

You can leave the remaining one empty because each platform will only its required fields.

**WARNING**: Insert this file `todo.json` on your `.gitignore` in order to keep your informations safe, especially your private token.

## Setting up `todo.txt`

In the [description](#description), you have a pretty clear example on how to structure
your `todo.txt`. In this section I just want to mention a couple things.

First of all, each issue can have a `title`, `body` and a `labels`. `title` is required, but
`body` and `labels`, however you need to respect the order. For example:

```markdown
[]: "Title of issue" "Body of issue" {"label1", "label2"};
```

The example above is **valid** because `labels` are placed *after* `body`.

```markdown
[]: "Title of issue" {"label1", "label2"} "Body of issue";
```

The example above is **invalid** because `labels` are placed *before* `body`. This order is
wrong!

## Usage

After setting up `TodoAsIssue`, go to your project's root directory and run the following command:

```
todo_as_issue
```

That command will look for `todo.json` and `todo.txt` on project's root directory.

## Project architecture

- [`lib/api`](./lib/api/): Code that is related to the API's communication.
  - [`lib/api/api.dart`](./lib/api/api.dart): Class for calling method to create issues
  - [`lib/api/github.dart`](./lib/api/github.dart): Class for implementing the communication with GitHub's API to create an issue.
  - [`lib/api/gitlab.dart`](./lib/api/gitlab.dart): Class for implementing the communication with GitLab's API to create an issue.
  - [`lib/api/opensource_platform.dart`](./lib/api/opensource_platform.dart): Interface for any open source platform that I may want to create in the future.
  - [`./lib/api/successful_status.dart`](./lib/api/successful_status.dart): Class for getting successful message based on issue counter.
- [`lib/core`](./lib/core/): Code that is common across all the source code.
  - [`lib/core/http_client`](./lib/core/http_client/): Implementation of an HTTP client
    - [`lib/core/http_client/http_client_interface.dart`](./lib/core/http_client/http_client_interface.dart): Interface for any HTTP client that I may want to create in the future. This is useful because my code will not be dependent
    - [`lib/core/http_client/http_client.dart`](./lib/core/http_client/http_client.dart): Implementation of an HTTP Client using [`http`](https://pub.dev/packages/http) package.
  - [`lib/core/errors`](./lib/core/errors/):
    - [`lib/core/errors/api_exceptions`](./lib/core/errors/api_exceptions.dart): File for defining all exceptions related to API communication.
    - [`lib/core/errors/lexer_exceptions.dart`](./lib/core/errors/lexer_exceptions.dart): File for defining all exceptions related to the lexer.
    - [`lib/core/errors/parser_exceptions.dart`](./lib/core/errors/parser_exceptions.dart): File for defining all exceptions related to the parser.
- [`lib/lexer`](./lib/lexer/): Tool for converting a text file into a list of tokens
  - [`lib/lexer/lexer.dart`](./lib/lexer/lexer.dart): Implementation of lexer (tokenizer)
  - [`lib/lexer/position.dart`](./lib/lexer/position.dart): Class for managing cursor and line positions
  - [`lib/lexer/tokens.dart`](./lib/lexer/tokens.dart): Class for representing a token and an enum to represent a token kind.
- [`lib/parser`](./lib/parser/): Tool for converting a list of tokens into a list of TODOs
  - [`lib/parser/parser.dart`](./lib/parser/parser.dart): Class for converting a list of tokens (generated by the lexer) into a list of TODOs
  - [`lib/parser/todo.dart`](./lib/parser/todo.dart): Class for representing a TODO object.
- [`lib/utils`](./lib/utils/): Utility code
  - [`lib/utils/configuration.dart`](./lib/utils/configuration.dart): Data class for representing `todo.json`.
  - [`lib/utils/endpoints.dart`](./lib/utils/endpoints.dart): Important endpoints
  - [`lib/utils/reader.dart`](./lib/utils/reader.dart): Helper class for reading importants files (`todo.json` and `todo.txt`)
- [`test`](./test/): Folder for storing all tests
  - [`test/mocks/`](./test/mocks/): Folder for defining some mocks for helping me to test the code.
    - [`test/mocks/configuration_mock.dart`](./test/mocks/configuration_mock.dart): File for storing a mock object of `Configuration`.
    - [`test/mocks/todo_mocks.dart`](./test/mocks/todo_mocks.dart): File for storing a list of mock TODOs.
  - [`test/api_test.dart`](./test/api_test.dart): Unit test for API communication.
  - [`test/lexer_test.dart`](./test/lexer_test.dart): Unit test for lexer
  - [`test/parser_test.dart`](./test/parser_test.dart): Unit test for parser

## Supported platforms

- Linux: Working properly on Manjaro Arch Linux and Ubuntu.
- Windows: It might work, but it was not tested.
- macOS: It might work, but it was not tested.

## License

This project is licensed under the MIT license. See [LICENSE](LICENSE).
