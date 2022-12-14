import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:homeopathic_admin/Core/DataProviders/DataProvider.dart';
import 'package:homeopathic_admin/Core/ThemeData/Utils.dart';
import 'package:homeopathic_admin/UI/Homeopathic/HomeoBlogs.dart';
import 'package:homeopathic_admin/UI/authpages/login.dart';
import 'package:homeopathic_admin/UI/authpages/profile.dart';
import 'package:provider/provider.dart';

class Dashbord extends StatefulWidget {
  Dashbord({super.key});

  @override
  State<Dashbord> createState() => _DashbordState();
}

class _DashbordState extends State<Dashbord> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, data, child) => Scaffold(
        // appBar: AppBar(
        //   elevation: 0,
        // ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    color: Colors.black,
                    spreadRadius: 2,
                  )
                ],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                color: Colors.blue,
              ),
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height / 4,
              child: Padding(
                padding: const EdgeInsets.only(left: 36.0, top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Dashboard",
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                    Text(
                      data.userData.cnic ?? data.userData.name!,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.medical_information),
                  label: Text("Homeopathic"),
                  style: Utils.mybutton(context: context),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeoBlogs(),
                        ));
                  },
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  icon: Icon(Icons.medical_information),
                  label: Text("Allopathic"),
                  style: Utils.mybutton(context: context),
                  onPressed: () {
                    print(data.userData.name);
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.person),
                  label: Text("Profile"),
                  style: Utils.mybutton(context: context),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(),
                        ));
                  },
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  icon: Icon(Icons.logout),
                  label: Text("Signout"),
                  style: Utils.mybutton(context: context),
                  onPressed: () {
                    FirebaseAuth.instance
                        .signOut()
                        .then((value) => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            )));
                  },
                ),
              ],
            ),
            // SizedBox(height: 10),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ElevatedButton.icon(
            //       icon: Icon(Icons.medical_information),
            //       label: Text("Homeopathic"),
            //       style: Utils.mybutton(context: context),
            //       onPressed: () {},
            //     ),
            //     SizedBox(
            //       width: 10,
            //     ),
            //     ElevatedButton.icon(
            //       icon: Icon(Icons.medical_information),
            //       label: Text("Allopathic"),
            //       style: Utils.mybutton(context: context),
            //       onPressed: () {},
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
