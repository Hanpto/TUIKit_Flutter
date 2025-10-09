import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart' as just_audio;

class AudioPlayer {
  final _player = just_audio.AudioPlayer();
  
  String? _currentPath;

  VoidCallback? _onComplete;

  bool _isPaused = false;
  
  bool get isPlaying => _player.playing;

  bool get isPaused => _isPaused;
  
  Stream<Duration> get positionStream => _player.positionStream;
  
  Stream<just_audio.PlayerState> get playerStateStream => _player.playerStateStream;
  
  AudioPlayer._();
  
  static AudioPlayer createInstance() {
    return AudioPlayer._();
  }
  
  Future<void> play(String filePath, {VoidCallback? onComplete}) async {
    try {
      _isPaused = false;
      if (_currentPath == filePath && isPlaying) {
        await stop();
        return;
      }
      
      if (isPlaying) {
        await stop();
      }
      
      _onComplete = onComplete;
      _currentPath = filePath;

      await _player.setFilePath(filePath);
      
      _player.playerStateStream.listen((state) {
        if (state.processingState == just_audio.ProcessingState.completed) {
          _onComplete?.call();
        }
      });
      
      await _player.play();
    } catch (e) {
      debugPrint('play failed: $e');
      rethrow;
    }
  }
  
  Future<void> pause() async {
    _isPaused = true;
    await _player.pause();
  }

  Future<void> resume() async {
    _isPaused = false;
  }

  Future<void> stop() async {
    await _player.stop();
    _currentPath = null;
  }

  int getCurrentPosition() {
    return _player.position.inMilliseconds;
  }

  int getDuration() {
    return _player.duration?.inMilliseconds ?? 0;
  }
  
  Future<void> dispose() async {
    await _player.dispose();
  }

} 