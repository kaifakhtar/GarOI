import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../models/channel_model.dart';
import '../../../models/playlistmodal.dart';
import '../../../models/video_model.dart';
import '../../../utilities/keys.dart';

class APIService {
  APIService._instantiate();

  static final APIService instance = APIService._instantiate();

  final String _baseUrl = 'www.googleapis.com';
  String _nextPageToken = '';
  String _nextPageTokenForPlaylist = '';

  Future<Channel> fetchChannel({required String channelId}) async {
    Map<String, String> parameters = {
      'part': 'snippet, contentDetails, statistics',
      'id': channelId,
      'key': API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/channels',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Channel
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['items'][0];
      Channel channel = Channel.fromMap(data);

      // Fetch first batch of videos from uploads playlist
      channel.videos = await fetchVideosFromPlaylist(
        playlistId: channel.uploadPlaylistId,
      );
      return channel;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<List<Video>> fetchVideosFromPlaylist({required playlistId}) async { ///TODO: Error resolve, last videos adding again and again
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': '8',
      'pageToken': _nextPageToken,
      'key': API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Playlist Videos
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      _nextPageToken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];

      // Fetch first eight videos from uploads playlist
      List<Video> videos = [];
      videosJson.forEach(
        (json) => videos.add(
          Video.fromMap(json['snippet']),
        ),
      );
      return videos;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<List<Playlist>> fetchPlaylists({required String channelId}) async {
    Map<String, String> parameters = {
      'part': 'snippet,contentDetails',
      'channelId': channelId,
      'pageToken': _nextPageTokenForPlaylist,
      'key': API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlists',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Channel
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final listOfPlaylistsJSON = json.decode(response.body)['items'];

      final jsondata = json.decode(response.body);
  if (jsondata.containsKey('nextPageToken')) {
    _nextPageTokenForPlaylist = jsondata['nextPageToken'];
    // Perform the desired action when 'nextPageToken' exists
  }

      List<Playlist> listOfPlaylistModals = [];
      for (var json in listOfPlaylistsJSON) {
        listOfPlaylistModals.add(
          Playlist.fromMap(json),
        );
      }

      print(listOfPlaylistModals);
      return listOfPlaylistModals;

      // Map<String, dynamic> data = json.decode(response.body)['items'][0];
      // print(data.toString());

      // Fetch first batch of videos from uploads playlist
      // channel.videos = await fetchVideosFromPlaylist(
      //   playlistId: channel.uploadPlaylistId,
      // );
      // return channel;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
}
