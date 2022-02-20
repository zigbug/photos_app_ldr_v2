import 'package:flutter/material.dart';
import 'package:photos_app_ldr_v2/screens/grid_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Wow Photos')),
      ),
      body: const GridScreenPhotos(),
    );
  }
}
