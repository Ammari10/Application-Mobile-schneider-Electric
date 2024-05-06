// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_app1/pages/registre.dart';
import 'package:flutter_app1/pages/shared/Colors.dart';
import 'package:flutter_app1/pages/shared/Contants.dart';

class Login extends StatelessWidget {
  const Login({Key?key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 247, 247, 247),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(33.0),
            child: Column( 
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 74,
                ),
       TextField(
            keyboardType: TextInputType.emailAddress,
            obscureText: false,
            decoration: InputDecoration(
              hintText: "Enter Your Email:",
              filled: true,
              fillColor: Color.fromARGB(255, 255, 255, 255), // Replace Colors.white with your desired color
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none, // Optional: You can customize border sides here
              ),
            ),
          ),


              //   TextField(
                  
                  
              //       keyboardType: TextInputType.emailAddress,
              //       obscureText: false,
              //       decoration: decorationTextField.copyWith(
              //         hintText: "Enter Your Email:",
              //          filled: true,
              //     fillColor: Color.fromARGB(255, 152, 137, 137), // Replace Colors.white with your desired color
              //          border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(10.0),
              //   borderSide: BorderSide.none, // Optional: You can customize border sides here
              // ),
              //       )),

                const SizedBox(
                  height: 20,
                ),


                 TextField(
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Enter Your Password:",
              filled: true,
              fillColor: Color.fromARGB(255, 255, 255, 255), // Replace Colors.white with your desired color
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none, // Optional: You can customize border sides here
              ),
            ),
          ),

                // TextField(
                //     keyboardType: TextInputType.text,
                //     obscureText: true,
                //     decoration: decorationTextField.copyWith(
                //       hintText: "Enter Your Password:",
                //     )),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Sign in",
                    style: TextStyle(fontSize: 19, color: const Color.fromARGB(255, 255, 255, 255)),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(BTNgreen),
                    padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("do not have an account ?",
                        style: TextStyle(fontSize: 18)),
                    TextButton(
                        onPressed: () {

                           Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const registre()),
                        );
                        },
                        child: Text('sign up',
                            style:
                                TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 18))),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
