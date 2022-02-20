import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class PhotoScreen extends StatelessWidget {
  const PhotoScreen({Key? key, required this.imagePath}) : super(key: key);
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Image.network(
            imagePath,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  Share.share(imagePath, subject: 'Just take a look at this!');
                },
                child: const Icon(Icons.share),
              ),
            ),
          )
        ],
      ),
    );
  }
}
