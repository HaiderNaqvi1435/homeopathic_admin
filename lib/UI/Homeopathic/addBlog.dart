import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:homeopathic_admin/Core/DataProviders/DataProvider.dart';
import 'package:homeopathic_admin/Core/Models/RemedyData.dart';
import 'package:provider/provider.dart';

class NewBlog extends StatefulWidget {
  NewBlog({Key? key, this.remedyData}) : super(key: key);
  RemedyData? remedyData;
  @override
  State<NewBlog> createState() => _NewBlogState();
}

class _NewBlogState extends State<NewBlog> {
  @override
  void initState() {
    if (widget.remedyData != null) {
      quillcont = QuillController(
          document: Document.fromJson(jsonDecode(widget.remedyData!.discrp)),
          selection: TextSelection.collapsed(offset: 0));
      remdycont.text = widget.remedyData!.remedy!;
      materiaValue = widget.remedyData!.materia;
    }
    // TODO: implement initState
    super.initState();
  }

  ScrollController scrollController = ScrollController();
  QuillController quillcont = QuillController.basic();
  TextEditingController remdycont = TextEditingController();
  String? materiaValue;
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, data, child) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async {
                try {
                  if (widget.remedyData == null) {
                    RemedyData remedyData = RemedyData(
                      remedy: remdycont.text,
                      materia: materiaValue,
                      userID: FirebaseAuth.instance.currentUser!.uid,
                      discrp: jsonEncode(quillcont.document.toDelta().toJson()),
                    );

                    await FirebaseFirestore.instance
                        .collection("Remedies")
                        .add(remedyData.toMap())
                        .then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Blog Uploaded!")));
                      print("Uploaded Succesfull");
                    });
                  } else {
                    widget.remedyData!.discrp =
                        jsonEncode(quillcont.document.toDelta().toJson());
                    widget.remedyData!.materia = materiaValue;
                    widget.remedyData!.remedy = remdycont.text;

                    widget.remedyData!.reff!
                        .set(widget.remedyData!.toMap())
                        .then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Blog Updated!")));
                      print("Uploaded Succesfull");
                    });
                  }
                } catch (e) {
                  print("Something went wrong");
                  print(e);
                }

                data.loadremedy();
              },
              icon: Icon(Icons.done),
            )
          ],
          title: Text('Doctor Alopathic'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    DropdownButtonFormField(
                      hint: Text("Select Materia"),
                      borderRadius: BorderRadius.circular(10),
                      value: materiaValue,
                      items: data.materia
                          .map((e) => DropdownMenuItem(
                              value: e.name, child: Text(e.name!)))
                          .toList(),
                      onChanged: ((valuee) => setState(
                            () {
                              materiaValue = valuee;
                            },
                          )),
                    ),
                    TextFormField(
                      controller: remdycont,
                      decoration: const InputDecoration(
                        label: Text(
                          'Remedy',
                        ),
                      ),
                    ),
                    QuillEditor(
                      showCursor: true,
                      scrollable: false,
                      expands: false,
                      padding: const EdgeInsets.all(8),
                      scrollController: scrollController,
                      autoFocus: true,
                      focusNode: FocusNode(),
                      controller: quillcont,
                      readOnly: false,
                    ),
                  ],
                ),
                BottomAppBar(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        QuillToolbar.basic(
                          controller: quillcont,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
