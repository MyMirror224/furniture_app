import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final promotionProvider = ChangeNotifierProvider((ref) => PromotionProvider());

class PromotionProvider extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  String? name;

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void cleanInfor() {
    nameController.clear();
    priceController.clear();
    quantityController.clear();
    descriptionController.clear();

    notifyListeners();
  }

  late double price;
  late int quantity;
  late String proName;
  late String proDesc;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> ScaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  Future<void> upLoadData() async {
    try {
      CollectionReference productRef =
          FirebaseFirestore.instance.collection('furniture');
      await productRef.doc().set({
        'price': price,
        'quantity': quantity,
        'name_furniture': proName,
        'description': proDesc,
      }).whenComplete(() {
        nameController.clear();
        priceController.clear();
        quantityController.clear();
        descriptionController.clear();

        formKey.currentState!.reset();
        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  // get data day
  DateTime birthDay = DateTime.now();
  void ShowDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((value) {
      // if (value != null) {
      //
      // }
      birthDay = value!;
      notifyListeners();
    });
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
}
