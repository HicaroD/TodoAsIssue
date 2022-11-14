class Configuration {
  late String owner;
  late String repoNameGitHub;
  late String repoIdGitlab;
  late String githubToken;
  late String gitlabToken;
  late String platform;

  Configuration({
    required this.owner,
    required this.repoNameGitHub,
    required this.repoIdGitlab,
    required this.githubToken,
    required this.gitlabToken,
    required this.platform,
  });

  Configuration.fromJson(Map<String, dynamic> json) {
    owner = json['owner'];
    repoNameGitHub = json['repo_name_github'];
    repoIdGitlab = json['repo_id_gitlab'];
    githubToken = json['github_token'];
    gitlabToken = json['gitlab_token'];
    platform = json['platform'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['owner'] = owner;
    data['repo_name_github'] = repoNameGitHub;
    data['repo_id_gitlab'] = repoIdGitlab;
    data['github_token'] = githubToken;
    data['gitlab_token'] = gitlabToken;
    data['platform'] = platform;
    return data;
  }
}
