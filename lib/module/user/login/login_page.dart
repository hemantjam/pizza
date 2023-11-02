import 'package:flutter/material.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("login"),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        /* child: Consumer<LoginProvider>(
          builder: (context, LoginProvider provider, child) {
            return Form(
              key: provider.formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "login",
                      style: TextStyle(fontSize: 48),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(

                      focusNode: provider.emailFocus,
                      controller: provider.emailController,
                      validator: (email) {
                        const pattern =
                            r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
                        final regExp = RegExp(pattern);
                        if (email == null) return "Email cannot be empty";
                        return regExp.hasMatch(email)
                            ? null
                            : "Please enter a valid email";
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Email ID",
                      ),
                      onFieldSubmitted: (value) {
                        provider.passFocus.requestFocus();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      focusNode: provider.passFocus,
                      controller: provider.passController,
                      validator: (pass) {
                        const pattern =
                            r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@#$!%^&*])[A-Za-z\d@#$!%^&*]{8,}$';
                        final regExp = RegExp(pattern);
                        if (pass == null) return "Password cannot be empty";
                        return regExp.hasMatch(pass)
                            ? null
                            : "Please enter a valid password";
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: "pass"),
                      onFieldSubmitted: (value) {
                        provider.login();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                        color: Colors.blue,
                        onPressed: provider.login,
                        child: const Text("login")),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("don't have account ? "),
                          GestureDetector(
                              onTap: () {
                                */ /* Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUp()));*/ /*
                              },
                              child: const Text(
                                " Sign Up",
                                style: TextStyle(color: Colors.blue),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),*/
      ),
    );
  }
}
