import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:homeopathic_admin/Core/DataProviders/DataProvider.dart';
import 'package:homeopathic_admin/UI/Homeopathic/addBlog.dart';
import 'package:provider/provider.dart';

import '../../Core/Models/RemedyData.dart';

class Remedydetails extends StatefulWidget {
  Remedydetails({Key? key, this.remedyData}) : super(key: key);
  RemedyData? remedyData;
  @override
  State<Remedydetails> createState() => _RemedydetailsState();
}

class _RemedydetailsState extends State<Remedydetails> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    QuillController quillController = QuillController(
        document: Document.fromJson(jsonDecode(widget.remedyData!.discrp)),
        selection: TextSelection.collapsed(offset: 0));
    return Consumer<DataProvider>(
      builder: (context, mydata, child) => Scaffold(
        appBar: AppBar(
          title: Text("Remedy"),
          actions: [
            if (FirebaseAuth.instance.currentUser!.uid ==
                "B7ViGG8U8kSnrfjxdd05XhMdi6n1")
              IconButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection("Remedies")
                        .doc(widget.remedyData!.reff!.id)
                        .delete()
                        .then((value) {
                      mydata.loadremedy();
                      Navigator.pop(context);
                      return ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Blog Deleted!")));
                    });
                  },
                  icon: Icon(Icons.delete)),
            if (FirebaseAuth.instance.currentUser!.uid ==
                "B7ViGG8U8kSnrfjxdd05XhMdi6n1")
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NewBlog(remedyData: widget.remedyData),
                        ));
                  },
                  icon: Icon(Icons.edit)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8),
          child: Column(
            children: [
              ListTile(
                dense: true,
                title: Text(
                  widget.remedyData!.remedy!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.green),
                ),
                subtitle: Text(widget.remedyData!.materia!),
              ),
              Divider(
                thickness: 1,
              ),
              Expanded(
                child: QuillEditor(
                  padding: EdgeInsets.zero,
                  autoFocus: false,
                  scrollable: true,
                  expands: true,
                  showCursor: false,
                  scrollController: scrollController,
                  focusNode: FocusNode(),
                  controller: quillController,
                  readOnly: true,
                ),
              ),
              // .toString()
              // .replaceAll("\n", "")
              // Document.fromJson(jsonDecode(widget.remedyData!.discrp))
              //     .toDelta()
              //     .toJson(),
            ],
          ),
        ),
      ),
    );
  }
}

// class NotesBlockEmbed extends CustomBlockEmbed {
//   const NotesBlockEmbed(String value) : super(noteType, value);

//   static const String noteType = 'notes';

//   static NotesBlockEmbed fromDocument(Document document) =>
//       NotesBlockEmbed(jsonEncode(document.toDelta().toJson()));

//   Document get document => Document.fromJson(jsonDecode(data));
// }
