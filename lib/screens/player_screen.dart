import 'dart:developer';

import 'package:audiojet/constants.dart';
import 'package:audiojet/notifiers/progress_notifier.dart';
import 'package:audiojet/notifiers/repeat_button_notifier.dart';
import 'package:audiojet/page_manager.dart';
import 'package:audiojet/utils.dart';
import 'package:audiojet/widgets/current_song_artist.dart';
import 'package:audiojet/widgets/current_song_title.dart';
import 'package:audiojet/widgets/my_circular_slider.dart';
import 'package:audiojet/widgets/player_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee_plus/marquee.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../services/service_locator.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  // Duration duration = Duration.zero;
  // Duration position = Duration.zero;
  // bool isPlaying = true;
  // SongModel song = SongModel({});
  // AudioPlayer audioPlayer = AudioPlayer();

  var data = Get.arguments;
  //Song Related info
  // String songName = 'Iraady';
  // String artistName = 'Abdul Hannan & Rovalio';
  // List<AudioSource> audioSource = [];
  @override
  void initState() {
    super.initState();
    final pageManager = getIt<PageManager>();
    if (data != null) {
      pageManager.listenToPlayCurrentSong(data);
      pageManager.play();
    }

    // audioPlayer.setAudioSource(ConcatenatingAudioSource(children: [
    //   // AudioSource.uri(Uri.file(
    //   //     '/storage/emulated/0/Youthoob/Alan Walker & Ava Max - Alone, Pt.2.m4a')),
    //   AudioSource.uri(Uri.file(
    //       '/storage/emulated/0/Youthoob/Asim Azhar - Jo Tu Na Mila.m4a')),
    //   AudioSource.uri(Uri.file(
    //       '/storage/emulated/0/Youthoob/Abdul Hannan & Rovalio - Iraaday (Official Music Video).m4a')),
    // ]));
    // songName = allSongs[data].displayNameWOExt;
    // artistName = allSongs[data].artist!;
    // audioPlayer.setFilePath(allSongs[data].data);
    // audioPlayer.play();
  }

  // void addInPlayList() async {
  //   allSongs.forEach((element) {
  //     audioSource.add(AudioSource.uri(Uri.file(element.data)));
  //   });
  //   setState(() {});
  // }

  // get song cover image colors
  Future<PaletteGenerator> getImageColors() async {
    var paletteGenerator = PaletteGenerator.fromColors([
      PaletteColor(Colors.orange, 1),
      // PaletteColor(Colors., 1),
      PaletteColor(Colors.greenAccent, 1),
      PaletteColor(Colors.redAccent, 4),
      PaletteColor(Colors.pink, 1),
      PaletteColor(Colors.pinkAccent, 1),
      PaletteColor(Colors.green, 1),
    ]);
    // var paletteGenerator = await PaletteGenerator.fromImageProvider(
    //   const AssetImage('assets/canva.png'),
    // );
    return paletteGenerator;
  }

  // Stream<SeekBarData> get _seekBarDataStream =>
  //     rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
  //         audioPlayer.positionStream, audioPlayer.durationStream,
  //         (Duration position, Duration? duration) {
  //       return SeekBarData(position, duration ?? Duration.zero);
  //     });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    size: 30,
                    color: Colors.white,
                  )),
            ),
          ),
          extendBodyBehindAppBar: true,
          body: Stack(
            alignment: Alignment.center,
            children: [
              // FutureBuilder<PaletteGenerator>(
              //   future: getImageColors(),
              //   builder: (context, snapshot) {
              //     return Container(
              //       color: snapshot.data?.dominantColor!.color,
              //     );
              //   },
              // ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(.7)
                      ])),
                ),
              ),
              Positioned(
                height: size.height / 1.5,
                child: Column(
                  children: [
                    CurrentSongTitle(),
                    const SizedBox(
                      height: 5,
                    ),
                    const CurrentSongArtist(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                  ],
                ),
              ),
              const Center(
                child: AudioProgressBar(),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 1.3,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Center(
                      child: PlayerButtons(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          RepeatButton(),
                          ShuffleButton(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isShuffleModeEnabledNotifier,
      builder: (context, isEnabled, child) {
        return IconButton(
          icon: (isEnabled)
              ? const Icon(Icons.shuffle, size: 30, color: Colors.white)
              : const Icon(Icons.shuffle, size: 30, color: Colors.grey),
          onPressed: pageManager.shuffle,
        );
      },
    );
  }
}

class RepeatButton extends StatelessWidget {
  const RepeatButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<RepeatState>(
      valueListenable: pageManager.repeatButtonNotifier,
      builder: (context, value, child) {
        Icon icon;
        switch (value) {
          case RepeatState.off:
            icon = const Icon(Icons.repeat, size: 30, color: Colors.grey);
            break;
          case RepeatState.repeatSong:
            icon = const Icon(Icons.repeat_one, size: 30, color: Colors.white);
            break;
          case RepeatState.repeatPlaylist:
            icon = const Icon(Icons.repeat, size: 30, color: Colors.white);
            break;
        }
        return IconButton(
          icon: icon,
          onPressed: pageManager.repeat,
        );
      },
    );
  }
}

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: pageManager.progressNotifier,
      builder: (_, value, __) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    formatDuration(value.total),
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const VerticalDivider(
                    color: Colors.white54,
                    thickness: 2,
                    width: 25,
                    indent: 2,
                    endIndent: 2,
                  ),
                  Text(
                    formatDuration(value.current),
                  )
                ],
              ),
            ),
            CircularSlider(
              position: value.current,
              duration: value.total,
              onChanged: pageManager.seek,
            ),
          ],
        );
      },
    );
  }
}
