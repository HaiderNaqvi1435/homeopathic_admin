import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../Core/Models/userData.dart';
import '../widgets/textField.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController cnic = TextEditingController();
  TextEditingController password = TextEditingController();
  String? phoneno;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            width: double.maxFinite,
            child: Image.asset(
              'assets/sign.png',
              fit: BoxFit.cover,
            ),
          ),
          Modifiedtextfield(
            controller: name,
            text: 'Name',
          ),
          SizedBox(
            height: 10,
          ),
          Modifiedtextfield(
            controller: email,
            text: 'Email',
          ),
          SizedBox(
            height: 10,
          ),
          Modifiedtextfield(
            controller: cnic,
            text: 'CNIC',
          ),
          SizedBox(
            height: 10,
          ),
          Modifiedtextfield(
            controller: password,
            text: 'Password',
          ),
          SizedBox(height: 10),
          IntlPhoneField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  15,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
              labelText: 'Phone Number',
            ),
            initialCountryCode: 'PK',
            onChanged: (phone) {
              setState(() {
                phoneno = phone.completeNumber;
              });
              print(phone.completeNumber);
            },
          ),

          // child: IntlPhoneField(
          //   decoration: InputDecoration(
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(
          //         15,
          //       ),
          //     ),
          //     filled: true,
          //     fillColor: Colors.white,
          //     labelText: 'Phone Number',
          //   ),
          //   onChanged: (phone) {
          //     setState(() {
          //       phoneno = phone.toString();
          //       print(phoneno);
          //     });
          //   },
          //   onCountryChanged: (country) {
          //     print('Country changed to: ' + country.name);
          //   },
          // ),

          ElevatedButton(
            onPressed: () {
              signupp();
            },
            child: const Text(
              'Sign up',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Do not have an account?'),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ));
                },
                child: const Text(
                  'Sign up',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }

  Future signupp() async {
    UserData userData = UserData(
      email: email.text.toLowerCase().trim(),
      name: name.text,
      cnic: cnic.text,
      phone: phoneno,
    );
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: email.text.toLowerCase().trim(), password: password.text)
        .then((value) async {
      FirebaseFirestore.instance
          .collection("UserData")
          .doc(value.user!.uid)
          .set(userData.toMap());

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Login()));
    });
  }
}
