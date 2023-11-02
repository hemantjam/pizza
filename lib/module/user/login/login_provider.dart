import 'package:flutter/cupertino.dart';

import '../../../api/api_services.dart';


class LoginProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passFocus = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ApiServices apiClient = ApiServices();

  login() async {}
}
