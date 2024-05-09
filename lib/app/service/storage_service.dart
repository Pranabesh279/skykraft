import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageBucketService {
  static Future<List<String>> uploadAndGetDownloadUrls(List<File> files) async {
    final storageRef = FirebaseStorage.instance.ref();
    final List<String> downloadUrls = [];
    for (final file in files) {
      final uploadTask = storageRef.child('files/${file.path}').putFile(file);
      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      downloadUrls.add(downloadUrl);
    }
    return downloadUrls;
  }

  static Future<String> uploadAndGetDownloadUrl(File file,
      {String? path}) async {
    final storageRef = FirebaseStorage.instance.ref();
    final uploadTask = storageRef.child(path ?? 'global/files').putFile(file);
    final snapshot = await uploadTask.whenComplete(() => null);
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
