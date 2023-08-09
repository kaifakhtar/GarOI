class Video {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String channelTitle;
  final String description;
  final int position;
  final DateTime? dateTime;
  double completionPercentage; // New property

  Video({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.channelTitle,
    required this.description,
    required this.position,
    required this.dateTime,
    this.completionPercentage = 0.0, // Default value is 0.0
  });

  factory Video.fromMap(Map<String, dynamic> snippet, Map<String, dynamic> contentDetails) {
    final String videoId = snippet['resourceId']['videoId'];
    final String videoTitle = snippet['title'];
    final String thumbnailUrl = snippet['thumbnails']?['standard']?['url'] ?? 'https://fastly.picsum.photos/id/130/3807/2538.jpg?hmac=Kl_ZLgNPUBhsKnffomgQvxWA17JhdNLYBnwlPHBEias';
    final String channelTitle = snippet['channelTitle'];
    final String description = snippet['description'];
    final int position = snippet['position'];

    DateTime? dateTime;

    if (contentDetails.containsKey('videoPublishedAt')) {
      final String publishedAt = contentDetails['videoPublishedAt'];
      dateTime = DateTime.parse(publishedAt);
    }

    return Video(
      id: videoId,
      title: videoTitle,
      thumbnailUrl: thumbnailUrl,
      channelTitle: channelTitle,
      description: description,
      position: position,
      dateTime: dateTime,
    );
  }

  @override
  String toString() {
    return 'Video: {id: $id, title: $title, thumbnailUrl: $thumbnailUrl, channelTitle: $channelTitle, description: $description, position: $position, dateTime: $dateTime, completionPercentage: $completionPercentage}';
  }
}
