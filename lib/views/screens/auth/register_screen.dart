import 'package:flutter/material.dart';
import 'package:shoutout_shop_app/views/screens/auth/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  late String email;
  late String fullName;
  late String passWord;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
          Text(
            'Đăng ký tài khoản',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          SizedBox(
            height: 20,
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
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
              onChanged: (value){
              fullName = value;
            },
               validator: (value){
              if(value!.isEmpty){
                return 'Vui lòng nhập tên đầy đủ không được để trống !';
              }else {
                return null;
              }
          
            },
            decoration: InputDecoration(
                labelText: 'Tên đầy đủ',
                hintText: 'Nhập tên đầy đủ',
                prefixIcon: Icon(
                  Icons.person,
                  color: const Color.fromARGB(255, 246, 109, 12),
                )),
          ),
          SizedBox(
            height: 20,
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
            decoration: InputDecoration(
                labelText: 'Mật khẩu',
                hintText: 'Nhập mật khẩu',
                prefixIcon: Icon(
                  Icons.lock,
                  color: const Color.fromARGB(255, 246, 109, 12),
                ),),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              if (_formKey.currentState!.validate()){
                print(email);
                print(fullName);
                print(passWord);
              }else {
                print('Not Valid');

              }
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 246, 109, 12),
                borderRadius: BorderRadius.circular(
                  8,
                ),
              ),
              child: Center(
                  child: Text(
                'Đăng ký',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              )),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)
              => LoginScreen()));
            },
            child: Text(
              'Bạn đã có tài khoản ?',
            ),
          ),
                ],
              ),
        ));
  }
}
