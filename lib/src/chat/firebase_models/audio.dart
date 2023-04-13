class Audio
{
  Audio({
    this.name,
    this.size,
    this.type,
    this.url,
  });

  String? name;
  int? size;
  String? type;
  String? url;
  bool isAudioPlayed = false;

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
    name: json["name"],
    size: json["size"],
    type: json["type"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "size": size,
    "type": type,
    "url": url,
  };
}