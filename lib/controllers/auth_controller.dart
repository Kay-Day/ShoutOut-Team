import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AuthController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> createNewUser(
      String email, String fullName, String passWord, Uint8List? image) async {
    String res = 'Đã xảy ra lỗi !';

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: passWord);

      String downloadUrl = await _uploadImageToStorange(image);

      await _firestore.collection('buyers').doc(userCredential.user!.uid).set({
        'fullName': fullName,
        'profileImage': downloadUrl,
        'email': email,
        'buyerID': userCredential.user!.uid,
      });

      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  pickProfileImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('Không có ảnh được chọn');
    }
  }

  _uploadImageToStorange(Uint8List? image) async {
    Reference ref =
        _storage.ref().child('profileImage').child(_auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(image!);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String> loginUser(String email, String passWord) async {
    String res = 'Loi';

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: passWord);
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
