import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static Future<List<File>> pickMultipleImages({int maxImages = 3}) async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? pickedFiles = await picker.pickMultiImage(
      limit: maxImages,
    );

    if (pickedFiles == null || pickedFiles.isEmpty) return [];
    if (pickedFiles.length > maxImages) {
      return pickedFiles.take(maxImages).map((e) => File(e.path)).toList();
    }
    return pickedFiles.map((e) => File(e.path)).toList();
  }
}
