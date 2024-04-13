import 'package:flutter/material.dart';

class RoundedIconContainer extends StatelessWidget {
  final IconData icon;
  final String label;

  const RoundedIconContainer({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color:  const Color(0xff193d3d),
          width: 2,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 10,
            child: Icon(
              icon,
              size: 40,
              color:  const Color(0xff193d3d),
            ),
          ),
          Positioned(
            right: 10,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color:  const Color(0xff193d3d),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}