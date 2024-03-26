import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:furniture_app/pages/Admin/backend/backend_category.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cateProvi = ref.watch(categoryProvider);
    var size = MediaQuery.of(context).size;
    CollectionReference categoryRef =
        FirebaseFirestore.instance.collection('category');
    return ScaffoldMessenger(
      key: cateProvi.ScaffoldKey,
      child: Scaffold(
        body: SafeArea(
          // vừa khung hình
          child: SingleChildScrollView(
            // cuộn màn hình

            // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
            //     .onDrag, // khi cuộn màn hình thì bàn phím tự động ẩn đi
            child: Form(
              key: cateProvi.formKey,
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
                          child: cateProvi.imageFileList != null
                              ? cateProvi.previewImage()
                              : const Center(
                                  child: Text(
                                    'you gave not \n \n picked any image',
                                    style: TextStyle(fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: size.width * 0.5,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 5.0, right: 0.5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10.0,
                                    ),
                                    child: Column(
                                      children: [
                                        // button add image and clean image
                                        ElevatedButton(
                                          onPressed: cateProvi.pickProductImage,
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                          child: const SizedBox(
                                              width: 50,
                                              child: Icon(Icons.photo_library)),
                                        ),
                                        const Gap(10),
                                        ElevatedButton(
                                          onPressed: () {
                                            cateProvi.cleanImage();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                          child: const SizedBox(
                                            width: 50,
                                            child:
                                                Icon(FontAwesomeIcons.trashAlt),
                                          ),
                                        )
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          controller: cateProvi.categoryController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter category name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            cateProvi.cateName = value!;
                          },
                          decoration: cateProvi.textFormDecoration.copyWith(
                            labelText: 'category Name',
                            hintText: 'category Name',
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
                              cateProvi.uploadProduct();
                            },
                            child: const Text('Upload'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              cateProvi.cleanImage();
                            },
                            child: const Text('Clean'),
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

                    // list of category plan 2
                    StreamBuilder(
                      stream: categoryRef.snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text('Loading');
                        }
                        return SizedBox(
                          height: size.height * 0.4,
                          child: ListView(
                            shrinkWrap: true,
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;
                              return ListTile(
                                leading: Text(data['name_category']),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image(
                                      image: NetworkImage(data['imageURL'][0]),
                                      width: size.width * 0.3,
                                      height: size.width * 0.3,
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (context) => AlertDialog(
                                                          title: const Text(
                                                              'Edit Catolory'),
                                                          content: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                        margin: const EdgeInsets
                                                                            .all(
                                                                            15),
                                                                        color: Colors
                                                                            .blueGrey
                                                                            .shade100,
                                                                        height: size.width *
                                                                            0.3,
                                                                        width: size.width *
                                                                            0.3,
                                                                        child:
                                                                            //
                                                                            Image(
                                                                          image:
                                                                              NetworkImage(document['imageURL'][0]),
                                                                          width:
                                                                              size.width * 0.3,
                                                                          height:
                                                                              size.width * 0.3,
                                                                        )),
                                                                    // SizedBox(
                                                                    //   child: Padding(
                                                                    //     padding: const EdgeInsets
                                                                    //         .only(
                                                                    //         left: 5.0,
                                                                    //         right:
                                                                    //             0.3),
                                                                    //     child: Column(
                                                                    //       mainAxisAlignment:
                                                                    //           MainAxisAlignment
                                                                    //               .center,
                                                                    //       crossAxisAlignment:
                                                                    //           CrossAxisAlignment
                                                                    //               .start,
                                                                    //       children: [
                                                                    //         Column(
                                                                    //           children: [
                                                                    //             // button add image and clean image
                                                                    //             ElevatedButton(
                                                                    //               onPressed:
                                                                    //                   () {
                                                                    //                 cateProvi.pickProductImageUpdate();
                                                                    //               },
                                                                    //               style:
                                                                    //                   ElevatedButton.styleFrom(
                                                                    //                 shape: RoundedRectangleBorder(
                                                                    //                   borderRadius: BorderRadius.circular(16),
                                                                    //                 ),
                                                                    //               ),
                                                                    //               child:
                                                                    //                   SizedBox(child: const Icon(Icons.photo_library)),
                                                                    //             ),
                                                                    //             const Gap(
                                                                    //                 10),
                                                                    //             ElevatedButton(
                                                                    //               onPressed:
                                                                    //                   () {
                                                                    //                 cateProvi.cleanImageUpdate();
                                                                    //               },
                                                                    //               style:
                                                                    //                   ElevatedButton.styleFrom(
                                                                    //                 shape: RoundedRectangleBorder(
                                                                    //                   borderRadius: BorderRadius.circular(16),
                                                                    //                 ),
                                                                    //               ),
                                                                    //               child:
                                                                    //                   SizedBox(
                                                                    //                 child: const Icon(FontAwesomeIcons.trashAlt),
                                                                    //               ),
                                                                    //             )
                                                                    //           ],
                                                                    //         ),
                                                                    //       ],
                                                                    //     ),
                                                                    //   ),
                                                                    // ),
                                                                  ],
                                                                ),
                                                                Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child:
                                                                        Consumer(
                                                                      builder: (context,
                                                                          ref,
                                                                          child) {
                                                                        return Consumer(builder: (context,
                                                                            ref,
                                                                            child) {
                                                                          return TextFormField(
                                                                            initialValue:
                                                                                document['name_category'],
                                                                            validator:
                                                                                (value) {
                                                                              if (value!.isEmpty) {
                                                                                return 'Please enter category name update';
                                                                              }
                                                                              return null;
                                                                            },
                                                                            onChanged:
                                                                                (value) {
                                                                              cateProvi.cateNameUpdate = value.toString();
                                                                            },
                                                                            maxLength:
                                                                                100,
                                                                            maxLines:
                                                                                3,
                                                                            decoration:
                                                                                cateProvi.textFormDecoration.copyWith(
                                                                              labelText: 'category name update',
                                                                              hintText: 'Enter category name update',
                                                                            ),
                                                                          );
                                                                        });
                                                                      },
                                                                    )),
                                                              ]),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  'Cancel'),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                cateProvi
                                                                    .handleUpdate(
                                                                        document
                                                                            .id,
                                                                        context);

                                                                // Navigator.pushReplacement(
                                                                //     context,
                                                                //     MaterialPageRoute(
                                                                //         builder:
                                                                //             (context) =>
                                                                //                 const categoryScreen()));
                                                              },
                                                              child: const Text(
                                                                  'Save'),
                                                            ),
                                                          ],
                                                        ));
                                          },
                                          icon: const Icon(Icons.edit),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            cateProvi.handleDelete(
                                                document.id, context);
                                          },
                                          icon: const Icon(Icons.delete),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
