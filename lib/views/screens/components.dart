import 'package:flutter/material.dart';

Widget backgroundImage() {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("lib/assets/6.jpg"),
        fit: BoxFit.cover,
      ),
    ),
    child: Container(
      color: Colors.black.withOpacity(0.3),
    ),
  );
}
