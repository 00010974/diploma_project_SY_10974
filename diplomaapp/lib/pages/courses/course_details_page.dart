ElevatedButton(
  child: Text("Смотреть видеоурок"),
  onPressed: () {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => VideoPlayerPage(
        videoUrl: course.videoUrl!,
        type: 'mp4', // 'youtube', 'vimeo', 'mp4'
      ),
    ));
  },
)
