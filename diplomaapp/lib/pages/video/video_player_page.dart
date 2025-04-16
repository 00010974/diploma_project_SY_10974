import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'youtube_viewer.dart'; // 👈 Добавь это

class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;
  final String type; // 'youtube', 'vimeo', 'mp4'

  const VideoPlayerPage({required this.videoUrl, required this.type, super.key});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _mp4Controller;

  @override
  void initState() {
    super.initState();
    if (widget.type == 'mp4') {
      _mp4Controller = VideoPlayerController.network(widget.videoUrl)
        ..initialize().then((_) {
          setState(() {});
          _mp4Controller.play();
        });
    }
  }

  @override
  void dispose() {
    if (widget.type == 'mp4') {
      _mp4Controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == 'youtube') {
      final videoId = YoutubePlayerController.convertUrlToId(widget.videoUrl);
      if (videoId == null) {
        return const Scaffold(body: Center(child: Text("Неверная ссылка на YouTube")));
      }
      return YouTubeViewer(videoId: videoId);
    }

    if (widget.type == 'mp4') {
      return Scaffold(
        appBar: AppBar(title: const Text("MP4 Video")),
        body: _mp4Controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _mp4Controller.value.aspectRatio,
                child: VideoPlayer(_mp4Controller),
              )
            : const Center(child: CircularProgressIndicator()),
      );
    }

    return const Scaffold(
      body: Center(child: Text("Неподдерживаемый тип видео")),
    );
  }
}
