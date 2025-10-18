import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious_admin_app/core/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadField extends StatefulWidget {
  final String label;
  final void Function(File)? onImageSelected;
  final void Function()? onImageRemoved;

  const ImageUploadField({
    super.key,
    required this.label,
    this.onImageSelected,
    this.onImageRemoved,
  });

  @override
  State<ImageUploadField> createState() => _ImageUploadFieldState();
}

class _ImageUploadFieldState extends State<ImageUploadField> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxHeight: 800,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      widget.onImageSelected?.call(_selectedImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.yeonSung(color: kTextRedDark, fontSize: 14),
        ),
        const SizedBox(height: 10),
        Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [kInActiveGradientStart, kInActiveGradientEnd],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: kGrey.withOpacity(0.3), width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: kGrey.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child:
                    _selectedImage == null
                        ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.image_outlined,
                              size: 40,
                              color: kBlueGrey,
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Tap to choose image",
                              style: TextStyle(
                                color: kBlueGrey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )
                        : ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(
                            _selectedImage!,
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
              ),
            ),
            if (_selectedImage != null) ...[
              IconButton(
                onPressed: () {
                  setState(() => _selectedImage = null);
                  widget.onImageRemoved?.call();
                },
                icon: Icon(Icons.cancel, color: kBlack),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
