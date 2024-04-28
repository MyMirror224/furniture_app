import 'package:flutter/material.dart';

class adressss extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child:  Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
            Icons.chevron_left,
            size: 30,
            color: Color.fromARGB(255, 88, 145, 145),
          ),
          
          ),
          Padding(padding: EdgeInsets.only(left: 1),child:Text("Address",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          ) ,),
        ],
      ),
    );
  }
}