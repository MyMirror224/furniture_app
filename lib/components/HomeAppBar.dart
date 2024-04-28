import 'package:flutter/material.dart';
import 'package:furniture_app/pages/product_detail_page.dart';
import 'package:gap/gap.dart';

class HomeAppBar extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return  Row(
      children: [
        Gap(20),
        ButtonBackIos(),
      ],
    );
  }
}