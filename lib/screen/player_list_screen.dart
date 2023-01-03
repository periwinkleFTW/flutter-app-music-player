import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_player_neumorph/constants/app_color.dart';

import '../model/music_model.dart';
import '../widget/neumorphism_button.dart';

class PlayerListScreen extends StatefulWidget {
  const PlayerListScreen({super.key, required this.selectedIndex});
  final int selectedIndex;

  @override
  State<PlayerListScreen> createState() => _PlayerListScreenState();
}

class _PlayerListScreenState extends State<PlayerListScreen> {
  late int selectedIndex;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    selectedIndex = widget.selectedIndex;
    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
      calculateScrollPosition(scrollController);
    });
    super.initState();
  }

  calculateScrollPosition(ScrollController scrollController) {
    int totalLength = musicList.length;
    final macScroll = scrollController.position.maxScrollExtent;
    scrollController.animateTo(macScroll / totalLength * selectedIndex,
        duration: Duration(milliseconds: 10), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          Text("Flume Kai".toUpperCase(),
              style: const TextStyle(
                color: AppColor.secondaryTextColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: size.height * 0.45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NeumorphismBtn(
                  onPressed: () {
                    Navigator.pop(context, selectedIndex);
                  },
                  size: 60,
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: AppColor.secondaryTextColor,
                  ),
                ),
                NeumorphismBtn(
                  size: size.width * 0.45,
                  distance: 20,
                  padding: 8,
                  imageUrl: musicList[selectedIndex].imageUrl,
                ),
                NeumorphismBtn(
                  size: 60,
                  child: Icon(
                    musicList[selectedIndex].isFav
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: AppColor.secondaryTextColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: musicList.length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        decoration: selectedIndex == index
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColor.secondaryTextColor
                                    .withOpacity(0.3))
                            : null,
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(musicList[index].name,
                                    style: const TextStyle(
                                      color: AppColor.primaryTextColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    )),
                                Text(musicList[index].artist,
                                    style: const TextStyle(
                                      color: AppColor.primaryTextColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                            const Spacer(),
                            selectedIndex == index
                                ? NeumorphismBtn(
                                    size: 50,
                                    colors: [
                                      AppColor.blueTopDark,
                                      AppColor.blue,
                                    ],
                                    child: Icon(
                                        color: AppColor.white,
                                        Icons.pause_rounded),
                                  )
                                : NeumorphismBtn(
                                    size: 50,
                                    child: Icon(
                                        color: AppColor.secondaryTextColor,
                                        Icons.play_arrow_rounded),
                                  ),
                          ],
                        ),
                      ),
                    );
                  })))
        ]),
      ),
    );
  }
}
