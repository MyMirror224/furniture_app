import 'package:flutter/material.dart';
import 'package:furniture_app/components/admin/drawer_admin.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminProduct extends ConsumerWidget {
  const AdminProduct({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      drawer: MyDrawer(),
      body: Center(
        child: Text("Admin Product"),
      ),
    );
  }
}
