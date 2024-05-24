import 'package:flutter/material.dart';
import 'package:music_app/features/all_songs/provider/sogs_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class CustomQueryWidget extends StatelessWidget {
  const CustomQueryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
      id: context.watch<SongsProvider>().id,
      type: ArtworkType.AUDIO,
      artworkHeight: 200,
      artworkWidth: 200,
      artworkFit: BoxFit.fill,
      nullArtworkWidget: const Icon(
        Icons.music_note,
        size: 200,
      ),
    );
  }
}
