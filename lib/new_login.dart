import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'home.dart';

class NewLogin extends StatefulWidget {
  const NewLogin({super.key});

  @override
  State<NewLogin> createState() => _NewLoginState();
}

class _NewLoginState extends State<NewLogin> {
  FirebaseAuth auth = FirebaseAuth.instance;
  Color primaryColor = Colors.amberAccent;
  User? user;
  String verificationID = "";
   bool otpVisibility = false;
    var value;
  
 bool _showPassword = false;
  TextEditingController phoneController = TextEditingController();

  TextEditingController otpController = TextEditingController();

   @override
  Widget build(BuildContext context) {
     
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: primaryColor,
      body: GestureDetector(
         onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          padding:EdgeInsets.only(bottom:  MediaQuery.of(context).size.height * 0.01),
           reverse: true,
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Form(
              child: Column(
                children: [
                  SizedBox(height: 150,),
                  //  Container(
                  //       color: primaryColor,
                  //       padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.10),
                  //       width: MediaQuery.of(context).size.width,
                  //       height: MediaQuery.of(context).size.height * 0.45,
                  //       child: Center(
                  //         child: Image.asset('images/logo.png'),
                  //       ),
                  //     ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Padding(
                         padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.15),
                         child: TextFormField(
                          controller: phoneController,
                          maxLength: 10,
                          decoration: InputDecoration(
                            prefix: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text('+91'),
                            ),
                            hintText: 'Enter phone',//enter_email
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(top: 1),
                              child: Icon(Icons.call,color: Colors.grey[500],),
                            ),
                            contentPadding: EdgeInsets.only(top: 10,left: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10)),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          cursorColor: Colors.grey[500],
                         ),
                        ),
                      ),
                      Visibility(
              child:  Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: PinCodeTextField(
                    keyboardType: TextInputType.number,
                    controller: otpController,
                    appContext: context,
                    onChanged: (_value) {
                      // if (_value.length == 4) {
                      //   value = _value;
                      //   print('Values $value');
                      // }
                    },
                    length: 6,
                    obscureText: false,
                    showCursor: false,
                    enableActiveFill: true,
                    animationType: AnimationType.fade,
                    animationDuration: const Duration(milliseconds: 300),
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 40,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      selectedColor: Colors.white,
                      inactiveColor: Colors.white,
                      activeColor: Colors.white,
                      selectedFillColor: Colors.white,
                      errorBorderColor: Colors.red,
                    ),
                  ),
                ),
              visible: otpVisibility,
            ),
             SizedBox(
              height: 10,
            ),
            MaterialButton(
              color: Colors.black,
              onPressed: () {
                if (otpVisibility) {
                  verifyOTP();
                } else {
                  loginWithPhone();
                }
              },
              child: Text(
                otpVisibility ? "Verify" : "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
                //      Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 30),
                //   child: PinCodeTextField(
                //     keyboardType: TextInputType.number,
                //     controller: otpController,
                //     appContext: context,
                //     onChanged: (_value) {
                //       // if (_value.length == 4) {
                //       //   value = _value;
                //       //   print('Values $value');
                //       // }
                //     },
                //     length: 6,
                //     obscureText: false,
                //     showCursor: false,
                //     enableActiveFill: true,
                //     animationType: AnimationType.fade,
                //     animationDuration: const Duration(milliseconds: 300),
                //     pinTheme: PinTheme(
                //       shape: PinCodeFieldShape.box,
                //       borderRadius: BorderRadius.circular(10),
                //       fieldHeight: 40,
                //       fieldWidth: 40,
                //       activeFillColor: Colors.white,
                //       inactiveFillColor: Colors.white,
                //       selectedColor: Colors.white,
                //       inactiveColor: Colors.white,
                //       activeColor: Colors.white,
                //       selectedFillColor: Colors.white,
                //       errorBorderColor: Colors.red,
                //     ),
                //   ),
                // ),
                //      Padding(
                //        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.15),
                //        child: SizedBox(
                //           height: MediaQuery.of(context).size.height * 0.06,
                //           width: MediaQuery.of(context).size.width * 0.7,
                //           child: TextButton(
                //             style: TextButton.styleFrom(
                //               backgroundColor: Colors.black,
                //               shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(12.0),
                //               ),
                //             ),
                //             onPressed: () {
                //             print('login button pressed');
                //           },
                //             child: Text('Login',//login
                //               style: TextStyle(
                //                   fontSize: MediaQuery.of(context).size.height * 0.025,
                //                   color: Colors.white,
                //                   fontWeight: FontWeight.bold),
                //             ),
                //           ),
                //         ),
                //      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );  
  }

void verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then(
      (value) {
        setState(() {
          user = FirebaseAuth.instance.currentUser;
        });
      },
    ).whenComplete(
      () {
        if (user != null) {
          Fluttertoast.showToast(
            msg: "You are logged in successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          );
        } else {
          Fluttertoast.showToast(
            msg: "your login is failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
    );
  }
  void loginWithPhone() async {

    // _listenOtp();

    final signCode = SmsAutoFill().getAppSignature;
    print("sign code---- ${signCode}");
    auth.verifyPhoneNumber(
      phoneNumber: "+91" + phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}