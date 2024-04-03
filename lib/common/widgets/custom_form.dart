import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  final String text1;
  final String text2;
  const CustomFormField({Key? key, required this.text1, required this.text2});

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: _controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          hintText: '${widget.text1} ${widget.text2}', // Display text1 and text2 as hints
        ),
      ),
    );
  }
}
