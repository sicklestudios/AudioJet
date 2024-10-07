// ignore_for_file: must_be_immutable

import 'package:audiojet/constants.dart';
import 'package:audiojet/page_manager.dart';
import 'package:audiojet/services/service_locator.dart';
import 'package:audiojet/settings.dart';
import 'package:audiojet/utils.dart';
import 'package:audiojet/widgets/big_song_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongCard extends StatefulWidget {
  SongCard({Key? key, this.isPlaylist, this.songsList}) : super(key: key);
  bool? isPlaylist;
  List<SongModel>? songsList;

  @override
  State<SongCard> createState() => _SongCardState();
}

class _SongCardState extends State<SongCard> {
  final pageManager = getIt<PageManager>();

  @override
  Widget build(BuildContext context) {
    widget.songsList ??= allSongs;
    widget.isPlaylist ??= false;
    return isSongGrid
        ? GridView.builder(
            physics: widget.isPlaylist!
                ? const NeverScrollableScrollPhysics()
                : null,
            // physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: widget.songsList!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                child: SizedBox(
                  height: 100,
                  child: BigSoundCard(
                    song: widget.songsList![index],
                  ),
                ),
              );
            })
        : ListView.builder(
            physics: widget.isPlaylist!
                ? const NeverScrollableScrollPhysics()
                : null,
            // physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.songsList!.length,
            itemBuilder: (context, index) {
              return ValueListenableBuilder<String>(
                  valueListenable: pageManager.currentSongIndexNotifier,
                  builder: (_, title, __) {
                    return Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: title == widget.songsList![index].id.toString()
                              ? appBarColor
                              : cardColor,
                          borderRadius: BorderRadius.circular(15.0)),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed('/song', arguments: index);
                        },
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: QueryArtworkWidget(
                              id: widget.songsList![index].id,
                              type: ArtworkType.ALBUM,
                              nullArtworkWidget: Image.asset(
                                getRandomImage(),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          title:
                              Text(widget.songsList![index].displayNameWOExt),
                          subtitle: Text('${widget.songsList![index].artist}'),
                          trailing: title ==
                                  widget.songsList![index].id.toString()
                              ? IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.play_circle,
                                    color: Colors.white,
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(formatDuration(Duration(
                                        milliseconds: widget
                                            .songsList![index].duration!))),
                                  ],
                                ),
                          // trailing: IconButton(
                          //   onPressed: () {},
                          //   icon: const Icon(
                          //     Icons.play_circle,
                          //     color: Colors.white,
                          //   ),
                          // ),
                        ),
                      ),
                    );
                  });
            });
  }
}
