import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }

  //https://shapemaker.web.app/#/
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height); // điểm bắt đầu của con sóng (x,y)
    var firstStart =
        Offset(size.width / 5, size.height); // điểm bắt đầu của con sóng (x,y)

    var firstEnd = Offset(size.width / 2.25,
        size.height - 50); // điểm kết thúc của con sóng (x,y)

    path.quadraticBezierTo(
        //thực hiện đường cong của con sóng với điểm bắt đầu và kết thúc
        firstStart.dx,
        firstStart.dy,
        firstEnd.dx,
        firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    var secondEnd = Offset(size.width, size.height - 10);

    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(size.width, 0.0); // điểm cuối cùng của con sóng (x,y)

    path.close();
    return path;
  }
}
