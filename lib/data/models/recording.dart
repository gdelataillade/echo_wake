import 'package:path_provider/path_provider.dart';

class Recording {
  final String id;
  final String name;
  final String filename;
  final Duration duration;

  Recording({
    required this.id,
    required this.name,
    required this.filename,
    required this.duration,
  });

  Future<String> getFullPath() async {
    final appDir = await getApplicationDocumentsDirectory();
    return '${appDir.path}/$filename';
  }

  Recording copyWith({
    String? id,
    String? name,
    String? filename,
    Duration? duration,
  }) {
    return Recording(
      id: id ?? this.id,
      name: name ?? this.name,
      filename: filename ?? this.filename,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'filename': filename,
      'duration': duration.inMilliseconds,
    };
  }

  factory Recording.fromJson(Map<String, dynamic> json) {
    return Recording(
      id: json['id'],
      name: json['name'],
      filename: json['filename'],
      duration: Duration(milliseconds: json['duration']),
    );
  }
}
