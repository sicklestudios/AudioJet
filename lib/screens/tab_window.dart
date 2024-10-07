import 'package:animations/animations.dart';
import 'package:audiojet/constants.dart';
import 'package:audiojet/widgets/current_song_artist.dart';
import 'package:audiojet/widgets/current_song_title.dart';
import 'package:audiojet/widgets/player_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabWindow extends StatefulWidget {
  const TabWindow({super.key});

  @override
  State<TabWindow> createState() => _TabWindowState();
}

class _TabWindowState extends State<TabWindow> {
  int _selectedIndex = 0;

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  final _pageViewController = PageController();

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        // ),

        body: Stack(
          children: [
            PageView(
                controller: _pageViewController,
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                children: screensList),
            Positioned(
                bottom: 7,
                child: SizedBox(
                    height: 80,
                    width: size.width,
                    child: const MusicCardMinimised()))
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            backgroundColor: appBarColor,
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.white,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            onTap: (value) {
              _pageViewController.animateToPage(value,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeIn);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.music_note_outlined),
                  activeIcon: Icon(Icons.music_note),
                  label: "Songs"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_outline),
                  activeIcon: Icon(Icons.favorite),
                  label: "Favorites"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.playlist_play_outlined),
                  activeIcon: Icon(Icons.playlist_play),
                  label: "PlayList"),
            ]),
      ),
    );
  }
}

class MusicCardMinimised extends StatefulWidget {
  const MusicCardMinimised({super.key});

  @override
  State<MusicCardMinimised> createState() => _MusicCardMinimisedState();
}

class _MusicCardMinimisedState extends State<MusicCardMinimised> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Get.toNamed(
          '/song',
        )
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            // color: const Color.fromARGB(255, 84, 76, 76),
            color: primaryColor,
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.asset(
                  playerScreenIcon,
                  fit: BoxFit.fill,
                  width: 50,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CurrentSongTitle(
                    isMinimized: true,
                  ),
                  const CurrentSongArtist()
                ],
              ),
            ),
            Expanded(
              child: PlayerButtons(
                isMinimized: true,
              ),
            )
          ],
        ),
      ),
    );

    //  ListTile(
    //   leading: ,
    //   title: const ,
    //   subtitle: const CurrentSongArtist(),
    //   trailing: ,
    // );
  }
}

//theAppBar
class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          child: const CircleAvatar(
            backgroundImage: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRvBRMW5ejDvxtrTRXNcO-7hQd0bN69mZpve42KBTF&s"),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
