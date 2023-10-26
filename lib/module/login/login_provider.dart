import 'package:flutter/cupertino.dart';

import '../../api/api.dart';
import '../../api/api_response.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final FocusNode emailFocus=FocusNode();
  final FocusNode passFocus=FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ApiClient apiClient = ApiClient();

  login() async {
    String email = "ssinroja@harvices.com";
    String pass = "Shivu@1234";
    ApiResponse<dynamic>? res = await apiClient.postRequest("userMST/login/",
        queryParameters: {
          "password": pass,
          "system": "PIZZAPORTAL",
          "userName": email
        });
  }
}
