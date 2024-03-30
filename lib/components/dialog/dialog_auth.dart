import 'package:flutter/foundation.dart';
import 'package:furniture_app/components/dialog/dialog_model.dart';



@immutable
class AuthDialog extends AlertDialogModel<bool> {
  const AuthDialog({
    required String errorMessage,
  }) : super(
          title: 'Error',
          message: errorMessage,
          buttons: const {
            'Ok': true,
          },
        );
}
