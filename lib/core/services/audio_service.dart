import 'package:audioplayers/audioplayers.dart';
import 'package:ukrainian/core/theme/theme.dart';

class AudioService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> playCorrect() async {
    await _player.stop();
    await _player.play(AssetSource(AppAssets.soundCorrect));
  }

  Future<void> playWrong() async {
    await _player.stop();
    await _player.play(AssetSource(AppAssets.soundWrongAnswer));
  }

  Future<void> playSuccess() async {
    await _player.stop();
    await _player.play(AssetSource(AppAssets.soundGameSuccess));
  }

  void dispose() => _player.dispose();
}
