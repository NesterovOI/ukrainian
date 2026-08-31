import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ukrainian/core/theme/app_dimensions.dart';

class ImagePickerService {
  final ImagePicker _pickers = ImagePicker();

  Future<String?> pickAndSaveImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _pickers.pickImage(
        source: source,
        maxHeight: AppDimensions.avatarHeight,
        maxWidth: AppDimensions.avatarWeight,
        imageQuality: AppDimensions.avatarQuality,
      );

      if (pickedFile == null) return null;

      final appDir = await getApplicationCacheDirectory();
      final fileName = 'avatar_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final saveImage = await File(
        pickedFile.path,
      ).copy('${appDir.path}/$fileName');

      return saveImage.path;
    } catch (e) {
      return null;
    }
  }
}
