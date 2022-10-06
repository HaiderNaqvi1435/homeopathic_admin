import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:homeopathic_admin/Core/DataProviders/DataProvider.dart';
import 'package:provider/provider.dart';

import '../widgets/textWidget.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<DataProvider>(
        builder: (context, mydata, child) => Scaffold(
          body: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: Navigator.of(context).pop,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 136, 166, 207),
                              shape: BoxShape.circle),
                          height: 40,
                          width: 40,
                          child: Icon(Icons.arrow_back),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mydata.userData.name ?? "",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white),
                          ),
                          Text(
                            mydata.userData.email ?? "",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  ListTile(
                    title: Modifiedtext(
                      text: 'Phone',
                      bold: true,
                    ),
                    subtitle: Modifiedtext(
                      text: mydata.userData.phone ?? "",
                    ),
                  ),
                  // ListTile(
                  //   title: Modifiedtext(
                  //     text: 'Email',
                  //     bold: true,
                  //   ),
                  //   subtitle: Modifiedtext(
                  //     text: 'Admin@gmail.com',
                  //   ),
                  // ),

                  if (FirebaseAuth.instance.currentUser!.uid !=
                      "B7ViGG8U8kSnrfjxdd05XhMdi6n1")
                    ListTile(
                      title: Modifiedtext(
                        text: 'CNIC',
                        bold: true,
                      ),
                      subtitle: Modifiedtext(
                        text: mydata.userData.cnic ?? "",
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
