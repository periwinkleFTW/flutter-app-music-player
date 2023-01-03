import 'package:flutter/material.dart';
import 'package:music_player_neumorph/constants/app_color.dart';
import 'package:music_player_neumorph/model/music_model.dart';
import 'package:music_player_neumorph/screen/player_listScreen.dart';

import '../widget/neumorphism_button.dart';

class PlayerScreen extends StatefulWidget {
  PlayerScreen({Key? key}) : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  int _currentItemPlaying = 0;
  double _currentPlayback = 0;

  String formatPlayertime(double time) {
    final min = time ~/ 60;
    final sec = time % 60;
    return "$min:${sec.toStringAsFixed(0).padRight(2, "0")}";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NeumorphismBtn(
                    size: 60,
                    child: Icon(
                      musicList[_currentItemPlaying].isFav
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: AppColor.secondaryTextColor,
                    ),
                  ),
                  Text(
                    "Playing now".toUpperCase(),
                    style: const TextStyle(
                      color: AppColor.secondaryTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  NeumorphismBtn(
                    size: 60,
                    child: Icon(
                      Icons.menu,
                      color: AppColor.secondaryTextColor,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlayerListScreen(),
                          ));
                    },
                  ),
                ],
              ),
              NeumorphismBtn(
                size: size.width * 0.80,
                distance: 20,
                padding: 10,
                imageUrl: musicList[_currentItemPlaying].imageUrl,
              ),
              Column(
                children: [
                  Text(
                    musicList[_currentItemPlaying].name,
                    style: const TextStyle(
                      color: AppColor.primaryTextColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    musicList[_currentItemPlaying].artist,
                    style: const TextStyle(
                      color: AppColor.secondaryTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formatPlayertime(_currentPlayback),
                          style: const TextStyle(
                            color: AppColor.secondaryTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          formatPlayertime(
                              musicList[_currentItemPlaying].length),
                          style: const TextStyle(
                            color: AppColor.secondaryTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Slider(
                    value: _currentPlayback,
                    max: musicList[_currentItemPlaying].length,
                    thumbColor: AppColor.blue,
                    activeColor: AppColor.blue,
                    inactiveColor: AppColor.bgDark,
                    onChanged: ((value) {
                      setState(() {
                        _currentPlayback = value;
                      });
                    }),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const NeumorphismBtn(
                    size: 80,
                    child: Icon(
                      Icons.skip_previous_rounded,
                      color: AppColor.secondaryTextColor,
                      size: 35,
                    ),
                  ),
                  const NeumorphismBtn(
                    size: 80,
                    colors: [AppColor.blueTopDark, AppColor.blue],
                    child: Icon(
                      Icons.pause_rounded,
                      color: AppColor.white,
                      size: 35,
                    ),
                  ),
                  const NeumorphismBtn(
                    size: 80,
                    child: Icon(
                      Icons.skip_next_rounded,
                      color: AppColor.secondaryTextColor,
                      size: 35,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
