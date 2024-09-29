import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> createNewUser(
      String email, String fullName, String passWord) async {
    String res = 'Đã xảy ra lỗi !';

    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: passWord);

      res = 'Thành công !';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
