import 'package:audiojet/widgets/player_buttons.dart';
import 'package:audiojet/widgets/seekbar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

class SongScreen extends StatefulWidget {
  const SongScreen({super.key});

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  SongModel song = SongModel({});
  AudioPlayer audioPlayer = AudioPlayer();
  @override
  void initState() {
    super.initState();
    audioPlayer.setAudioSource(ConcatenatingAudioSource(children: [
      AudioSource.uri(Uri.file(
          '/storage/emulated/0/Youthoob/Abdul Hannan & Rovalio - Iraaday (Official Music Video).m4a')),
      AudioSource.uri(Uri.file(
          '/storage/emulated/0/Youthoob/Abdul Hannan & Rovalio - Iraaday (Official Music Video).m4a')),
      AudioSource.uri(Uri.file(
          '/storage/emulated/0/Youthoob/Abdul Hannan & Rovalio - Iraaday (Official Music Video).m4a')),
    ]));
    // audioPlayer.setFilePath(
    //     '/storage/emulated/0/Youthoob/Abdul Hannan & Rovalio - Iraaday (Official Music Video).m4a');
    // audioPlayer.play();
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  Stream<SeekBarData> get _seekBarDataStream =>
      rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
          audioPlayer.positionStream, audioPlayer.durationStream,
          (Duration position, Duration? duration) {
        return SeekBarData(position, duration ?? Duration.zero);
      });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: QueryArtworkWidget(
              id: 0,
              type: ArtworkType.ALBUM,
              nullArtworkWidget: Image.network(
                'https://i1.sndcdn.com/artworks-hADAxnACXWoAx6Og-YihIxg-t500x500.jpg',
                fit: BoxFit.fill,
              ),
            ),
          ),
          const _BackgroundFilter(),
          _MusicPlayer(
              songModel: null,
              seekBarDataStream: _seekBarDataStream,
              audioPlayer: audioPlayer),
        ],
      ),
    );
  }
}

class _MusicPlayer extends StatelessWidget {
  const _MusicPlayer({
    Key? key,
    required Stream<SeekBarData> seekBarDataStream,
    required this.audioPlayer,
    required this.songModel,
  })  : _seekBarDataStream = seekBarDataStream,
        super(key: key);

  final Stream<SeekBarData> _seekBarDataStream;
  final AudioPlayer audioPlayer;
  final SongModel? songModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            songModel == null ? "Loading" : songModel!.title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            songModel == null ? "Loading" : songModel!.artist!,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                ),
          ),
          const SizedBox(
            height: 30,
          ),
          StreamBuilder(
              stream: _seekBarDataStream,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                return SeekBar(
                  position: positionData?.position ?? Duration.zero,
                  duration: positionData?.duration ?? Duration.zero,
                  onChanged: audioPlayer.seek,
                );
              }),
          PlayerButtons(),
        ],
      ),
    );
  }
}

class _BackgroundFilter extends StatelessWidget {
  const _BackgroundFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white.withOpacity(0.9),
              Colors.white.withOpacity(0),
            ],
            stops: const [
              0.0,
              0.4,
              0.6
            ]).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
            Colors.deepPurple.shade800.withOpacity(0.8),
            Colors.deepPurple.shade200.withOpacity(0.8),
          ]))),
    );
  }
}
