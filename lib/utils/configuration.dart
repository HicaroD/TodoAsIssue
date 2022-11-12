class Configuration {
  late String owner;
  late String repoName;
  late String token;
  late String platform;

  Configuration({
    required this.owner,
    required this.repoName,
    required this.token,
    required this.platform,
  });

  Configuration.fromJson(Map<String, dynamic> json) {
    owner = json['owner'];
    repoName = json['repo_name'];
    token = json['token'];
    platform = json['platform'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['owner'] = owner;
    data['repo_name'] = repoName;
    data['token'] = token;
    data['platform'] = platform;
    return data;
  }
}
