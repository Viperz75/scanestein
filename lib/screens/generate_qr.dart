import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:scanestein/constants.dart';
import 'package:scanestein/components/bottom_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:scanestein/components/generateQR_options.dart';


void main() {
  runApp(MaterialApp(home: generateQR()));
}

class generateQR extends StatefulWidget {
  @override
  State<generateQR> createState() => _generateQRState();
}

class _generateQRState extends State<generateQR> {
  final qrKey = GlobalKey();
  late String qrData;

  List items = ['Text', 'E-mail', 'Link', 'Phone'];
  int chipValue = 0;

  Color color = Colors.lightBlueAccent;

  int tapCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate QR'),
        backgroundColor: Color(0xff1186d9),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 200.0,
            child: Padding(
              padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                child: TextField(
                  decoration: kGetUserDataDec,
                  style: kTextFieldText,
                  maxLines: null,
                  onChanged: (value) {
                    qrData = value;
                  },
                ),
              ),
            ),
          ),
          Expanded(
              child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                optionalOptions(
                    label: 'Pick a color',
                    onPressed: () => pickColor(context),
                    icon: FontAwesomeIcons.palette),
              ],
            ),
          )),
          Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    direction: Axis.horizontal,
                    children: List.generate(
                      4,
                      (int index) {
                        return Container(
                          margin: const EdgeInsets.all(3),
                          child: ChoiceChip(
                            elevation: 10,
                            padding: EdgeInsets.all(12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            backgroundColor: Color(0xff0080f7),
                            disabledColor: Colors.black,
                            label: Text(
                              '${items[index]}',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.0),
                            ),
                            selected: chipValue == index,
                            onSelected: ((bool selected) {
                              setState(() {
                                tapCount++;
                                print(tapCount);
                                if (tapCount == 5) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialog(
                                          title: Text('SURPRISE 🎊'),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          content: Text(
                                              'WAH 😳 You pressed to hard. I am hurt 🤕\n\nWanna see some awesome tools and play games?\n\nVisit our website: \nhttps://thepuzzles.eu.org\n\nMail us at: brothersco@thepuzzles.eu.org'),
                                        );
                                      });
                                }
                                if (selected) {
                                  chipValue = index;
                                }
                              });
                            }),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  print(qrData);
                  showMaterialModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    context: context,
                    builder: (BuildContext context) =>
                        bottom_dialog(qrData: qrData, color: color),
                  );
                },
                minWidth: double.infinity,
                height: 50.0,
                color: Color(0xff0080f7),
                child: Text(
                  'GET YOUR QR',
                  style: kButtonText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildColorPicker() => ColorPicker(
        pickerColor: color,
        onColorChanged: (color) => this.color = color,
        colorPickerWidth: 300,
      );

  void pickColor(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Pick a color'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildColorPicker(),
              TextButton(
                child: Text('Select', style: TextStyle(fontSize: 15.0)),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      );
}
