import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class AudioController extends ChangeNotifier {
  final AudioPlayer _audioService;

  bool _ready = true;

  AudioController(this._audioService);

  bool get readyToPlay => _ready;

  void play(String url) async {
    _ready = false;
    notifyListeners();

    try {
      await _audioService.setUrl(url);
      await _audioService.setSpeed(0.75);
      await _audioService.play();
    } finally {
      _ready = true;
      notifyListeners();
    }
  }
}
