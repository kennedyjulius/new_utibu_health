import 'package:flutter/material.dart';



class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  //final Color color;
  final Color iconColor;
  const IconAndTextWidget({super.key, 
  required this.icon, 
  required this.text, 
  //required this.color, 
  required this.iconColor
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(icon, color: iconColor,), 
        SizedBox(width: 15,),
        Text(text, style: TextStyle(
          fontWeight: FontWeight.bold, 
          color: Color(0xFF89dad0), fontSize: 18
          ),)
      ],
    );
  }
}
