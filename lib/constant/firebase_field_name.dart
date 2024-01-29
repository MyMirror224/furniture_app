import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseFieldName {
  static const userId = 'uid';
  static const birthday = 'birthday';
  static const displayName = 'display_name';
  static const email = 'email';
  static const password ='password';
  static const userType = 'user_type';
  static const userImage ='user_image';
  static const address ='address';
  static const phoneNumber='phone_number';
  const FirebaseFieldName._();
}
