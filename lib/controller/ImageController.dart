import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';

import '../api/Firebase.dart';

class ImageController extends ChangeNotifier {
  File _image = File('');
  UploadTask? task;

  final tempImage = PickedFile;
  final _picker = ImagePicker();

  File get image => _image;
  set image(File value) {
    _image = value;
    notifyListeners();
  }

  Future<void> selectImage() async {
    PickedFile? tempImage = await _picker.getImage(source: ImageSource.camera,imageQuality: 80);
    if(tempImage!=null){
      image = File(tempImage.path);
    }
  }

  // Future<String> uploadImage() async {
  //   if (image == null) return '';

  //   final fileName = basename(image.path);
  //   final destination = 'files/$fileName';

  //   task = FirebaseApi.uploadFile(destination, image);

  //   if (task == null) return '';

  //   final snapshot = await task!.whenComplete(() {});
  //   final urlDownload = await snapshot.ref.getDownloadURL();

  //   return urlDownload;
  // }

  Future<String> uploadImage() async {
    final firebaseStorageRef = FirebaseStorage.instance.ref().child("usuarios/"+image.path.split('/').last);
    final uploadTask = firebaseStorageRef.putFile(image);

    final taskSnapshot = await uploadTask.whenComplete(() {});
    final urlDownload = await taskSnapshot.ref.getDownloadURL();

    return urlDownload;
  }
}
