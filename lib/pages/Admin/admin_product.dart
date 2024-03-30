// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:furniture_app/pages/Admin/admin_add_product.dart';
// import 'package:furniture_app/pages/Admin/backend/backend_product.dart';
// import 'package:gap/gap.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// class ProductScreen extends ConsumerWidget {
//   const ProductScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final productProvi = ref.watch(productProvider);
//     final searchController = TextEditingController();
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//         body: SafeArea(
//       child: SingleChildScrollView(
//           child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const Text('Search by Category',
//                       style: TextStyle(color: Colors.red)),
//                   StreamBuilder(
//                     stream: productProvi.cateRef.snapshots(),
//                     builder: (BuildContext context,
//                         AsyncSnapshot<QuerySnapshot> snapshot) {
//                       if (snapshot.hasData) {
//                         List<DropdownMenuItem<String>> items = [];
//                         snapshot.data?.docs.forEach((doc) {
//                           items.add(DropdownMenuItem<String>(
//                             value:
//                                 doc.id, // Sử dụng ID của document làm giá trị
//                             child: Text(doc['name_category']),
//                           ));
//                         });

//                         return ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: DropdownButton<String>(
//                             hint: const Text('Select Category'),
//                             borderRadius: BorderRadius.circular(10),
//                             // value: productProvi
//                             //     .categoryName, // Sử dụng giá trị đã chọn
//                             items: items,
//                             onChanged: (value) {
//                               productProvi.searchName = '';
//                               productProvi.changeCategory(value!);
//                               debugPrint(value);
//                             },
//                           ),
//                         );
//                       } else {
//                         return const Text('Something wrong');
//                       }
//                     },
//                   ),
//                 ]),
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => UploadProductScreen()));
//               },
//               child: Container(
//                 width: size.width * 0.5,
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Text(
//                       'Add Product',
//                       style: GoogleFonts.roboto(
//                         fontSize: 18,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     const Icon(
//                       Icons.add,
//                       color: Colors.grey,
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//         const Gap(10),
//         Container(
//           alignment: Alignment.centerLeft,
//           margin: const EdgeInsets.only(left: 20.0, right: 20.0),
//           padding: const EdgeInsets.only(
//             left: 20,
//           ),
//           height: 45,
//           decoration: const BoxDecoration(
//             color: Color(0xFF93B1A6),
//             borderRadius: BorderRadius.all(
//               Radius.circular(20.0),
//             ),
//           ),
//           child: TextField(
//             onChanged: (value) {
//               // productProvi.changeSearch(value);
//             },
//             textAlign: TextAlign.left,
//             controller: searchController,
//             decoration: InputDecoration(
//               contentPadding: const EdgeInsets.only(top: 5),
//               enabledBorder: InputBorder.none,
//               focusedBorder: InputBorder.none,
//               prefixIcon: null,
//               suffixIcon: IconButton(
//                 icon: const Icon(Icons.search),
//                 color: const Color(0xff5d8374),
//                 onPressed: () {
//                   productProvi.changeSearch(searchController.text);
//                 },
//               ),
//               border: InputBorder.none,
//               hintText: 'Search',
//               hintStyle: GoogleFonts.roboto(
//                 fontSize: 18,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 30,
//           child: Divider(
//             color: Colors.black,
//             thickness: 1,
//             endIndent: 20,
//             indent: 20,
//           ),
//         ),
//         productProvi.searchName == ''
//             ? productProvi.categoryId == ''
//                 ? StreamBuilder(
//                     stream: productProvi.productRef.snapshots(),
//                     builder: (BuildContext context,
//                         AsyncSnapshot<QuerySnapshot> snapshot) {
//                       if (snapshot.hasError) {
//                         return const Center(
//                             child: Text('Something went wrong'));
//                       }
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const Center(child: Text('Loading'));
//                       }
//                       return SizedBox(
//                         height: size.height * 0.65,
//                         child: ListView(
//                           shrinkWrap: true,
//                           children: snapshot.data!.docs
//                               .map((DocumentSnapshot document) {
//                             Map<String, dynamic> data =
//                                 document.data()! as Map<String, dynamic>;
//                             return Card(
//                               child: ListTile(
//                                 title: Text(data['name_furniture']),
//                                 subtitle: Row(children: [
//                                   Image(
//                                     image: NetworkImage(data['imageURL'][0]),
//                                     height: 100,
//                                     width: 100,
//                                   ),
//                                   const Gap(10),
//                                   Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text('Price: ${data['price']}'),
//                                       Text('Quantity: ${data['quantity']}'),
//                                       const Gap(10),
//                                       data['description'].length > 10
//                                           ? Text(
//                                               'Description: ${data['description'].substring(0, 8)}...')
//                                           : Text(
//                                               'Description: ${data['description']}'),
//                                     ],
//                                   ),
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     children: [
//                                       IconButton(
//                                         onPressed: () {
//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       const UploadProductScreen()));
//                                         },
//                                         icon: const Icon(Icons.edit),
//                                       ),
//                                       IconButton(
//                                         onPressed: () {
//                                           showDialog(
//                                               context: context,
//                                               builder: (BuildContext _) =>
//                                                   AlertDialog(
//                                                     title: const Text(
//                                                         'Delete Product'),
//                                                     content: const Text(
//                                                         'Are you sure you want to delete this product?'),
//                                                     actions: [
//                                                       TextButton(
//                                                         onPressed: () {
//                                                           productProvi
//                                                               .productRef
//                                                               .doc(document.id)
//                                                               .delete();
//                                                           Navigator.pop(
//                                                               context);
//                                                         },
//                                                         child:
//                                                             const Text('Yes'),
//                                                       ),
//                                                       TextButton(
//                                                         onPressed: () {
//                                                           Navigator.pop(
//                                                               context);
//                                                         },
//                                                         child: const Text('No'),
//                                                       ),
//                                                     ],
//                                                   ));
//                                         },
//                                         icon: const Icon(Icons.delete),
//                                       ),
//                                     ],
//                                   )
//                                 ]),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       );
//                     },
//                   )
//                 : // hieern thi danh sach san pham theo category
//                 StreamBuilder<QuerySnapshot>(
//                     stream: productProvi.productRef.snapshots(),
//                     builder: (BuildContext context,
//                         AsyncSnapshot<QuerySnapshot> snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const Material(
//                           child: Center(
//                             child: CircularProgressIndicator(),
//                           ),
//                         );
//                       }

//                       final result1 = snapshot.data!.docs
//                           .where((DocumentSnapshot document) {
//                         Map<String, dynamic> data =
//                             document.data()! as Map<String, dynamic>;
//                         return data['category_id']
//                             .toLowerCase()
//                             .contains(productProvi.categoryId!.toLowerCase());
//                       }).toList();

//                       return result1.isEmpty
//                           ? const Center(
//                               child: Text('No result found'),
//                             )
//                           : SizedBox(
//                               height: size.height * 0.65,
//                               child: ListView(
//                                 shrinkWrap: true,
//                                 children: result1
//                                     .map((e) => searchModel(
//                                           e,
//                                           context,
//                                         ))
//                                     .toList(),
//                               ),
//                             );
//                     })
//             : StreamBuilder<QuerySnapshot>(
//                 stream: productProvi.productRef.snapshots(),
//                 builder: (BuildContext context,
//                     AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Material(
//                       child: Center(
//                         child: CircularProgressIndicator(),
//                       ),
//                     );
//                   }

//                   final result =
//                       snapshot.data!.docs.where((DocumentSnapshot document) {
//                     Map<String, dynamic> data =
//                         document.data()! as Map<String, dynamic>;
//                     return data['name_furniture']
//                         .toLowerCase()
//                         .contains(productProvi.searchName!.toLowerCase());
//                   }).toList();

//                   return result.isEmpty
//                       ? const Center(
//                           child: Text('No result found'),
//                         )
//                       : SizedBox(
//                           height: size.height * 0.65,
//                           child: ListView(
//                             shrinkWrap: true,
//                             children: result
//                                 .map((e) => searchModel(
//                                       e,
//                                       context,
//                                     ))
//                                 .toList(),
//                           ),
//                         );
//                 }),
//       ])),
//     ));
//   }
// }

// Widget searchModel(dynamic e, BuildContext _) {
//   return InkWell(
//       onTap: () {
//         //ấn giữ vào để chuyển trang chỉnh sửa sản phẩm
//       },
//       child: SizedBox(
//         width: 250,
//         child: Card(
//           child: ListTile(
//             title: Text(e['name_furniture']),
//             subtitle: Row(children: [
//               Image(
//                 image: NetworkImage(e['imageURL'][0]),
//                 height: 100,
//                 width: 100,
//               ),
//               const Gap(10),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Price: ${e['price']}'),
//                   Text('Quantity: ${e['quantity']}'),
//                   const Gap(10),
//                   e['description'].length > 10
//                       ? Text(
//                           'Description: ${e['description'].substring(0, 6)}...')
//                       : Text('Description: ${e['description']}'),
//                 ],
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       Navigator.push(
//                           _,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   const UploadProductScreen()));
//                     },
//                     icon: const Icon(Icons.edit),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       showDialog(
//                           context: _,
//                           builder: (BuildContext _) => AlertDialog(
//                                 title: const Text('Delete Product'),
//                                 content: const Text(
//                                     'Are you sure you want to delete this product?'),
//                                 actions: [
//                                   TextButton(
//                                     onPressed: () {
//                                       FirebaseFirestore.instance
//                                           .collection('furniture')
//                                           .doc(e.id)
//                                           .delete();
//                                       Navigator.pop(_);
//                                     },
//                                     child: const Text('Yes'),
//                                   ),
//                                   TextButton(
//                                     onPressed: () {
//                                       Navigator.pop(_);
//                                     },
//                                     child: const Text('No'),
//                                   ),
//                                 ],
//                               ));
//                     },
//                     icon: const Icon(Icons.delete),
//                   ),
//                 ],
//               )
//             ]),
//           ),
//         ),
//       ));
// }
