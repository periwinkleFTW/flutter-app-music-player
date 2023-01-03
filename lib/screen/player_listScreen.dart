import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_player_neumorph/constants/app_color.dart';

import '../model/music_model.dart';
import '../widget/neumorphism_button.dart';

class PlayerListScreen extends StatefulWidget {
  const PlayerListScreen({super.key});

  @override
  State<PlayerListScreen> createState() => _PlayerListScreenState();
}

class _PlayerListScreenState extends State<PlayerListScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(children: [
          Text("Flume Kai".toUpperCase(),
              style: const TextStyle(
                color: AppColor.secondaryTextColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: size.height * 0.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NeumorphismBtn(
                  size: 60,
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: AppColor.secondaryTextColor,
                  ),
                ),
                NeumorphismBtn(
                  size: size.width * 0.5,
                  distance: 20,
                  padding: 8,
                  imageUrl: musicList[0].imageUrl,
                ),
                NeumorphismBtn(
                  size: 60,
                  child: Icon(
                    musicList[0].isFav ? Icons.favorite : Icons.favorite_border,
                    color: AppColor.secondaryTextColor,
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
