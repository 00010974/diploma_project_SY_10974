import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YouTubeViewer extends StatelessWidget {
  final String videoId;
  const YouTubeViewer({required this.videoId, super.key});

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerControllerProvider(
      controller: YoutubePlayerController(
        initialVideoId: videoId,
        params: YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text('YouTube Видео')),
        body: const YoutubePlayerIFrame(),
      ),
    );
  }
}
