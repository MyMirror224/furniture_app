import 'package:flutter/material.dart';
import 'package:furniture_app/state/catelory/catelory_storage.dart';

import 'package:furniture_app/state/user_info/backend/user_info_storage.dart';



import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainView extends ConsumerWidget {
  const MainView({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Center(
            child: TextButton(
      onPressed: () async {
        final result = await CategoriesAPI.getCatelory();
        
      } ,
      child: const Text("Sign out"),
    )));
  }
}
