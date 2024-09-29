import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
      Text(
        'Đăng nhập', style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        )
      ),
      TextFormField(
          decoration: InputDecoration(
        labelText: 'Địa chỉ email',
      )),
      TextFormField(
        decoration: InputDecoration(labelText: 'Mật khẩu'),
      )
    ]));
  }
}
