import 'package:comments_assignment/models/comments.dart';
import 'package:comments_assignment/services/api_service.dart';
import 'package:comments_assignment/services/remote_config_service.dart';
import 'package:comments_assignment/utils/email_masking_util.dart';
import 'package:flutter/material.dart';

class CommentsViewModel extends ChangeNotifier {
  List<Comment> comments = [];
  bool isLoading = false;
  bool showFullEmail = FirebaseRemoteConfigService.showFullEmail;

  Future<void> fetchComments() async {
    isLoading = true;
    notifyListeners();
    comments = await ApiService.fetchComments();
    isLoading = false;
    notifyListeners();
  }

  String getEmail(Comment comment) {
    return showFullEmail
        ? comment.email
        : EmailMaskingUtil.maskEmail(comment.email);
  }
}
