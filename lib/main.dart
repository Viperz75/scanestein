import 'package:flutter/material.dart';
import 'package:scanestein/screens/about.dart';
import 'package:scanestein/screens/generate_barcode.dart';
import 'package:scanestein/screens/generate_qr.dart';
import 'package:scanestein/components/pageButtons.dart';
import 'package:scanestein/screens/image_to_text.dart';
import 'package:scanestein/screens/qr_scan.dart';
import 'package:scanestein/screens/scan_barcode.dart';
import 'package:scanestein/theme/theme_constants.dart';
import 'package:scanestein/theme/theme_manager.dart';

ThemeManager _themeManager = ThemeManager();

void main() {
  runApp(const QR());
}

class QR extends StatefulWidget {
  const QR({Key? key}) : super(key: key);

  @override
  State<QR> createState() => _QRState();
}

class _QRState extends State<QR> {
  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('SCANESTEIN'),
          backgroundColor: _themeManager.themeMode == ThemeMode.light
              ? Color(0xff1186d9)
              : Colors.black,
          centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  pageButtons(
                    image: 'image/scan_qr.png',
                    title: 'Scan QR',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QRScan(),
                      ),
                    ),
                  ),
                  pageButtons(
                    image: 'image/generate_qr.png',
                    title: 'Generate QR',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => generateQR(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  pageButtons(
                      image: 'image/bar_scanner.png',
                      title: 'Scan Barcode',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BarcodeScan(),
                          ),
                        );
                      }),
                  pageButtons(
                    image: 'image/generate_barcode.png',
                    title: 'Generate Barcode',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => generateBarcode(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  pageButtons(
                    image: 'image/image_text.png',
                    title: 'Image to Text',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageToText(),
                      ),
                    ),
                  ),
                  pageButtons(
                      image: _themeManager.themeMode == ThemeMode.light
                          ? 'image/dark_mode.png'
                          : 'image/light_mode.png',
                      title: _themeManager.themeMode == ThemeMode.light
                          ? 'Dark Mode'
                          : 'Light Mode',
                      onPressed: () {
                        if (_themeManager.themeMode == ThemeMode.light) {
                          _themeManager.toggleTheme(true);
                        } else if (_themeManager.themeMode == ThemeMode.dark) {
                          _themeManager.toggleTheme(false);
                        }
                      }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  pageButtons(
                    image: 'image/about_us.png',
                    title: 'About Us',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => About(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
}
