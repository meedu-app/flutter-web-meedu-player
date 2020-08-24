import 'dart:async';
import 'dart:html';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

enum PlayerStatus { loading, loaded, playing, paused, stopped, error }

class MeeduPlayerIds {
  static const controls = 'controls';
}

class MeeduController extends GetxController {
  VideoPlayerController _videoPlayerController;
  VideoPlayerController get videoController => _videoPlayerController;
  PlayerStatus _status = PlayerStatus.loading;
  PlayerStatus get status => _status;
  RxBool _mute = false.obs;
  RxBool _fullscreen = false.obs;
  RxDouble _volume = 0.0.obs;
  StreamSubscription _fullscreenSubs;
  bool get mute => _mute.value;
  bool get fullscreen => _fullscreen.value;
  double get volume => _volume.value;

  bool get playing {
    return _status == PlayerStatus.playing;
  }

  bool get paused {
    return _status == PlayerStatus.paused;
  }

  bool get stopped {
    return _status == PlayerStatus.stopped;
  }

  bool get loading {
    return _status == PlayerStatus.loading;
  }

  bool get loaded {
    return _status == PlayerStatus.loaded;
  }

  bool get error {
    return _status == PlayerStatus.error;
  }

  Future dispose() async {
    await _videoPlayerController?.dispose();
  }

  Future<void> loadVideo(String url) async {
    try {
      this._videoPlayerController = VideoPlayerController.network(url);
      await this._videoPlayerController.initialize();
      this._videoPlayerController.addListener(() {
        final double volume = _videoPlayerController.value.volume;
        if (volume != _volume.value && !_mute.value) {
          _volume.value = volume;
        }
      });
      _status = PlayerStatus.loaded;
      update();
    } catch (e) {
      print(e);
    }
  }

  Future<void> play() async {
    if (loaded || paused) {
      await _videoPlayerController.play();
      _status = PlayerStatus.playing;
      update([MeeduPlayerIds.controls]);
    }
  }

  Future<void> pause() async {
    if (playing) {
      await _videoPlayerController.pause();
      _status = PlayerStatus.paused;
      update([MeeduPlayerIds.controls]);
    }
  }

  Future<void> onMute() async {
    _mute.value = !_mute.value;
    await _videoPlayerController.setVolume(mute ? 0 : volume);
  }

  Future<void> onFullscreen() async {
    if (GetPlatform.isWeb) {
      if (!fullscreen) {
        document.documentElement.requestFullscreen();
      } else {
        document.exitFullscreen();
      }
    } else {
      if (!fullscreen) {
        await SystemChrome.setEnabledSystemUIOverlays([]);
      } else {
        await SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
      }
      _fullscreen.value = !_fullscreen.value;
    }
  }

  @override
  void onReady() {
    if (GetPlatform.isWeb) {
      document.onFullscreenChange.listen((event) {
        _fullscreen.value = !_fullscreen.value;
        print("fullscreen $fullscreen");
      });
    }
  }

  @override
  void onClose() {
    _fullscreenSubs?.cancel();
    this.dispose();
  }
}
