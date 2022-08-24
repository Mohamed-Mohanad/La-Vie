import 'dart:io';

class UploadedImage {
  File file;
  String base64Image;
  UploadedImage({required this.base64Image, required this.file});
}