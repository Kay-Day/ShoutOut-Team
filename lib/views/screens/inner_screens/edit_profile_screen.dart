import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _fullNameController = TextEditingController();

  @override
  void initState() {
    _populateController();
    super.initState();
  }

  void _populateController() async {
    String? userEmail = getUserEmail();
    String? userFullName = await getUserFullName();
    if (userEmail != null) {
      _emailController.text = userEmail;
    }
    if (userFullName != null) {
      _fullNameController.text = userFullName;
    }
  }

  String? getUserEmail() {
    User? user = _auth.currentUser;
    if (user != null) {
      return user.email;
    } else {
      return null;
    }
  }

  Future<String?> getUserFullName() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('buyers')
            .doc(user.uid)
            .get();

        return userDoc['fullName'];
      } catch (e) {
        print('Lỗi: $e');
      }
    } else {
      return null;
    }
    return null;
  }

  Future<void> _updateProfile() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.verifyBeforeUpdateEmail(_emailController.text);

        await FirebaseFirestore.instance
            .collection('buyers')
            .doc(user.uid)
            .update({
          'email': _emailController.text,
          'fullName': _fullNameController.text,
        });
        _emailController.text = _emailController.text;
        _fullNameController.text = _fullNameController.text;

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'Email của bạn đã thay đổi , vui lòng kiểm tra lại hòm thư ')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Cập nhật thất bại: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sửa thông tin'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sửa thông tin của bạn ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: 'Nhập Email '),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _fullNameController,
                  decoration: InputDecoration(hintText: 'Nhập đầy đủ họ tên '),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: (){
                    _updateProfile();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        'Cập nhật thông tin',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
