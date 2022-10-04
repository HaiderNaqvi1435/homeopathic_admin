import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_quill/flutter_quill.dart';

class RemedyData {
  String? materia, remedy, userID;
  var discrp;
  DocumentReference? reff;
  RemedyData({this.materia, this.remedy, this.discrp, this.reff, this.userID});

  Map<String, dynamic> toMap() {
    return {
      "materia": materia,
      "remedy": remedy,
      "discrp": discrp,
      "userID": userID,
    };
  }

  RemedyData.fromMap(Map<String, dynamic> map)
      : materia = map["materia"],
        remedy = map["remedy"],
        userID = map["userID"],
        discrp = map["discrp"];
}
