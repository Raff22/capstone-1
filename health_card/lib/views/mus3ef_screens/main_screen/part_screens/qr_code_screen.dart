import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/database/supa_get_delete/supa_get_delete.dart';
import 'package:health_card/global/globals.dart';
import 'package:health_card/models/patient_model.dart';
import 'package:health_card/views/mus3ef_screens/main_screen/nav_bar.dart';

class BarCodeScanner extends StatefulWidget {
  const BarCodeScanner({Key? key}) : super(key: key);

  @override
  State<BarCodeScanner> createState() => _BarCodeScannerState();
}

class _BarCodeScannerState extends State<BarCodeScanner> {
  TextEditingController idController = TextEditingController();
  bool iserror = false;
  Future<void> scanBarcode() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Cancel",
        true,
        ScanMode.QR,
      );
      if (!mounted) return;

      if (barcodeScanRes != '-1') {
        setState(() {
          idController.text = barcodeScanRes;
          iserror = false;
        });
        fetchAndNavigate();
      }
    } catch (e) {
      setState(() {
        iserror = true;
      });
    }
  }

  Future<void> fetchAndNavigate() async {
    try {
      final Patient myPatient =
          await SupaGetAndDelete().getPatientById(idController.text);
      globalCurrentPatient = myPatient;
      print(globalCurrentPatient!.fullName!);
      if (myPatient.id != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NavBar(idText: idController.text),
          ),
        );
      }
    } catch (error) {
      print("Error: $error");
      setState(() {
        iserror = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: Column(
          children: [
            const SizedBox(height: 100),
            SizedBox(
                width: 250,
                height: 250,
                child: Image.asset("assets/images/qrimage.png",
                    fit: BoxFit.cover)),
            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
                try {
                  scanBarcode();

                  print(globalCurrentPatient!.fullName!);
                  if (globalCurrentPatient!.fullName != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavBar(idText: idController.text),
                      ),
                    );
                  }
                } catch (error) {
                  print(
                      "here----------------------is-----------------------the---------------------------error${error}");
                  setState(() {
                    iserror = true;
                  });
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        Future.delayed(const Duration(milliseconds: 500), () {
                          Navigator.of(context).pop(true);
                        });

                        return const Center(
                            child: CircularProgressIndicator(color: red2));
                      });
                }
              },
              child: Container(
                width: 250,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 160, 9, 9)),
                child: const Center(
                    child: Text(
                  "Scan QR code",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(30),
              child: TextField(
                controller: idController,
                decoration: const InputDecoration(
                  labelText: 'Enter ID',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            InkWell(
              onTap: () async {
                try {
                  final Patient myPatient = await SupaGetAndDelete()
                      .getPatientById(idController.text);
                  globalCurrentPatient = myPatient;
                  print(globalCurrentPatient!.fullName!);
                  if (myPatient.id != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavBar(idText: idController.text),
                      ),
                    );
                  }
                } catch (error) {
                  setState(() {
                    iserror = true;
                  });
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        Future.delayed(const Duration(milliseconds: 500), () {
                          Navigator.of(context).pop(true);
                        });

                        return const Center(
                            child: CircularProgressIndicator(color: red2));
                      });
                }
              },
              child: Container(
                width: 250,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 160, 9, 9)),
                child: const Center(
                    child: Text(
                  "Search by ID",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            if (iserror)
              const Text(
                'Invalid ID',
                style: TextStyle(color: Colors.red, fontSize: 25),
              )
          ],
        ));
  }
}
