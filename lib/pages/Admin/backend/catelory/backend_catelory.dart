import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final cateloryProvider = ChangeNotifierProvider((ref) => CateloryProvider());

class CateloryProvider extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();

  List<String>? imageURLList;
  XFile? imageFileList;
  dynamic _pickedImageError;
  TextEditingController cateloryController = TextEditingController();
  void pickProductImage() async {
    try {
      final pickedImages = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 500,
          maxWidth: 300,
          imageQuality: 95);

      imageFileList = pickedImages!;
      notifyListeners();
    } catch (e) {
      _pickedImageError = e;
      notifyListeners();
      print(_pickedImageError);
    }
  } //done

  Widget previewImage() {
    if (imageFileList != null) {
      return Image.file(File(imageFileList!.path));
    } else {
      return const Center(
        child: Text(
          'you gave not \n \n picked any image',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      );
    }
  } //done

  void cleanImage() {
    imageFileList = null;
    cateloryController.clear();
    notifyListeners();
  } //done

  late String cateName;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> ScaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  Future<void> upLoadImage() async {
    if (formKey.currentState!.validate()) {
      // kiểm tra xem form có hợp lệ không
      formKey.currentState!.save(); // lưu lại dữ liệu
      if (imageFileList != null) {
        try {
          //upload image to firebase storage
          final File file = File(imageFileList!.path); // tạo file từ image
          final ref = FirebaseStorage.instance // tạo ref để lưu file
              .ref()
              .child('catelory')
              .child(DateTime.now().toString() + '.jpg');
          await ref.putFile(file).whenComplete(() async {
            await ref.getDownloadURL().then((value) {
              // get image url for imageURLList
              imageURLList = [value];
            });
          }); // lưu file lên firebase storage
        } catch (e) {
          print(e);
        }
        debugPrint('Product uploaded successfully!');
        ScaffoldKey.currentState!.showSnackBar(
          const SnackBar(
            content: Text("Product uploaded successfully!"),
          ),
        );
        formKey.currentState!.reset();
      } else {
        debugPrint('Miss image!');
        ScaffoldKey.currentState!.showSnackBar(
          const SnackBar(
            content: Text("Please fill images first!"),
          ),
        );
      }
    } else {
      ScaffoldKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text("Please fill all the fields"),
        ),
      );
    }
  }

  Future<void> upLoadData() async {
    if (imageURLList != null) {
      try {
        CollectionReference productRef =
            FirebaseFirestore.instance.collection('catelory');
        await productRef.doc().set({
          'name_catelory': cateName,
          'imageURL': imageURLList,
        }).whenComplete(() {
          imageFileList = null;
          formKey.currentState!.reset();
          notifyListeners();
        });
        debugPrint('data uploaded successfully!');
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      print('Please fill images first!');
    }
  }

  void uploadProduct() async {
    await upLoadImage().whenComplete(() => upLoadData());
    notifyListeners();
  }

  //handle delete catelory
  void handleDelete(String id, context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Delete Catelory'),
              content: const Text('Are you sure to delete this catelory?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('catelory')
                        .doc(id)
                        .delete()
                        .whenComplete(() {
                      Navigator.pop(context);
                    });
                  },
                  child: const Text('Delete'),
                ),
              ],
            ));
  } //done

  //handle update catelory
  final ImagePicker _pickerUpdate = ImagePicker();

  List<String>? imageURLListUpdate;
  XFile? imageFileListUpdate;
  dynamic _pickedImageErrorUpdate;

  // void pickProductImageUpdate() async {
  //   try {
  //     final pickedImages = await _pickerUpdate.pickImage(
  //         source: ImageSource.gallery,
  //         maxHeight: 500,
  //         maxWidth: 300,
  //         imageQuality: 95);

  //     imageFileListUpdate = pickedImages!;
  //     debugPrint(imageFileListUpdate!.path);
  //     notifyListeners();
  //   } catch (e) {
  //     _pickedImageErrorUpdate = e;
  //     notifyListeners();
  //     print(_pickedImageErrorUpdate);
  //   }
  // } //done

  Widget previewImageUpdate() {
    if (imageFileListUpdate != null) {
      return Image.file(File(imageFileListUpdate!.path));
    } else {
      return const Center(
        child: Text(
          'you gave not \n \n picked any image',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      );
    }
  } //done

  void cleanImageUpdate() {
    imageFileListUpdate = null;
    notifyListeners();
  } //done

  // Future<void> upLoadImageUpdate() async {
  //   if (imageFileListUpdate != null) {
  //     try {
  //       //upload image to firebase storage
  //       final File file = File(imageFileListUpdate!.path); // tạo file từ image
  //       final ref = FirebaseStorage.instance // tạo ref để lưu file
  //           .ref()
  //           .child('catelory')
  //           .child(DateTime.now().toString() + '.jpg');
  //       await ref.putFile(file).whenComplete(() async {
  //         await ref.getDownloadURL().then((value) {
  //           // get image url for imageURLList
  //           imageURLListUpdate = [value];
  //         });
  //       }); // lưu file lên firebase storage
  //     } catch (e) {
  //       print(e);
  //     }
  //     debugPrint('Product uploaded successfully!');
  //   } else {
  //     debugPrint('Miss image!');
  //   }
  // }

  // Future<void> upLoadDataUpdate(String id) async {
  //   if (imageURLListUpdate != null) {

  //   } else {
  //     print('dataUpdate uploaded failer');
  //   }
  // }
  String cateNameUpdate = '';
  void handleUpdate(String id, _) async {
    showDialog(
        context: _,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Update Catelory'),
              content: const Text('Are you sure to update this catelory?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).maybePop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    if (cateNameUpdate != '') {
                      try {
                        CollectionReference productRef =
                            FirebaseFirestore.instance.collection('catelory');
                        await productRef.doc(id).update({
                          'name_catelory': cateNameUpdate,
                          // 'imageURL': imageURLListUpdate,
                        }).whenComplete(() {
                          // imageFileListUpdate = null;
                          // notifyListeners();
                          Navigator.pop(context);
                        });
                        debugPrint('dataUpdate uploaded successfully!');
                        Navigator.of(context).maybePop();
                      } catch (e) {
                        debugPrint(e.toString());
                      }
                    } else {
                      debugPrint('cateNameUpdate is null');
                      showDialog(
                          context: _,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content:
                                  const Text('Please fill to Catelory name'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).maybePop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          });
                    }
                  },
                  child: const Text('Update'),
                ),
              ],
            ));
  }

  var textFormDecoration = InputDecoration(
    labelText: "price",
    hintText: 'price..\$ ',
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xff5c8273), width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueGrey.shade100, width: 2),
      borderRadius: BorderRadius.circular(10),
    ),
  );
  ScrollController scrollController = ScrollController();
}
