import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_app/features/all_songs/widgets/custom_query_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'dart:developer';
import 'package:just_audio/just_audio.dart';

class NowPlaying extends StatefulWidget {
  final SongModel songModel;
  final AudioPlayer audioPlayer;
  const NowPlaying(
      {super.key, required this.songModel, required this.audioPlayer});

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  Duration duration = const Duration();
  Duration position = const Duration();
  bool isPlaying = false;
  @override
  void initState() {
    playSongs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(child: CustomQueryWidget()),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    widget.songModel.displayNameWOExt,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${widget.songModel.artist}",
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(position.toString().split(".")[0]),
                      Expanded(
                          child: Slider(
                              min: const Duration(milliseconds: 0)
                                  .inSeconds
                                  .toDouble(),
                              value: position.inSeconds.toDouble(),
                              max: duration.inSeconds.toDouble(),
                              onChanged: (value) {
                                setState(() {
                                  changeToSeconds(value.toInt());
                                  value = value;
                                });
                              })),
                      Text(duration.toString().split(".")[0])
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.skip_previous,
                            size: 40,
                          )),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if (isPlaying) {
                                pause();
                              } else if (isPlaying == false) {
                                resume();
                              }
                              isPlaying = !isPlaying;
                            });
                          },
                          icon: Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                            size: 40,
                            color: Colors.orangeAccent,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.skip_next,
                            size: 40,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  playSongs() {
    try {
      widget.audioPlayer.setAudioSource(AudioSource.uri(
        Uri.parse(widget.songModel.uri!),
        tag: MediaItem(
          id: '${widget.songModel.id}',
          album: "${widget.songModel.album}",
          title: widget.songModel.displayNameWOExt,
          artUri: Uri.parse('https://example.com/albumart.jpg'),
        ),
      ));
      widget.audioPlayer.play();
      isPlaying = true;
    } catch (e) {
      log("Error parsing song");
    }
    widget.audioPlayer.durationStream.listen((p) {
      setState(() {
        duration = p!;
      });
    });
    widget.audioPlayer.positionStream.listen((p) {
      setState(() {
        position = p;
      });
    });
  }

  pause() {
    widget.audioPlayer.pause();
  }

  resume() {
    widget.audioPlayer.play();
  }

  void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    widget.audioPlayer.seek(duration);
  }
}
