import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:meedu_player/controllers/meedu_controller.dart';
import 'package:meedu_player/widgets/meedu_player_circle_button.dart';

class MeeduPlayerControls extends StatelessWidget {
  const MeeduPlayerControls({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MeeduController>(
      id: MeeduPlayerIds.controls,
      builder: (_) {
        return Positioned.fill(
          child: Container(
            color: Colors.black26,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MeeduPlayerCircleButton(
                      iconPath: 'assets/icons/rewind.png',
                      onPressed: () {},
                    ),
                    SizedBox(width: 25),
                    MeeduPlayerCircleButton(
                      iconPath: _.playing
                          ? 'assets/icons/pause.png'
                          : 'assets/icons/play.png',
                      onPressed: () {
                        if (_.loaded || _.paused) {
                          _.play();
                        } else {
                          _.pause();
                        }
                      },
                    ),
                    SizedBox(width: 25),
                    MeeduPlayerCircleButton(
                      iconPath: 'assets/icons/fast-forward.png',
                      onPressed: () {},
                    ),
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: 50,
                  child: Container(
                    color: Colors.white24,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Text(
                          "00:00",
                          style: TextStyle(color: Colors.white),
                        ),
                        Expanded(
                          child: Slider(
                            value: 0,
                            onChanged: (v) {},
                            min: 0,
                            max: 100,
                            activeColor: Colors.redAccent,
                          ),
                        ),
                        Text(
                          "16:50",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 10),
                        FlatButton(
                          minWidth: 20,
                          padding: EdgeInsets.all(15),
                          child: Obx(
                            () => Image.asset(
                              _.mute
                                  ? 'assets/icons/mute.png'
                                  : 'assets/icons/sound.png',
                              width: 20,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: _.onMute,
                        ),
                        FlatButton(
                          minWidth: 20,
                          padding: EdgeInsets.all(15),
                          child: Obx(
                            () => Image.asset(
                              _.fullscreen
                                  ? 'assets/icons/minimize.png'
                                  : 'assets/icons/fullscreen.png',
                              width: 20,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: _.onFullscreen,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
