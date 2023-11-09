import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget loader(bool loading) {
  return Visibility(
    visible: loading,
    child: Center(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20)),
        child: const Padding(
          padding: EdgeInsets.all(40.0),
          child: CupertinoActivityIndicator(
            color: Colors.orange,
            radius: 30,
          ),
        ),
      ),
    ),
  );
}