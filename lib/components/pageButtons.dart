import 'package:flutter/material.dart';
import 'package:scanestein/constants.dart';

class pageButtons extends StatelessWidget {
  pageButtons({required this.image, required this.title, required this.onPressed});


  final image;
  final title;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 8,
          child: InkWell(
            onTap: onPressed,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset(image),
                ), // <-- Icon
                Padding(
                  padding: EdgeInsets.only(bottom: 25.0),
                  child: Text(
                    title,
                    style: kHomeButtonTextButton,
                  ),
                ), // <-- Text
              ],
            ),
          ),
        ),
      ),
    );
  }
}
