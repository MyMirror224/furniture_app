import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:furniture_app/pages/Admin/backend/backend_add_product.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UploadProductScreen extends ConsumerWidget {
  const UploadProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productProvi = ref.watch(productProvider);
    var size = MediaQuery.of(context).size;
    return ScaffoldMessenger(
      key: productProvi.ScaffoldKey,
      child: Scaffold(
        body: SafeArea(
          // vừa khung hình
          child: SingleChildScrollView(
            // cuộn màn hình
            //reverse: true, hiển thị các phần tử từ dưới lên
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
                .onDrag, // khi cuộn màn hình thì bàn phím tự động ẩn đi
            child: Form(
              key: productProvi.formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(15),
                          color: Colors.blueGrey.shade100,
                          height: size.width * 0.5,
                          width: size.width * 0.5,
                          child: productProvi.imageFileList != null
                              ? productProvi.previewImage()
                              : const Center(
                                  child: Text(
                                    'you gave not \n \n picked any image',
                                    style: TextStyle(fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                        ),
                        SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Select Category',
                                  style: TextStyle(color: Colors.red)),
                              StreamBuilder(
                                stream: productProvi.categoryRef.snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasData) {
                                    List<DropdownMenuItem<String>> items = [];
                                    snapshot.data?.docs.forEach((doc) {
                                      items.add(DropdownMenuItem<String>(
                                        value: doc
                                            .id, // Sử dụng ID của document làm giá trị
                                        child: Text(doc['name_category']),
                                      ));
                                    });

                                    return DropdownButton<String>(
                                      hint: const Text('Select Category'),
                                      value: productProvi
                                          .selectCate, // Đặt giá trị mặc định cho dropdown
                                      items: items,
                                      onChanged: (value) {
                                        productProvi.selectCateg(value!);
                                      },
                                    );
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                },
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, left: 10),
                                  child: Column(
                                    children: [
                                      // button add image and clean image
                                      ElevatedButton(
                                        onPressed:
                                            productProvi.pickProductImage,
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                        ),
                                        child: const SizedBox(
                                            child: Icon(Icons.photo_library)),
                                      ),
                                      const Gap(10),
                                      ElevatedButton(
                                        onPressed: () {
                                          productProvi.cleanInfor();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                        ),
                                        child: const SizedBox(
                                          child:
                                              Icon(FontAwesomeIcons.trashCan),
                                        ),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                      child: Divider(
                        thickness: 1.5,
                        endIndent: 20,
                        indent: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextFormField(
                          controller: productProvi.priceController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter price';
                            } else if (!value.isValidPrice()) {
                              return 'Please enter valid price';
                            }
                            return null;
                          },

                          onSaved: (value) {
                            productProvi.price = double.parse(value!);
                          },
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true), // nhập số từ bàn phím
                          decoration: textFormDecoration.copyWith(
                            labelText: 'price',
                            hintText: 'price..\$ ',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextFormField(
                          controller: productProvi.quantityController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Quantity';
                            } else if (!value.isValidQuantity()) {
                              return 'Please enter valid Quantity (1-9999)';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            productProvi.quantity = int.parse(value!);
                          },
                          keyboardType: TextInputType.number,
                          decoration: textFormDecoration.copyWith(
                            labelText: 'Quantity',
                            hintText: 'Add Quantity ',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          controller: productProvi.nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter product name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            productProvi.proName = value!;
                          },
                          maxLength: 100,
                          maxLines: 3,
                          decoration: textFormDecoration.copyWith(
                            labelText: 'product name',
                            hintText: 'Enter product name',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          controller: productProvi.descriptionController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter product description';
                            }
                            return null;
                          },
                          // onChanged: (value) {
                          //   proDesc = value;
                          // },
                          onSaved: (value) {
                            productProvi.proDesc = value!;
                            //value! được gọi là toán tử khẳng định không null nó chỉ lưu giá trị khi value khác null
                          },

                          maxLength: 500,
                          maxLines: 5,
                          decoration: textFormDecoration.copyWith(
                            labelText: 'product description',
                            hintText: 'Enter product description ',
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              productProvi.uploadProduct();
                            },
                            child: const Text('Upload'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              productProvi.cleanInfor();
                            },
                            child: const Text('Clean'),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
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

extension QuantityValidator on String {
  bool isValidQuantity() {
    return RegExp(r'^[1-9]\d{0,3}$').hasMatch(this);
  }
}

extension PriceValidator on String {
  bool isValidPrice() {
    return RegExp(r'^((([1-9][0-9]*[\.]*)||([0]*[\.]*))([0-9]{1,2}))$')
        .hasMatch(this);
  }
}
