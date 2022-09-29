import 'package:flutter/material.dart';
import 'package:scanestein/components/barcode_bottom_dialog.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:scanestein/constants.dart';

class generateBarcode extends StatefulWidget {
  const generateBarcode({Key? key}) : super(key: key);

  @override
  State<generateBarcode> createState() => _generateBarcodeState();
}

class _generateBarcodeState extends State<generateBarcode> {
  String data = 'Hello, hope you love our app!';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate Barcode'),
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
                elevation: 5.0,
                child: TextField(
                  decoration: kGetUserDataDec,
                  style: kTextFieldText,
                  maxLines: null,
                  onChanged: (value) {
                    data = value;
                  },
                ),
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
                  showMaterialModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    context: context,
                    builder: (BuildContext context) => BarcodeBottomDialog(data: data),
                  );
                },
                minWidth: double.infinity,
                height: 50.0,
                color: Color(0xff0080f7),
                child: Text(
                  'GET YOUR BARCODE',
                  style: kButtonText,
                ),
              ),
            ),
          ),
        ],
      ),
    );;
  }
}
