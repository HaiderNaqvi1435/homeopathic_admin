import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homeopathic_admin/Core/DataProviders/DataProvider.dart';
import 'package:homeopathic_admin/UI/Dashboard.dart';
import 'package:homeopathic_admin/UI/authpages/login.dart';
import 'package:provider/provider.dart';

class authmanager {
  loginservice() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ChangeNotifierProvider<DataProvider>(
              create: (context) => DataProvider(), child: Dashbord());
        } else {
          return Login();
        }
      },
    );
  }
}
