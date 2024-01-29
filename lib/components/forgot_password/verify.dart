import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerifyCode extends StatefulWidget {
  const VerifyCode({Key? key}) : super(key: key);

  @override
  State<VerifyCode> createState() => _VerifyCodeWidgetState();
}

class _VerifyCodeWidgetState extends State<VerifyCode> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (var i = 0; i < 4; i++) _buildCodeField(i),
      ],
    );
  }

  Widget _buildCodeField(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Form(
          child: Row(
        children: [
          SizedBox(
            height: 68,
            width: 64,
            child: TextFormField(
              // sử dụng textformfield thay vì textfield để có thể validate dữ liệu ngay trong form
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
              },

              style: Theme.of(context).textTheme.headline6,

              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
          ),
        ],
      )),
    );
  }
}
