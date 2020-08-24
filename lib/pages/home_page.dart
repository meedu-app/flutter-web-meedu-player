import 'package:flutter/material.dart';
import 'package:meedu_player/widgets/meedu_player.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeceff1),
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Container(
            constraints: BoxConstraints(maxWidth: 1280),
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      children: [
                        MeeduPlayer(
                          url:
                              "https://movietrailers.apple.com/movies/paramount/the-spongebob-movie-sponge-on-the-run/the-spongebob-movie-sponge-on-the-run-big-game_h720p.mov",
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
