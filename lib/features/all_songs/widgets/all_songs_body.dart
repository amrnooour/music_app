import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/core/functions/request_permission.dart';
import 'package:music_app/features/all_songs/now_playing.dart';
import 'package:music_app/features/all_songs/provider/sogs_provider.dart';
import 'package:music_app/features/all_songs/widgets/custom_list_view_item.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class AllSongsBody extends StatefulWidget {
  const AllSongsBody({super.key});

  @override
  State<AllSongsBody> createState() => _AllSongsBodyState();
}

class _AllSongsBodyState extends State<AllSongsBody> {
  final AudioPlayer audioPlayer = AudioPlayer();
  final audioQuery = OnAudioQuery();
  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
      future: audioQuery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.data!.isEmpty) {
          return const Center(child: Text("No Songs Found"));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => CustomListViewItem(
              queryArtworkWidget: QueryArtworkWidget(
                artworkHeight: 40,
                artworkWidth: 40,
                artworkFit: BoxFit.fill,
                id: snapshot.data![index].id,
                type: ArtworkType.AUDIO,
                nullArtworkWidget: const Icon(Icons.music_note),
              ),
              onPressed: () {
                context.read<SongsProvider>().setId(snapshot.data![index].id);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NowPlaying(
                        songModel: snapshot.data![index],
                        audioPlayer: audioPlayer,
                      ),
                    ));
              },
              title: snapshot.data![index].displayNameWOExt,
              subTitle: "${snapshot.data![index].artist}",
            ),
          );
        }
      },
    );
  }
}
