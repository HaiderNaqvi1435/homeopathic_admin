import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:homeopathic_admin/Core/Models/RemedyData.dart';
import 'package:homeopathic_admin/Core/Models/userData.dart';

import '../Models/MateriaData.dart';

class DataProvider with ChangeNotifier {
  DataProvider() {
    search();
    loaduserData();
    loadremedy();
  }
  loaduserData() async {
    FirebaseFirestore.instance
        .collection("UserData")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      userData = UserData.fromMap(value.data()!);

      print(userData.cnic);
      notifyListeners();
    });
  }

  UserData userData = UserData();
  List<RemedyData> remedylist = [];
  List<MateriaData> doctors = [];
  final materia = [
    MateriaData(
        image: "images/John_Henry_Clarke.jpg",
        name: "John Henry Clarke",
        era: "1853 - 1931",
        details:
            "John Henry Clarke was an English classical homeopath. He was also, arguably, the highest profile anti-Semite of his era in Great Britain. He led The Britons, an anti-Semitic organisation. Educated at the University of Edinburgh, he received his medical degree in 1877."),
    MateriaData(
        image: "images/william-boericke.jpg",
        name: "William Boericke",
        era: "1849 - 1929",
        details:
            "William G. Boericke was an Austrian-born American physician and ardent, influential exponent of homeopathy. He is known in the field today as the compiler and editor of the Pocket Manual of Homeopathic Materia Medica."),
    MateriaData(
      image: "images/John W.jpg",
      name: "John W. Hutchinson",
      era: "1869 - 1936",
      details:
          "John W. Hutchinson is the Abbott and James Lawrence Research Professor of Engineering in the School of Engineering and Applied Sciences at Harvard University. He works in the field of solid mechanics concerned with a broad range of problems in structures and engineering materials.",
    ),
    MateriaData(
        image: "images/wilhelm-schuessler.jpg",
        name: "Wilhelm Heinrich Schüßler",
        era: "1821 - 1898",
        details:
            "Wilhelm Heinrich Schüßler - also spelled Schuessler, particularly in English-language publications — (21 August 1821 - 30 March 1898) was a German medical doctor in Oldenburg who searched for natural remedies and published the results of his experiments in a German homeopathic journal in March 1873 leading to a list of 12 so-called biochemic cell salts that remain popular in alternative medicine."),
    MateriaData(
        image: "images/5c5fa9f5e7697f880a3a423ab08911be.jpg",
        name: "E.B Nash",
        era: "1838 - 1917",
        details:
            "Eugene Beauharnais E. B. Nash was one of America's leading 19th-century homeopaths. Born in Hillsdale, New York, Nash graduated from Cleveland Homoeopathic Medical College in 1874."),
    MateriaData(
        image: "images/0650_Phatak.jpg",
        name: "S.R Phatak",
        era: "1896 - 1924",
        details:
            "He was convinced about Homoeopathy while going through Sir William Osler's writings on 'History of Medicine' so switched over to an entirely Homoeopathic Practice in 1932. He also started working on Homoeopathic literature along with his Practice."),
  ];
  loadremedy() async {
    try {
      FirebaseFirestore.instance.collection("Remedies").get().then((value) {
        remedylist = List.generate(value.size, (index) {
          RemedyData remedyData = RemedyData.fromMap(value.docs[index].data());
          remedyData.reff = value.docs[index].reference;
          return remedyData;
        });
        notifyListeners();
      });
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  search() {
    doctors = List.from(materia);
    notifyListeners();
  }
}
