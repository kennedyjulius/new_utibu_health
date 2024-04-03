// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';

class CustomFormField2 extends StatefulWidget {
  final String text1;
  final String labelText; // New custom label text
  const CustomFormField2({
    Key? key,
    required this.text1,
    required this.labelText, // Pass labelText parameter
  });

  @override
  State<CustomFormField2> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField2> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        
        controller: _controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          labelText: widget.labelText, // Set the custom label text
          suffixIcon: Icon(Icons.clear),
          prefixIcon: Icon(Icons.search), // Add suffix dropdown icon
          hintText: '${widget.text1}', // Display text1 as hint
        ),
      ),
    );
  }
}
