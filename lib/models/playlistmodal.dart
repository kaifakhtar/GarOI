

class Playlist {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;

  final int videoCount;

  Playlist({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.videoCount,
  });

  factory Playlist.fromMap(Map<String, dynamic> map) {
    return Playlist(
      id: map['id'],
      title: map['snippet']['title'],
      thumbnailUrl: map['snippet']['thumbnails']['standard']['url'],
      videoCount: map['contentDetails']['itemCount'],
      description: map['snippet']['description'],
    );
  }
}
