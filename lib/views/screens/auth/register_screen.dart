import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoutout_shop_app/controllers/auth_controller.dart';
import 'package:shoutout_shop_app/views/screens/auth/login_screen.dart';


class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController _authController = AuthController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String email;

  late String fullName;

  late String passWord;

  Uint8List? _image;

  selectGalleryImage() async {
    Uint8List im =  await _authController.pickProfileImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  capturedImage() async {
    Uint8List im = await _authController.pickProfileImage(ImageSource.camera);

    setState(() {
      _image = im;
    });
  }

  registerUser()async{
    if(_image!=null){
         if (_formKey.currentState!.validate()) {
                  String res = await  _authController.createNewUser(email, fullName, passWord,_image);
                  if(res=='success'){
                   Get.to(LoginScreen());

                    Get.snackbar('Thành công ','Bạn đã tạo tài khoản thành công !',backgroundColor: const Color.fromARGB(255, 246, 109, 12),colorText: Colors.white, margin: EdgeInsets.all(15),);
                  }else{
                    Get.snackbar('Lỗi ', res.toString(), backgroundColor: Colors.red, colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.all(15),);
                  }
                   
                  } else {
                    Get.snackbar('Thông tin', 'Điền thông tin không hợp lệ', backgroundColor: Colors.red, colorText: Colors.white,margin: EdgeInsets.all(15),icon: Icon(Icons.message,color: Colors.white,));
                  }

    }else{
      Get.snackbar('Không hình ảnh', 'Vui lòng chọn ảnh', backgroundColor: Colors.red, colorText: Colors.white,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.all(15),icon: Icon(Icons.message,color: Colors.white,));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: Center(
        child: SingleChildScrollView(
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
                height: 15,
              ),
              Stack(
                children: [
                 _image==null? CircleAvatar(
                    radius: 65,
                    child: Icon(
                      Icons.person,
                      size: 80,
                    ),
                  ):CircleAvatar(
                    radius: 65,
                    backgroundImage: MemoryImage(_image!),
                  ),
                  Positioned(
                    right: 0,
                    top: 15,
                    child: IconButton(
                      onPressed: () {
                        selectGalleryImage();
                      },
                      icon: Icon(
                        CupertinoIcons.photo,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) {
                  email = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Vui lòng nhập Email không được để trống !';
                  } else {
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
                onChanged: (value) {
                  fullName = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Vui lòng nhập tên đầy đủ không được để trống !';
                  } else {
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
                onChanged: (value) {
                  passWord = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Vui lòng nhập mật khẩu không được để trống !';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Mật khẩu',
                  hintText: 'Nhập mật khẩu',
                  prefixIcon: Icon(
                    Icons.lock,
                    color: const Color.fromARGB(255, 246, 109, 12),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  registerUser();
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text(
                  'Bạn đã có tài khoản ?',
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
