import 'package:comments_assignment/services/auth_service.dart';
import 'package:comments_assignment/widgets/comment_card.dart';
import 'package:comments_assignment/widgets/loading_indicator.dart';
import 'package:comments_assignment/widgets/log_out_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/comments_view_model.dart';

class CommentsView extends StatefulWidget {
  const CommentsView({super.key});

  @override
  _CommentsViewState createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {
  final ScrollController _scrollController = ScrollController();
  bool _showFab = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    Provider.of<CommentsViewModel>(context, listen: false).fetchComments();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >= 300) {
      if (!_showFab) {
        setState(() {
          _showFab = true;
        });
      }
    } else {
      if (_showFab) {
        setState(() {
          _showFab = false;
        });
      }
    }
  }

  Future<void> _refreshComments() async {
    await Future.delayed(const Duration(seconds: 1));
    Provider.of<CommentsViewModel>(context, listen: false).fetchComments();
  }

  void showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => LogoutDialog(
        onCancel: () => Navigator.pop(context),
        onLogout: () {
          FirebaseAuthService.signOut(context);
          Navigator.of(context).pushReplacementNamed('/signin');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _showFab
          ? FloatingActionButton(
              backgroundColor: const Color(0xff0C54BE),
              onPressed: () {
                _scrollController.animateTo(
                  0.0,
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 300),
                );
              },
              child: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            )
          : null,
      backgroundColor: const Color(0xffF5F9FD),
      appBar: AppBar(
        backgroundColor: const Color(0xff0C54BE),
        title: const Text(
          'Comments',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.logout),
            onPressed: showLogoutDialog,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshComments,
        child: Consumer<CommentsViewModel>(
          builder: (context, model, child) {
            if (model.isLoading) {
              return LoadingIndicator();
            }
            return Padding(
              padding:
                  const EdgeInsets.only(top: 16, bottom: 2, left: 6, right: 6),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: model.comments.length,
                itemBuilder: (context, index) {
                  return CommentCard(comment: model.comments[index]);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
