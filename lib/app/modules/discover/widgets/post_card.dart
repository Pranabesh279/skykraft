import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:skycraft/app/models/posts/post_data_model.dart';
import 'package:skycraft/app/modules/uploadMedia/widgets/video_player_network.dart';
import 'package:skycraft/app/widgets/profile_image.dart';

class PostCard extends StatelessWidget {
  final Posts post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 2,
      ),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ProfileImage(
                size: 40,
                image: post.user?.photoUrl ?? "",
                userRole: post.user?.role ?? "",
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.user?.name ?? "",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    post.createdAt.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            post.caption ?? "",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
              height: 200,
              width: double.infinity,
              child: buildImage(post.url ?? "", post.fileType ?? "")),
          const SizedBox(height: 10),
          Row(
            children: [
              ReactionButton<String>(
                boxPadding: const EdgeInsets.all(10),
                itemsSpacing: 10,
                onReactionChanged: (Reaction<String>? reaction) {
                  debugPrint('Selected value: ${reaction?.value}');
                },
                reactions: <Reaction<String>>[...reactions],
                selectedReaction: const Reaction<String>(
                  value: 'like',
                  icon: Icon(
                    Icons.thumb_up,
                    color: Colors.blue,
                  ),
                ),
                itemSize: const Size(20, 20),
                // child: Container(
                //   padding: const EdgeInsets.all(10),
                //   child: const Text('Like'),
                // ),
              ),
              const Text(' ${0}'),
              const Spacer(),
              Column(
                children: [
                  const Text('Buy Now'),
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/coins.png',
                        width: 30,
                        height: 30,
                      ),
                      Text(' ${post.price}'),
                    ],
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildImage(String url, String fileType) {
    final List<String> imageExtensions = [
      'jpg',
      'jpeg',
      'png',
    ];
    final List<String> videoExtensions = ['mp4', 'mov', 'avi', 'flv'];
    if (imageExtensions.contains(fileType)) {
      return Image.network(url, fit: BoxFit.cover);
    } else if (videoExtensions.contains(fileType)) {
      return VideoPlayerNetwork(
        videoFile: url,
      );
    } else {
      return const SizedBox();
    }
  }

  List<Reaction<String>> get reactions => <Reaction<String>>[
        const Reaction<String>(
          value: 'like',
          icon: Icon(Icons.thumb_up),
        ),
        const Reaction<String>(
          value: 'love',
          icon: Icon(Icons.favorite),
        ),
      ];
}
