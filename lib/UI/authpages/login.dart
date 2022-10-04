import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:homeopathic_admin/Core/DataProviders/DataProvider.dart';
import 'package:homeopathic_admin/UI/Dashboard.dart';
import 'package:homeopathic_admin/UI/authpages/signup.dart';
import 'package:provider/provider.dart';

import '../widgets/textField.dart';

class Login extends StatelessWidget {
  Login({super.key});
  TextEditingController emailcont = TextEditingController();
  TextEditingController passcont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, data, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 150,
                // child: Image.asset(
                //   'assert/auth.png',
                // ),
              ),
              const SizedBox(
                height: 32,
              ),
              Modifiedtextfield(
                controller: emailcont,
                text: 'Email',
                icon: Icons.email,
              ),
              const SizedBox(
                height: 15,
              ),
              Modifiedtextfield(
                controller: passcont,
                text: 'Password',
                icon: Icons.lock,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text('Forget Password?'),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    signin(context: context)
                        .then((value) => data.loaduserData());
                  },
                  child: const Text(
                    'Login',
                  ),
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
                            builder: (context) => Signup(),
                          ));
                    },
                    child: Text(
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
        ),
      ),
    );
  }

  Future signin({required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailcont.text, password: passcont.text)
          .then((value) => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Dashbord(),
              )));
      print('signin success');
    } catch (e) {
      print(e);
    }
  }
}
