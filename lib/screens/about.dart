import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scanestein/theme/theme_manager.dart';
import 'package:scanestein/constants.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Center(
            child: Container(
              child: Image.asset(
                'image/logo.png',
              ),
            ),
          ),
          Center(
            child: Text(
              'SCANESTEIN',
              style: kBrandName,
            ),
          ),
          SizedBox(height: 10),
          aboutCard(image: 'image/profile.png', text: 'Niaz Mahmud Akash'),
        ],
      ),
    );
  }
}

class aboutCard extends StatelessWidget {
  aboutCard({this.image, required this.text});

  final image;
  final text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Image.asset(
              image,
              width: 100,
            ),
            Text(text, style: kName),
          ],
        ),
      ),
    );
  }
}
