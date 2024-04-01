// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:furniture_app/components/admin/button_filed.dart';
// import 'package:furniture_app/pages/Admin/admin_product.dart';
// import 'package:furniture_app/pages/Admin/category.dart';
// import 'package:furniture_app/state/auth/auth_state_provider.dart';
// import 'package:gap/gap.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// class MyDrawer extends ConsumerWidget {
//   const MyDrawer({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Drawer(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       child: Column(
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               DrawerHeader(
//                 child: (Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const CircleAvatar(
//                       radius: 50,
//                       backgroundImage: AssetImage('assets/images/user.jpg'),
//                     ),
//                     const Gap(20),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8.0),
//                       child: Text(
//                         "Admin",
//                         style: TextStyle(
//                             color: Theme.of(context).colorScheme.inversePrimary,
//                             fontSize: 20),
//                       ),
//                     ),
//                   ],
//                 )),
//               ),
//               // ListTile
//               TitleField(
//                   icon: const Icon(Icons.home_filled),
//                   textField: "Home ",
//                   onTap: () {}),
//               TitleField(
//                   icon: const Icon(FontAwesomeIcons.cartShopping),
//                   textField: "Products ",
//                   onTap: () {
//                     Navigator.pop(context);
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const ProductScreen()));
//                   }),
//               TitleField(
//                   icon: const Icon(Icons.class_rounded),
//                   textField: "Catorgories ",
//                   onTap: () {
//                     Navigator.pop(context);
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const CategoryScreen()));
//                   }),
//             ],
//           ),
//           //logout
//           Expanded(
//             child: Align(
//               alignment: Alignment.bottomCenter,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 25.0),
//                 child: ListTile(
//                   leading: Icon(
//                     Icons.logout,
//                     color: Theme.of(context).colorScheme.inversePrimary,
//                   ),
//                   title: Text("Logout",
//                       style: TextStyle(
//                           color: Theme.of(context).colorScheme.inversePrimary,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold)),
//                   onTap: () => ref.read(authStateProvider.notifier).logOut(),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
