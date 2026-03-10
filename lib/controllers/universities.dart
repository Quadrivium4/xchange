import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class UniversityModel {
  String alphaTwoCode;
  String country;
  String name;
  List<String> domains;
  String uid;


  UniversityModel({
    required this.alphaTwoCode,
    required this.country,
    required this.name,
    required this.domains,
    required this.uid,

  }) ;

  factory UniversityModel.fromDocument(TFirestoreResonse snap) {
    final data = snap.data();
    
    return UniversityModel(
      alphaTwoCode: data?['alpha_two_code'] ?? "",
      country: data?['country'] ?? "",
      name: data?['name'] ?? "",
      domains: List<String>.from(data?['domains'] ?? []),

      uid: snap.id,
    );
  }
}

typedef TFirestoreResonse = DocumentSnapshot<Map<String, dynamic>>;

class UniversitiesController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;


  Future<List<UniversityModel>> searchUniversity(String country) async {
    try {

      final data = await _db.collection("univerisities").where("country", isEqualTo: country).get();
      print("search universities: ${data.docs.length}");
      return data.docs.map((doc) => UniversityModel.fromDocument(doc)).toList();
    } catch (err) {
      print("ERROR found");
      rethrow;
    }
  }



}
