import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart' as video_player;

class VideoData {
  final String? localPath;
  final String? url;
  final String? snapshotLocalPath;
  final String? snapshotUrl;
  final int duration;
  final int width;
  final int height;

  VideoData({
    this.localPath,
    this.url,
    this.snapshotLocalPath,
    this.snapshotUrl,
    this.duration = 0,
    this.width = 0,
    this.height = 0,
  });
}

class VideoPlayerWidget extends StatefulWidget {
  final VideoData video;

  const VideoPlayerWidget({
    super.key,
    required this.video,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  video_player.VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _isLoading = true;
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      final videoPath = widget.video.localPath ?? widget.video.url;
      if (videoPath == null) {
        throw Exception('No video path available');
      }

      _controller = video_player.VideoPlayerController.network(videoPath);
      await _controller!.initialize();
      
      _totalDuration = _controller!.value.duration;
      
      _controller!.addListener(_videoListener);
      
      if (mounted) {
        setState(() {
          _isInitialized = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('initialize failed: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _videoListener() {
    if (mounted) {
      setState(() {
        _currentPosition = _controller!.value.position;
        _isPlaying = _controller!.value.isPlaying;
      });
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return hours == '00' ? '$minutes:$seconds' : '$hours:$minutes:$seconds';
  }

  @override
  void dispose() {
    _controller?.removeListener(_videoListener);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          if (_isInitialized)
            Center(
              child: AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: video_player.VideoPlayer(_controller!),
              ),
            ),
          
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          
          if (!_isLoading && !_isInitialized)
            const Center(
              child: Text(
                'error',
                style: TextStyle(color: Colors.white),
              ),
            ),
          
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
            child: Column(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const Spacer(),
                
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SliderTheme(
                        data: SliderThemeData(
                          trackHeight: 2,
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                          overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
                          activeTrackColor: Colors.white,
                          inactiveTrackColor: Colors.white.withOpacity(0.3),
                          thumbColor: Colors.white,
                          overlayColor: Colors.white.withOpacity(0.2),
                        ),
                        child: Slider(
                          value: _currentPosition.inMilliseconds.toDouble(),
                          min: 0,
                          max: _totalDuration.inMilliseconds.toDouble(),
                          onChanged: (value) {
                            final newPosition = Duration(milliseconds: value.toInt());
                            _controller!.seekTo(newPosition);
                          },
                        ),
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            Text(
                              _formatDuration(_currentPosition),
                              style: const TextStyle(color: Colors.white),
                            ),
                            
                            const Spacer(),
                            
                            IconButton(
                              icon: Icon(
                                _isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                                size: 32,
                              ),
                              onPressed: () async {
                                if (_controller == null) return;
                                
                                setState(() {
                                  _isPlaying = !_isPlaying;
                                });
                                
                                try {
                                  if (_isPlaying) {
                                    await _controller!.play();
                                  } else {
                                    await _controller!.pause();
                                  }
                                } catch (e) {
                                  if (mounted) {
                                    setState(() {
                                      _isPlaying = !_isPlaying;
                                    });
                                  }
                                  debugPrint('play/pause failed: $e');
                                }
                              },
                            ),
                            
                            const Spacer(),
                            
                            Text(
                              _formatDuration(_totalDuration),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 