
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeRegisterScreen extends StatefulWidget {
  const WelcomeRegisterScreen({super.key});

  @override
  State<WelcomeRegisterScreen> createState() => _WelcomeRegisterScreenState();
}

class _WelcomeRegisterScreenState extends State<WelcomeRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 240, 178, 123),
        ),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned(
              top: 0,
              left: -40,
              child: Image.asset(
                'assets/icons/doorpng2.png',
                width: screenWidth +80 ,
                height: screenHeight + 100,
                fit: BoxFit.contain,
                ),
                ),
                Positioned(
                  top: screenHeight * 0.641,
                  left: screenWidth * 0.07,
                  child: Container(
                  width: screenWidth * 0.85,
                  height: screenHeight * 0.085,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    color: Colors.white,
                  ),
                  child: Center(child: Text('Đăng ký khách hàng',style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ))),
                ),
                ),

          ],
        ),

      ),

    );
}
}