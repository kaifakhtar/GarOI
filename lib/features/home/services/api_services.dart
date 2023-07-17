import 'dart:convert';
import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/channel_model.dart';
import '../../../models/playlistmodal.dart';
import '../../../models/video_model.dart';
import '../../../utilities/keys.dart';

class APIService {
  APIService._instantiate();
  String etag = '';
  static final APIService instance = APIService._instantiate();

  final String _baseUrl = 'www.googleapis.com';
  String _nextPageToken = '';
  String _nextPageTokenForPlaylist = '';

  final cacheManager = DefaultCacheManager();

  Future<Channel> fetchChannel({required String channelId}) async {
    Map<String, String> parameters = {
      'part': 'snippet, contentDetails, statistics',
      'id': channelId,
      'key': dotenv.env['API_KEY'] ?? "",
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
      // channel.videos = await fetchVideosFromPlaylist(
      //   playlistId: channel.uploadPlaylistId,
      // );
      return channel;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
// Flag to track availability of more items
  // Flag to track availability of more items

  Future<List<Video>> fetchVideosFromPlaylist(
      {required String playlistId}) async {
    // Obtain shared preferences.
    String keyForEtag = playlistId;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    etag = prefs.getString(keyForEtag) ?? ''; //* get from this key else ''

    Map<String, String> parameters = {
      'part': 'snippet,contentDetails',
      'playlistId': playlistId,
      'maxResults': '1000',
      //'pageToken': _nextPageToken,
      'key': dotenv.env['API_KEY'] ?? "",
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    Map<String, String> headers = {
      'If-None-Match': etag,
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      // Get Playlist Videos
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        print(response.headers);
        print("response code is ${response.statusCode}");
        // Cache the data
        await cacheManager.putFile(uri.toString(), response.bodyBytes);

        var data = json.decode(response.body);
        etag = data['etag'];
        await prefs.setString(keyForEtag, etag); //* store the etag in the prefs

        print("etag is in 200 ${etag}");
        int totalVideosFromResponse = data['pageInfo']['totalResults'];

        _nextPageToken = data['nextPageToken'] ?? '';
        // List<dynamic> videosJson = data['items'];

        // // Fetch videos from uploads playlist
        // List<Video> videos = [];

        // for (var json in videosJson) {
        //   videos.add(
        //     Video.fromMap(json['snippet']),
        //   );
        // }

        // return videos;
        return getVideosFromResponse(data);
      } else if (response.statusCode == 304) {
        print("etag is in 304 taken from prefs ${etag}");
        print("response code is ${response.statusCode}");
        // Get the data from the cache
        final file = await cacheManager.getFileFromCache(uri.toString());
        List<Video> videos = [];
        if (file != null) {
          final cachedData = file.file;
          // Process the cached data as needed
          final data = json.decode(cachedData.readAsStringSync());
          videos = getVideosFromResponse(data);
        }
        return videos;
      } else {
        throw Exception('Failed to fetch videos: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to fetch videos: $error');
    }
  }

  Future<List<Playlist>> fetchPlaylists({required String channelId}) async {
    String keyForEtag = channelId;
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // etag = prefs.getString(keyForEtag) ?? ''; //* get from this key else ''

    Map<String, String> parameters = {
      'part': 'snippet,contentDetails',
      'channelId': channelId,
      'maxResults': '1000',
      'pageToken': _nextPageTokenForPlaylist,
      'key': API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlists',
      parameters,
    );
    Map<String, String> headers = {
      // 'If-None-Match': etag,
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Channel
    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      // await cacheManager.putFile(uri.toString(), response.bodyBytes);
      final listOfPlaylistsJSON = json.decode(response.body)['items'];

      final jsondata = json.decode(response.body);
      etag = jsondata['etag'];
      //  print(etag + "etag of playlists");
      //await prefs.setString(keyForEtag, etag); //* store the etag in the prefs
      // if (jsondata.containsKey('nextPageToken')) {
      //   _nextPageTokenForPlaylist = jsondata['nextPageToken'];
      //   // Perform the desired action when 'nextPageToken' exists
      // }

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
      // } else if (response.statusCode == 304) {
      //   final file = await cacheManager.getFileFromCache(uri.toString());
      //   print("responce ${response.statusCode}");
      //   if (file != null) {
      //     final cachedData = file.file;
      //     // Process the cached data as needed
      //     final listOfPlaylistsJSON =
      //         json.decode(cachedData.readAsStringSync())['items'];
      //     // final listOfPlaylistsJSON = json.decode(response.body)['items'];
      //     List<Playlist> listOfPlaylistModals = [];
      //     for (var json in listOfPlaylistsJSON) {
      //       listOfPlaylistModals.add(
      //         Playlist.fromMap(json),
      //       );
      //     }
      //     return listOfPlaylistModals;
      //   }
      //   return [];
      // }
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  List<Video> getVideosFromResponse(data) {
    List<dynamic> videosJson = data['items'];

    // Fetch videos from uploads playlist
    List<Video> videos = [];

    for (var json in videosJson) {
      videos.add(
        Video.fromMap(json['snippet'], json['contentDetails']),
      );
    }

    return videos;
  }
}
