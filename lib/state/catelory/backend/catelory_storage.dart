import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:furniture_app/constant/firebase_field_collection.dart';
import 'package:furniture_app/constant/firebase_field_name.dart';
import 'package:furniture_app/state/catelory/catelory_payload.dart';

@immutable
class CateloryStorage {
  const CateloryStorage();
  Future<bool> addCatelory(
      {required String name, required String image}) async {
    try {
      final catelory = await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.catelory,
          )
          .where(
            FirebaseFieldName.cateloryName,
            isEqualTo: name,
          )
          .limit(1)
          .get();
      if (catelory.docs.isNotEmpty) {
        return false;
      }
      final cateloryPayload = CateloryPayload(
        cateloryName: name,
        cateloryImage: image,
      );
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.catelory)
          .add(cateloryPayload);
      return true;
    } on FirebaseException {
      return false;
    }

  }
  Future<bool> deleteCatelory({
    required String cateloryName,
  }) async {
    try {
      final catelory = await FirebaseFirestore.instance.collection(
        FirebaseCollectionName.catelory,
      ).limit(1).get();

      if(catelory.docs.isEmpty){
        return false;
      }
      
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.catelory)
          .doc(catelory.docs.first.id)
          .delete();
      return true;
    } catch (_){
      return false;
    }
  }
  Future<bool> updateCatelory({
    required String cateloryNameold,
    required String cateloryImageold,
    required String? cateloryName,
    required String? cateloryImage,

  }) async {
    try{
    final catelory = await FirebaseFirestore.instance.collection(FirebaseCollectionName.catelory).where(
      FirebaseFieldName.cateloryName,
      isEqualTo: cateloryNameold,
    ).limit(1).get();
    
    
    await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.catelory)
        .doc(catelory.docs.first.id)
        .update(
          {
            FirebaseFieldName.cateloryName: cateloryName ?? cateloryNameold,
            FirebaseFieldName.cateloryImage: cateloryImage?? cateloryImageold,
          }
        );
    return true;
    }catch(_){
      return false;

    }
  }

}
