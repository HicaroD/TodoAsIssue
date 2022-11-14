class Configuration {
  late String owner;
  late String repoName;
  late String githubToken;
  late String gitlabToken;
  late String platform;

  Configuration({
    required this.owner,
    required this.repoName,
    required this.githubToken,
    required this.gitlabToken,
    required this.platform,
  });

  Configuration.fromJson(Map<String, dynamic> json) {
    owner = json['owner'];
    repoName = json['repo_name'];
    githubToken = json['github_token'];
    gitlabToken = json['gitlab_token'];
    platform = json['platform'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['owner'] = owner;
    data['repo_name'] = repoName;
    data['github_token'] = githubToken;
    data['gitlab_token'] = gitlabToken;
    data['platform'] = platform;
    return data;
  }
}
