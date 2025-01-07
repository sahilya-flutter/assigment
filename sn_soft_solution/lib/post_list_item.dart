import 'dart:math';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostListItem extends StatefulWidget {
  final dynamic post;

  const PostListItem({super.key, required this.post});

  @override
  _PostListItemState createState() => _PostListItemState();
}

class _PostListItemState extends State<PostListItem> {
  late int votes;
  late int comments;

  // List of static images from assets
  final List<String> staticImages = [
    'assets/images/download.jpeg',
    'assets/images/download1.jpeg',
    'assets/images/download2.jpg',
    'assets/images/download3.jpeg',
    'assets/images/download4.jpeg',
    'assets/images/download5.jpeg',
    'assets/images/download6.jpeg',
  ];

  @override
  void initState() {
    super.initState();
    votes = widget.post['net_votes'] ?? 0;
    comments = widget.post['children'] ?? 0;
  }

  void increaseVote() {
    setState(() {
      votes += 1;
    });
  }

  void addComment() {
    setState(() {
      comments += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final randomImage = staticImages[Random().nextInt(staticImages.length)];
    final author = widget.post['author'] ?? 'Unknown';
    final community = widget.post['community_title'] ?? 'Unknown';
    final createdTime = DateTime.parse(widget.post['created']);
    final relativeTime = timeago.format(createdTime);
    final title = widget.post['title'] ?? 'No Title';
    final shortDescription = widget.post['body'] != null
        ? widget.post['body'].toString().substring(
            0,
            widget.post['body'].toString().length > 1000
                ? 1000
                : widget.post['body'].toString().length)
        : '';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              randomImage,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    shortDescription,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$author in $community'),
                      Text(relativeTime),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: increaseVote,
                        child: Row(
                          children: [
                            const Icon(Icons.thumb_up, color: Colors.blue),
                            const SizedBox(width: 5),
                            Text('Votes: $votes'),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: addComment,
                        child: Row(
                          children: [
                            const Icon(Icons.comment, color: Colors.green),
                            const SizedBox(width: 5),
                            Text('Comments: $comments'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
