class FileClass
{
  FileClass({
    this.name,
    this.size,
    this.type,
    this.url,
  });

  String? name;
  String? size;
  String? type;
  String? url;

  factory FileClass.fromJson(Map<String, dynamic> json) => FileClass(
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