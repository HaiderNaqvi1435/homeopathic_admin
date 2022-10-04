import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_quill/flutter_quill.dart';

class RemedyData {
  String? materia, remedy;
  var discrp;
  DocumentReference? reff;
  RemedyData({this.materia, this.remedy, this.discrp,this.reff});

  Map<String, dynamic> toMap() {
    return {
      "materia": materia,
      "remedy": remedy,
      "discrp": discrp,
    };
  }

  RemedyData.fromMap(Map<String, dynamic> map)
      : materia = map["materia"],
        remedy = map["remedy"],
        discrp = map["discrp"];
}
