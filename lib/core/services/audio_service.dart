import 'package:audioplayers/audioplayers.dart';
import 'package:ukrainian/core/theme/theme.dart';

class AudioService {
  final AudioPlayer _player = AudioPlayer();

  AudioService() {
    _player.setPlayerMode(PlayerMode.lowLatency);
  }

  Future<void> _playSound(String assetPath) async {
    try {
      await _player.stop();
      await _player.play(AssetSource(assetPath));
    } catch (e) {}
  }

  Future<void> playCorrect() async {
    await _playSound(AppAssets.soundCorrect);
  }

  Future<void> playWrong() async {
    await _playSound(AppAssets.soundWrongAnswer);
  }

  Future<void> playSuccess() async {
    await _playSound(AppAssets.soundGameSuccess);
  }

  Future<void> playClick() async {
    await _playSound(AppAssets.soundClick);
  }

  void dispose() {
    try {
      _player.stop();
      _player.dispose();
    } catch (_) {}
  }
}
