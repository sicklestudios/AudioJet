import 'package:audiojet/constants.dart';
import 'package:audiojet/utils.dart';
import 'package:audiojet/widgets/big_playlist_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayListCard extends StatefulWidget {
  const PlayListCard({
    Key? key,
    required this.playList,
    required this.representerBoolean,
  }) : super(key: key);

  final List<PlaylistModel> playList;
  final bool representerBoolean;

  @override
  State<PlayListCard> createState() => _PlayListCardState();
}

class _PlayListCardState extends State<PlayListCard> {
  @override
  Widget build(BuildContext context) {
    return widget.representerBoolean
        ? GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: widget.playList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                child: Neumorphic(
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        // boxShape: NeumorphicBoxShape.roundRect(
                        //     BorderRadius.circular(12)),
                        depth: 9,
                        disableDepth: true,
                        lightSource: LightSource.bottom,
                        color: cardColor),
                    child: BigPlayListCard(
                        name: widget.playList[index].playlist,
                        id: widget.playList[index].id,
                        noOfSongs:
                            '${widget.playList[index].numOfSongs} songs')),
              );
            })
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.playList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: InkWell(
                  onTap: () {
                    Get.toNamed('/playlist');
                  },
                  child: Neumorphic(
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        // boxShape: NeumorphicBoxShape.roundRect(
                        //     BorderRadius.circular(12)),
                        depth: 9,
                        disableDepth: true,
                        lightSource: LightSource.bottom,
                        color: cardColor),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: QueryArtworkWidget(
                          id: widget.playList[index].id,
                          type: ArtworkType.ALBUM,
                          nullArtworkWidget: Image.asset(
                            getRandomImage(),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      title: Text(widget.playList[index].playlist),
                      subtitle:
                          Text('${widget.playList[index].numOfSongs} songs'),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.play_circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            });
  }
}
