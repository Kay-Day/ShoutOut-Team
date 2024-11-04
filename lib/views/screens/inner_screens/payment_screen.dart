import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoutout_shop_app/views/screens/inner_screens/checkout_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isPayOnDelivery = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tuỳ chọn thanh toán',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Lựa chọn phương thức thanh toán',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: Colors.black87),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Thanh toán khi nhận hàng',
                  style: TextStyle(fontSize: 18,
                  fontWeight: FontWeight.w500),
                ),
                Switch(
                    value: isPayOnDelivery,
                    onChanged: (value) {
                      setState(() {
                        isPayOnDelivery = value;
                      });
                      if(isPayOnDelivery){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return CheckoutScreen();
                        }));
                      }
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
