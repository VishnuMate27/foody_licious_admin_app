import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static Future<List<String>> pickMultipleImages({int maxImages = 3}) async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? pickedFiles = await picker.pickMultiImage(
      limit: maxImages,
    );

    if (pickedFiles == null || pickedFiles.isEmpty) return [];
    if (pickedFiles.length > maxImages) {
      return pickedFiles.take(maxImages).map((e) => e.path).toList();
    }
    return pickedFiles.map((e) => e.path).toList();
  }
}
