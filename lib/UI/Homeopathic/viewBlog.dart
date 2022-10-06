import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Remedy"),
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
