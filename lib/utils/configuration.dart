class Configuration {
  late String owner;
  late String repoName;
  late String token;

  Configuration({
    required this.owner,
    required this.repoName,
    required this.token,
  });

  Configuration.fromJson(Map<String, dynamic> json) {
    owner = json['owner'];
    repoName = json['repo_name'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['owner'] = owner;
    data['repo_name'] = repoName;
    data['token'] = token;
    return data;
  }
}
