/*
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'api_client.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController cPassController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ApiClient apiClient = ApiClient();

  login() async {
    String email = "ssinroja@harvices.com";
    String pass = "Shivu@1234";
    Response? res = await apiClient.postRequest("userMST/login/",
       queryParameters: {"password": pass, "system": "PIZZAPORTAL", "userName": email});
    // ignore: unnecessary_null_comparison
    if (res == null) {
      return;
    } else {
      if (res.statusCode == 200) {
        log(res.data.toString());
      } else {
        log("something went wrong here --->");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 48),
                ),
                const SizedBox(
                  height: 20,
                ),

                /// name
                TextFormField(
                  controller: nameController,
                  validator: (name) {
                    return name!.isEmpty ? "name is required" : null;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "name"),
                ),
                const SizedBox(
                  height: 20,
                ),

                /// email
                TextFormField(
                  controller: emailController,
                  validator: (email) {
                    return email!.isEmpty ? "email is required" : null;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "email"),
                ),
                const SizedBox(
                  height: 20,
                ),

                /// pass
                TextFormField(
                  controller: passController,
                  validator: (pass) {
                    return pass!.isEmpty ? "pass is required" : null;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "pass"),
                ),
                const SizedBox(
                  height: 20,
                ),

                /// confirm pass
                TextFormField(
                  controller: cPassController,
                  validator: (pass) {
                    return pass!.isEmpty && pass == passController.text
                        ? "password are not match"
                        : null;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "confirm password"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: phoneController,
                  validator: (pass) {
                    return pass!.isEmpty && pass == passController.text
                        ? "phone number is required"
                        : null;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "phone nummber"),
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                    color: Colors.blue,
                    onPressed: () {
                      login();
                    },
                    child: const Text("Sign Up")),
                const SizedBox(
                  height: 20,
                ),
                */
/* Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("don't have account ? "),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                          child: Text(
                            " Sign Up",
                            style: TextStyle(color: Colors.blue),
                          ))
                    ],
                  ),
                )*//*

              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/
