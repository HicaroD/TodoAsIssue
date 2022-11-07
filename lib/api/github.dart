class GitHub {
  GitHub._internal();
  static final GitHub _singleton = GitHub._internal();
  static get inst => _singleton;
}
