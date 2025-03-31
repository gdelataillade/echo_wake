import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import '../../../domain/services/storage.dart';

class RecordingsScreen extends StatefulWidget {
  final bool selectionMode;

  const RecordingsScreen({super.key, this.selectionMode = false});

  @override
  State<RecordingsScreen> createState() => _RecordingsScreenState();
}

class _RecordingsScreenState extends State<RecordingsScreen> {
  late final recorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isRecording = false;
  List<Recording> _recordings = [];
  Timer? _timer;
  Duration _recordingDuration = Duration.zero;
  late final StorageService _storage;

  @override
  void initState() {
    super.initState();
    _initializeStorage();
  }

  @override
  void dispose() {
    _timer?.cancel();
    recorder.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _recordingDuration += const Duration(seconds: 1);
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _recordingDuration = Duration.zero;
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return duration.inHours > 0
        ? '$hours:$minutes:$seconds'
        : '$minutes:$seconds';
  }

  Future<void> _initializeStorage() async {
    _storage = await StorageService.getInstance();
    _loadRecordings();
  }

  Future<void> _loadRecordings() async {
    final recordingsJson = _storage.getStringList('recordings') ?? [];
    setState(() {
      _recordings =
          recordingsJson
              .map((json) => Recording.fromJson(jsonDecode(json)))
              .toList();
    });
  }

  Future<void> _startRecording() async {
    try {
      if (await recorder.hasPermission()) {
        final dir = await getApplicationDocumentsDirectory();
        final path =
            '${dir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.wav';
        await recorder.start(
          const RecordConfig(
            encoder: AudioEncoder.wav,
            sampleRate: 44100,
            numChannels: 1,
            bitRate: 128000,
          ),
          path: path,
        );
        setState(() {
          _isRecording = true;
        });
        _startTimer();
      }
    } catch (e) {
      debugPrint('Error starting recording: $e');
    }
  }

  Future<void> _stopRecording() async {
    try {
      final path = await recorder.stop();
      _stopTimer();
      setState(() {
        _isRecording = false;
      });

      if (path != null) {
        _showSaveDialog(path);
      }
    } catch (e) {
      debugPrint('Error stopping recording: $e');
    }
  }

  Future<void> _cancelRecording() async {
    try {
      await recorder.stop();
      _stopTimer();
      setState(() {
        _isRecording = false;
      });
    } catch (e) {
      debugPrint('Error canceling recording: $e');
    }
  }

  Future<void> _showSaveDialog(String path) async {
    final nameController = TextEditingController();
    return showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Save Recording'),
            content: TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Recording Name'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  final recording = Recording(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: nameController.text,
                    path: path,
                  );
                  await _saveRecording(recording);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
    );
  }

  Future<void> _saveRecording(Recording recording) async {
    _recordings.add(recording);
    final recordingsJson =
        _recordings.map((recording) => jsonEncode(recording.toJson())).toList();
    await _storage.setStringList('recordings', recordingsJson);
    setState(() {});
  }

  Future<void> _deleteRecording(Recording recording) async {
    _recordings.removeWhere((r) => r.id == recording.id);
    final recordingsJson =
        _recordings.map((recording) => jsonEncode(recording.toJson())).toList();
    await _storage.setStringList('recordings', recordingsJson);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Voice Recordings'), elevation: 0),
      body: Column(
        children: [
          if (_isRecording)
            Container(
              padding: const EdgeInsets.all(16),
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.mic,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _formatDuration(_recordingDuration),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FilledButton.icon(
                        onPressed: _cancelRecording,
                        icon: const Icon(Icons.close),
                        label: const Text('Cancel'),
                        style: FilledButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.error,
                          foregroundColor:
                              Theme.of(context).colorScheme.onError,
                        ),
                      ),
                      FilledButton.icon(
                        onPressed: _stopRecording,
                        icon: const Icon(Icons.stop),
                        label: const Text('Stop'),
                        style: FilledButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          Expanded(
            child:
                _recordings.isEmpty
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.mic_none,
                            size: 64,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No recordings yet',
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                        ],
                      ),
                    )
                    : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: _recordings.length,
                      itemBuilder: (context, index) {
                        final recording = _recordings[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            title: Text(
                              recording.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            leading: CircleAvatar(
                              backgroundColor:
                                  Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer,
                              child: Icon(
                                Icons.audio_file,
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.onPrimaryContainer,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.play_arrow),
                                  onPressed: () async {
                                    await _audioPlayer.play(
                                      DeviceFileSource(recording.path),
                                    );
                                  },
                                ),
                                if (!widget.selectionMode) ...[
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed:
                                        () => _showRenameDialog(recording),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed:
                                        () => _deleteRecording(recording),
                                  ),
                                ],
                                if (widget.selectionMode)
                                  Icon(
                                    Icons.chevron_right,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                              ],
                            ),
                            onTap:
                                widget.selectionMode
                                    ? () => Navigator.pop(context, recording)
                                    : null,
                          ),
                        );
                      },
                    ),
          ),
          if (!_isRecording)
            Padding(
              padding: const EdgeInsets.all(16),
              child: FilledButton.icon(
                onPressed: _startRecording,
                icon: const Icon(Icons.mic),
                label: const Text('Start Recording'),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _showRenameDialog(Recording recording) async {
    final nameController = TextEditingController(text: recording.name);
    return showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Rename Recording'),
            content: TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'New Name'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  final index = _recordings.indexWhere(
                    (r) => r.id == recording.id,
                  );
                  if (index != -1) {
                    _recordings[index] = recording.copyWith(
                      name: nameController.text,
                    );
                    final recordingsJson =
                        _recordings
                            .map((recording) => jsonEncode(recording.toJson()))
                            .toList();
                    await _storage.setStringList('recordings', recordingsJson);
                    setState(() {});
                  }
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
    );
  }
}

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
