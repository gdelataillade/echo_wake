class Recording {
  final String id;
  final String name;
  final String path;
  final Duration duration;

  Recording({
    required this.id,
    required this.name,
    required this.path,
    required this.duration,
  });

  Recording copyWith({
    String? id,
    String? name,
    String? path,
    Duration? duration,
  }) {
    return Recording(
      id: id ?? this.id,
      name: name ?? this.name,
      path: path ?? this.path,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'path': path,
      'duration': duration.inMilliseconds,
    };
  }

  factory Recording.fromJson(Map<String, dynamic> json) {
    return Recording(
      id: json['id'],
      name: json['name'],
      path: json['path'],
      duration: Duration(milliseconds: json['duration']),
    );
  }
}
