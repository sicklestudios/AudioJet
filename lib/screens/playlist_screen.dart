import 'package:audiojet/constants.dart';
import 'package:audiojet/settings.dart';
import 'package:audiojet/utils.dart';
import 'package:audiojet/widgets/playlist_card.dart';
import 'package:flutter/material.dart';

class PlayListScreen extends StatefulWidget {
  const PlayListScreen({super.key});

  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
        title: const Text('PlayList'),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        isPlayListGrid = !isPlayListGrid;
                      });
                    },
                    icon: Icon(
                      !isPlayListGrid
                          ? Icons.grid_view_outlined
                          : Icons.list_outlined,
                      color: Colors.white,
                    )),
                PlayListCard(
                    playList: playList, representerBoolean: isPlayListGrid),
              ],
            ),
          )
        ],
      ),
    );
  }
}
