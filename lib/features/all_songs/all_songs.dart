import 'package:flutter/material.dart';
import 'package:music_app/features/all_songs/widgets/all_songs_body.dart';

class AllSongs extends StatelessWidget {
  const AllSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Music Player 2024"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: const AllSongsBody(),
    );
  }
}
