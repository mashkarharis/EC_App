import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class FireService {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<Result> upload(String inputSource, BuildContext context) async {
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (!permissionStatus.isGranted) {
      return Result(false, "Insufficient Permission");
    }

    final picker = ImagePicker();
    XFile? pickedImage;
    try {
      pickedImage = await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);

      final String fileName = path.basename(pickedImage!.path);
      File imageFile = File(pickedImage.path);

      try {
        Reference storageRef = storage.ref().child('upload/$fileName');
        await storageRef.putFile(imageFile);
        String url = await storageRef.getDownloadURL();
        return Result(true, url);
      } on FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
        return Result(false, error.toString());
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      return Result(false, err.toString());
    }
  }
}

class Result {
  bool success = false;
  String meta = "";

  Result(this.success, this.meta);
}
