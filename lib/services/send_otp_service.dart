import 'package:firebase_auth/firebase_auth.dart';

void sendOTP (String phoneNumber) async {
  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    verificationCompleted: (PhoneAuthCredential credential) async {
      await FirebaseAuth.instance.signInWithCredential(credential);
    },
    verificationFailed: (FirebaseAuthException e){
      print('Error: ${e.message}');
    },
    codeSent: (String verificationId, int? resendToken){

    },
    codeAutoRetrievalTimeout: (String verificationId){},
     );
    }