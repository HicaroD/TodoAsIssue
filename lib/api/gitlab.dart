class GitLab {
  GitLab._internal();
  static final GitLab _singleton = GitLab._internal();
  static get inst => _singleton;
}
