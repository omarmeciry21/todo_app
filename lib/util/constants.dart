import 'package:flutter/material.dart';

InputDecoration buildInputDecoration(String label) {
  return InputDecoration(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
    labelText: label,
  );
}
