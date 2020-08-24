import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:meedu_player/controllers/meedu_controller.dart';
import 'package:meedu_player/widgets/meedu_player_controls.dart';
import 'package:video_player/video_player.dart';

class MeeduPlayer extends StatelessWidget {
  final String url;
  final MeeduController meeduController = MeeduController();
  MeeduPlayer({Key key, @required this.url})
      : assert(url != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MeeduController>(
      init: this.meeduController,
      initState: (__) {
        this.meeduController.loadVideo(this.url);
      },
      builder: (_) => AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: Colors.black,
          child: !_.loading
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    VideoPlayer(_.videoController),
                    MeeduPlayerControls()
                  ],
                )
              : null,
        ),
      ),
    );
  }
}
