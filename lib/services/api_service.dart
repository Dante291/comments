import 'package:comments_assignment/constants/api_constant.dart';
import 'package:comments_assignment/models/comments.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<List<Comment>> fetchComments() async {
    final response = await http.get(Uri.parse(ApiConstants.commentsApiUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((comment) => Comment.fromJson(comment)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }
}
