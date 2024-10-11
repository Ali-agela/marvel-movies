import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<File?> pickFiles() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: false,
    type: FileType.custom,
    allowedExtensions: ['jpg', 'png', 'jpeg'],
  );

  if (result != null) {
    if (result.files.single.path != null) {
      File file = File(result.files.single.path!);
      print("Selected file path: ${file.path}");
    } else {
      print("File path is null");
    }
  } else {
    print("No file selected");
  }
  if (result != null) {
    return (File(result.files.first.path!));
  } else {
    return null;
  }
}
