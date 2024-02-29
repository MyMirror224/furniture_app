import 'package:flutter/material.dart';
import 'package:furniture_app/pages/Admin/admin_product.dart';
import 'package:furniture_app/pages/Admin/catelory.dart';
import 'package:furniture_app/state/auth/auth_state_provider.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminScreen extends ConsumerWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adProvi = ref.watch(adminProvider);

    var container;
    if (adProvi.currentPage == DrawerSections.product) {
      container = const ProductScreen();
    } else if (adProvi.currentPage == DrawerSections.catelory) {
      container = const CateloryScreen();
    }
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DrawerHeader(
                  child: (Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/user.jpg'),
                      ),
                      const Gap(10),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "Admin",
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              fontSize: 20),
                        ),
                      ),
                    ],
                  )),
                ),
                adProvi.myDrawerList(context, ref),
              ],
            ),
            //logout
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    title: Text("Logout",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    onTap: () => ref.read(authStateProvider.notifier).logOut(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: adProvi.changeAppBar(adProvi.currentPage),
      body: container,
    );
  }
}

enum DrawerSections { product, catelory, promotion, user, message }

final adminProvider = ChangeNotifierProvider((ref) => AdminProvider());

class AdminProvider extends ChangeNotifier {
  var currentPage = DrawerSections.product;

  void changePage(int id) {
    if (id == 1) {
      currentPage = DrawerSections.product;
    } else if (id == 2) {
      currentPage = DrawerSections.catelory;
    }

    notifyListeners();
  }

  Widget myDrawerList(BuildContext _, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Product", Icons.dashboard_outlined,
              currentPage == DrawerSections.product ? true : false, _, ref),
          menuItem(2, "Catelory", Icons.people_alt_outlined,
              currentPage == DrawerSections.catelory ? true : false, _, ref),
        ],
      ),
    );
  }

  changeAppBar(currernPage) {
    if (currernPage == DrawerSections.product) {
      return AppBar(
        title: const Text('Product Management'),
      );
    } else if (currernPage == DrawerSections.catelory) {
      return AppBar(
        title: const Text('Catelory Management'),
      );
    }
  }

  Widget menuItem(int id, String title, IconData icon, bool selected,
      BuildContext _, WidgetRef ref) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          ref.read(adminProvider.notifier).changePage(id);
          notifyListeners();
          Navigator.pop(_);
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
