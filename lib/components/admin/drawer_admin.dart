import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                    const Gap(20),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Admin",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 20),
                      ),
                    ),
                  ],
                )),
              ),
              // ListTile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: Text(
                    "H O M E",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  onTap: () {
                    //tắt drawer
                    Navigator.pop(context);
                  },
                ),
              ),
              //setting
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: Text("S E T T I N G",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary)),
                  onTap: () {},
                ),
              ),
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
                  title: Text("L O G O U T",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary)),
                  onTap: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
