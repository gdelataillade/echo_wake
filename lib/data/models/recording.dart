class Recording {
  final String id;
  final String name;
  final String path;

  Recording({required this.id, required this.name, required this.path});

  Recording copyWith({String? id, String? name, String? path}) {
    return Recording(
      id: id ?? this.id,
      name: name ?? this.name,
      path: path ?? this.path,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'path': path};
  }

  factory Recording.fromJson(Map<String, dynamic> json) {
    return Recording(id: json['id'], name: json['name'], path: json['path']);
  }
}
