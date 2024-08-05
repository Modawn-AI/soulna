import 'dart:developer';

import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

// class InstagramService {
//   final String accessToken;
//
//   InstagramService(this.accessToken);
//
//   Future<List<String>> fetchInstagramPhotos() async {
//     final response = await http.get(Uri.parse(
//         'https://graph.instagram.com/me/media?fields=id,''IMAGE',media_url&access_token=$accessToken'));
//
//     if (response.statusCode == 200) {
//       List<String> photos = [];
//       Map<String, dynamic> data = json.decode(response.body);
//       for (var item in data['data']) {
//         if (item['media_type'] == 'IMAGE') {
//           photos.add(item['media_url']);
//         }
//       }
//       return photos;
//     } else {
//       throw Exception('Failed to load photos');
//     }
//   }
// }

class InstagramPhotos extends StatefulWidget {
  final String accessToken;

  InstagramPhotos(this.accessToken);

  @override
  State<InstagramPhotos> createState() => _InstagramPhotosState();
}

class _InstagramPhotosState extends State<InstagramPhotos> {
  List<String> photos = [];
//  late InstagramService instagramService;

  Future<Map<String, dynamic>> getAccessToken() async {
    final response = await http.get(Uri.parse(
        'https://api.instagram.com/oauth/authorize ?client_id="1351601271377342"&client_secret= "85167ee0029ac1877247973f204ce167" &redirect_uri="https://socialsizzle.herokuapp.com/auth/" &grant_type= "authorization_code"&scope="[user_profile , user_media]" &response_type="code" '));

    log('response ${response.body}');
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get access token');
    }
  }

  @override
  void initState() {
    getAccessToken();

    super.initState();

    // instagramService = InstagramService(widget.accessToken);
    // fetchInstagramPhotos();
  }

  // Future<void> fetchInstagramPhotos() async {
  //   try {
  //     List<String> fetchedPhotos = await instagramService.fetchInstagramPhotos();
  //     setState(() {
  //       photos = fetchedPhotos;
  //     });
  //   } catch (e) {
  //     // Handle error
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Image.network(photos[index]);
      },
    );
  }
}