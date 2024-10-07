import 'package:audiojet/constants.dart';
import 'package:audiojet/settings.dart';
import 'package:audiojet/widgets/playlist_card.dart';
import 'package:audiojet/widgets/section_header.dart';
import 'package:audiojet/widgets/big_song_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:audiojet/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  void initState() {
    super.initState();
    requestPermission();
    getSongs();
  }

  requestPermission() async {
    // Web platform don't support permissions methods.
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
      setState(() {});
    }
  }

  getSongs() async {
    allSongs =
        await _audioQuery.querySongs().whenComplete(() => setState(() {}));
    getPlayList();
  }

  getPlayList() async {
    // _audioQuery.queryAudiosFrom(AudiosFromType.PLAYLIST,Null);
    playList =
        await _audioQuery.queryPlaylists().whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(90),
          ),
        ),
        backgroundColor: appBarColor,
        elevation: 0,
        title: const Text("Audio Jet"),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 80,
            ),
            const _DiscoverMusic(),
            _TrendingMusic(songsList: allSongs),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SectionHeader(title: "Playlist", action: 'View More'),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          isHomePlaylistGrid = !isHomePlaylistGrid;
                        });
                      },
                      icon: Icon(
                        !isHomePlaylistGrid
                            ? Icons.grid_view_outlined
                            : Icons.list_outlined,
                        color: Colors.white,
                      )),
                  PlayListCard(
                    playList: playList,
                    representerBoolean: isHomePlaylistGrid,
                  ),
                  Container(
                    height: 100,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _TrendingMusic extends StatelessWidget {
  const _TrendingMusic({
    Key? key,
    required this.songsList,
  }) : super(key: key);

  final List<SongModel> songsList;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(left: 2, top: 20, bottom: 20, right: 2),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SectionHeader(title: "Trending Music", action: "View More"),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: size.width,
          height: size.height * 0.46,
          child: Center(
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  // log(songsList[index].data);
                  return BigSoundCard(song: songsList[index]);
                }),
          ),
        )
      ]),
    );
  }
}

//musicSearchBar
class _DiscoverMusic extends StatelessWidget {
  const _DiscoverMusic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              'Enjoy your favorite music',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search',
                  isDense: true,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade400,
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.grey.shade400)),
            )
          ],
        ));
  }
}
