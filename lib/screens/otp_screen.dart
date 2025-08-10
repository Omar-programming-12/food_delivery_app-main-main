import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:pinput/pinput.dart';
import 'package:lottie/lottie.dart';
class OtpScreen extends StatelessWidget {
  final void Function(String) onSubmit;
  const OtpScreen({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final themeColor = const Color(0xFFFF9800);
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 55,
      textStyle: const TextStyle(
        fontSize: 20,
        color: black,
        fontWeight: FontWeight.w600
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400)
      )
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 180,
                child: Lottie.asset(
                  'assets/otp_animation.json',
                  fit: BoxFit.contain
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Verify Your Phone Number',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87
                ),
              ),
              const SizedBox(height: 8),

              Text(
                'Enter the 6-digit number that was sent',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 30),
              Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                onCompleted: onSubmit,
              ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: (){
                      
                    },
                     child: const Text(
                      'Verfiy',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                      ),
                ),
              ),
             ),
             const SizedBox(height: 20),

             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Didnt receive the code?',
                style: TextStyle(color: Colors.grey.shade700),
                ),
                TextButton(
                  onPressed: (){},
                  child: Text('Resend Code',
                  style: TextStyle(color: themeColor),
                  ),
                ),
              ],
             )
            ],
          ),
        ),
      ),
    );
  }
}
Future<void> verfiyCode(String verificationId,String otp)async {
  try {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
       smsCode: otp
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      print('Verified Sucess!');
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: const Text('Verified Success!'),),
      // );
  } catch (e) {
          print('Verified Failed');
  //    ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: const Text('Verified Failed!'),),
  // );
  }
}