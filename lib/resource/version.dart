part of dart_k8s_client;

@JsonSerializable()
class Version {
  int major;
  int minor;
  String gitVersion;
  String gitCommit;
  String gitTreeState;
  DateTime buildDate;
  String goVersion;
  String compiler;
  String platform;

  Version(
      {this.major,
      this.minor,
      this.gitVersion,
      this.gitCommit,
      this.gitTreeState,
      this.buildDate,
      this.goVersion,
      this.compiler,
      this.platform});

  factory Version.fromJson(Map<String, dynamic> json) {
    return Version(major: int.parse(json["major"]),
      minor: int.parse(json["minor"]),
      gitVersion: json["gitVersion"],
      gitCommit: json["gitCommit"],
      gitTreeState: json["gitTreeState"],
      buildDate: DateTime.parse(json["buildDate"]),
      goVersion: json["goVersion"],
      compiler: json["compiler"],
      platform: json["platform"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "major": this.major,
      "minor": this.minor,
      "gitVersion": this.gitVersion,
      "gitCommit": this.gitCommit,
      "gitTreeState": this.gitTreeState,
      "buildDate": this.buildDate.toIso8601String(),
      "goVersion": this.goVersion,
      "compiler": this.compiler,
      "platform": this.platform
    };
  }
}
