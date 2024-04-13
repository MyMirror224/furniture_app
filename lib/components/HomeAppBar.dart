import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: const Row(
        children: [
          // Icon(
          //   Icons.sort,
          //   size: 30,
          //   color: Color(0xFF4C53A5),
          // ),
          Padding(padding: EdgeInsets.only(left: 1),child:Text("Cart",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          ) ,)
        ],
      ),
    );
  }
}