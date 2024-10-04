import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_responsive.dart';
import 'package:shoutout_shop_app/controllers/auth_controller.dart';
import 'package:shoutout_shop_app/views/screens/auth/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   final AuthController _authController = AuthController();

   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

   late String email;

   late String passWord;

   bool _isLoading = false;

loginUser() async {
  if (_formKey.currentState!.validate()) {
    setState(() {
      _isLoading = true;
    });
    String res = await _authController.loginUser(email, passWord);
    setState(() {
      _isLoading = false;
    });
    if (res == 'success') {
      setState(() {
        _isLoading = false;
      });
      Get.snackbar('Đăng nhập', 'Bạn đã đăng nhập',backgroundColor: const Color.fromARGB(255, 21, 150, 6),colorText: Colors.white,);
    }else{
      Get.snackbar('Lỗi', res.toString(), backgroundColor: Colors.red, colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,);
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Đăng nhập',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              )),
          SizedBox(
            height: 25,
          ),
          TextFormField(
             onChanged: (value){
              email = value;
            },
               validator: (value){
              if(value!.isEmpty){
                return 'Vui lòng nhập Email không được để trống !';
              }else {
                return null;
              }
            },
              decoration: InputDecoration(
            labelText: 'Địa chỉ Email',
            hintText: 'Nhập địa chỉ Email',
            prefixIcon: Icon(
                Icons.email,
                color: const Color.fromARGB(255, 246, 109, 12),
              ),
          )),
          SizedBox(
            height: 25,
          ),
          TextFormField(
             onChanged: (value){
              passWord = value;
            },
               validator: (value){
              if(value!.isEmpty){
                return 'Vui lòng nhập mật khẩu không được để trống !';
              }else {
                return null;
              }
            },
            decoration: InputDecoration(labelText: 'Mật khẩu',
             hintText: 'Nhập mật khẩu',
                prefixIcon: Icon(
                  Icons.lock,
                  color: const Color.fromARGB(255, 246, 109, 12),
                ),),
            
          ),
          SizedBox(
            height: 25,
          ),
          InkWell(
            onTap: () {
               loginUser();
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 239, 112, 8),
                  borderRadius: BorderRadius.circular(
                    10,
                  )),
              child: Center(
                child: _isLoading? CircularProgressIndicator(color: Colors.white,): Text(
                  'Đăng nhập',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return RegisterScreen();
                  },
                ),
              );
            },
            child: Text(
              'Bạn chưa có tài khoản ?',
            ),
          ),
        ]),
      ),
    ));
  }
}
