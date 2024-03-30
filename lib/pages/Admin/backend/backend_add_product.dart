import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//final productProvider = ChangeNotifierProvider((ref) => ProductProvider());

class ProductProvider extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();

  List<String>? imageURLList = [];
  List<XFile>? imageFileList = [];
  dynamic _pickedImageError;

  void pickProductImage() async {
    try {
      final pickedImages = await _picker.pickMultiImage(
          maxHeight: 500, maxWidth: 300, imageQuality: 95);

      imageFileList = pickedImages;
      notifyListeners();
    } catch (e) {
      _pickedImageError = e;
      notifyListeners();
      debugPrint(_pickedImageError);
    }
  }

  Widget previewImage() {
    if (imageFileList!.isNotEmpty) {
      return ListView.builder(
          itemCount: imageFileList!.length,
          itemBuilder: (context, index) {
            return Image.file(File(imageFileList![index].path));
          });
    } else {
      return const Center(
        child: Text(
          'you gave not \n \n picked any image',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void cleanInfor() {
    imageFileList = [];
    imageURLList = [];
    nameController.clear();
    priceController.clear();
    quantityController.clear();
    descriptionController.clear();
    selectCate = null;
    notifyListeners();
  }

  late double price;
  late int quantity;
  late String proName;
  late String proDesc;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> ScaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  List<String> subCategList = [];
  Future<void> upLoadImage() async {
    if (selectCate != 'select category') {
      if (formKey.currentState!.validate()) {
        // kiểm tra xem form có hợp lệ không
        formKey.currentState!.save(); // lưu lại dữ liệu
        if (imageFileList!.isNotEmpty) {
          try {
            for (var image in imageFileList!) {
              //upload image to firebase storage
              final File file = File(image.path); // tạo file từ image
              final ref = FirebaseStorage.instance // tạo ref để lưu file
                  .ref()
                  .child('productImages')
                  .child(DateTime.now().toString() + '.jpg');
              await ref.putFile(file).whenComplete(() async {
                await ref.getDownloadURL().then((value) {
                  // lấy url của file vừa lưu
                  imageURLList!.add(value);
                });
              }); // lưu file lên firebase storage
            }
          } catch (e) {
            print(e);
          }

          ScaffoldKey.currentState!.showSnackBar(
            const SnackBar(
              content: Text("Product uploaded successfully!"),
            ),
          );
          formKey.currentState!.reset();
        } else {
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
    } else {
      ScaffoldKey.currentState!.showSnackBar(const SnackBar(
        content: Text("Please select categories!"),
      ));
    }
  }

  String? selectCate;

  void selectCateg(String? value) {
    selectCate = value!;
    notifyListeners();
  }

  Future<void> upLoadData() async {
    if (imageURLList!.isNotEmpty) {
      try {
        CollectionReference productRef =
            FirebaseFirestore.instance.collection('furniture');
        await productRef.doc().set({
          'category_id': selectCate,
          'price': price,
          'quantity': quantity,
          'name_furniture': proName,
          'description': proDesc,
          'imageURL': imageURLList,
        }).whenComplete(() {
          imageFileList = [];
          imageURLList = [];
          nameController.clear();
          priceController.clear();
          quantityController.clear();
          descriptionController.clear();

          selectCate = null;
          formKey.currentState!.reset();
          notifyListeners();
        });
      } catch (e) {
        print(e);
      }
    } else {
      print('Please fill images first!');
    }
  }

  void uploadProduct() async {
    await upLoadImage().whenComplete(() => upLoadData());
  }

  // get Category to dropdown
  CollectionReference categoryRef =
      FirebaseFirestore.instance.collection('category');
}
