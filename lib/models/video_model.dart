class Video {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String channelTitle;

  Video({
   required this.id,
   required this.title,
   required this.thumbnailUrl,
   required this.channelTitle,
  });

  factory Video.fromMap(Map<String, dynamic> snippet) {
    return Video(
      id: snippet['resourceId']['videoId'],
      title: snippet['title'],
      thumbnailUrl: snippet['thumbnails']?['default']?['url'] ?? '',
      channelTitle: snippet['channelTitle'],
    );
  }
  
  @override
  String toString() {
    return 'Video: {id: $id, title: $title, thumbnailUrl: $thumbnailUrl, channelTitle: $channelTitle}';
  }
}