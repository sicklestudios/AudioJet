import 'package:audiojet/constants.dart';
import 'package:audiojet/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:marquee_plus/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';

class BigSoundCard extends StatelessWidget {
  const BigSoundCard({
    Key? key,
    required this.song,
  }) : super(key: key);

  final SongModel song;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
        margin: const EdgeInsets.only(right: 5, left: 5, top: 2, bottom: 2),
        width: size.width * 0.3,
        child: Neumorphic(
          style: NeumorphicStyle(
              shape: NeumorphicShape.concave,
              // boxShape: NeumorphicBoxShape.roundRect(
              //     BorderRadius.circular(12)),
              depth: 9,
              disableDepth: true,
              lightSource: LightSource.bottom,
              color: cardColor),
          child: Column(children: [
            SizedBox(
              width: size.width * 0.5,
              height: size.height * 0.195,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed('/song', arguments: song);
                      },
                      child: SizedBox(
                        width: size.width * 0.3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: QueryArtworkWidget(
                            id: song.id,
                            type: ArtworkType.ALBUM,
                            nullArtworkWidget: Image.asset(
                              getRandomImage(),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 3,
                    right: 10,
                    child: Text(
                      formatDuration(Duration(milliseconds: song.duration!)),
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: size.width * 0.45,
              height: 25,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Marquee(
                  text: song.displayNameWOExt,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // blankSpace: 20.0,
                  velocity: 75.0,
                  // pauseAfterRound: const Duration(seconds: 1),
                  // startPadding: 10.0,
                  accelerationDuration: const Duration(seconds: 1),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: const Duration(milliseconds: 500),
                  decelerationCurve: Curves.easeOut,
                ),
              ),
            ),

            // Text(
            //   song.displayNameWOExt,
            //   overflow: TextOverflow.fade,
            //   textAlign: TextAlign.center,
            //   style: Theme.of(context)
            //       .textTheme
            //       .bodyMedium!
            //       .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            // ),

            // Container(
            //     decoration: BoxDecoration(
            //         color: Colors.white.withOpacity(0.8),
            //         borderRadius: BorderRadius.circular(15)),
            //     width: size.width * 0.45,
            //     margin: const EdgeInsets.only(bottom: 10),
            //     height: 90,
            //     child: Center(
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Row(
            //               children: [
            //                 Expanded(
            //                   child:
            //                 ),
            //                 Expanded(
            //                   child: Text(
            //                     formatDuration(
            //                         Duration(milliseconds: song.duration!)),
            //                     overflow: TextOverflow.fade,
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .bodyMedium!
            //                         .copyWith(
            //                             color: Colors.deepPurple,
            //                             fontWeight: FontWeight.bold),
            //                   ),
            //                 ),
            //               ],
            //             ),

            // Text(
            //   song.duration.toString(),
            //   style: Theme.of(context).textTheme.bodySmall!.copyWith(
            //       color: Colors.black, fontWeight: FontWeight.bold),
            // )
            //   ],
            // ),
            // ),
            // )),
          ]),
        ));
  }
}
