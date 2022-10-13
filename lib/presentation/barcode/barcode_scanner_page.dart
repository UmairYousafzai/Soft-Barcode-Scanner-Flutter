import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_barcode_scanner/presentation/barcode/barcode_bloc.dart';
import 'package:soft_barcode_scanner/presentation/barcode/barcode_scan_state.dart';
import 'package:soft_barcode_scanner/utils/extensions.dart';

import 'barcode_scan_event.dart';

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

class BarcodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Barcode Scanner",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: "#caab50".toColor(),
      ),
      backgroundColor: "2d2d2d".toColor(),
      body: barcodeCameraSection(),
    );
  }
}

Widget barcodeCameraSection() {
  return BlocBuilder<BarcodeScanBloc, BarcodeScanState>(
      builder: (context, state) {
    return Center(
      child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            productDataSection(),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: "#caab50".toColor()),
                onPressed: () => {
                      context
                          .read<BarcodeScanBloc>()
                          .add(StartScanBarcodeEvent())
                    },
                child: const Text('Start scan')),
          ]),
    );
  });
}

Widget productDataSection() {
  return BlocBuilder<BarcodeScanBloc, BarcodeScanState>(
      builder: (context, state) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "UAN",
            style: TextStyle(
              color: "#caab50".toColor(),
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
          Text(
            state.scanStatus is BarcodeScanApiSuccessStatus
                ? (state.scanStatus as BarcodeScanApiSuccessStatus).product!.uan
                : "",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            ),
          ),
          Divider(
            color: "#caab50".toColor(),
          ),
          Text(
            "Name",
            style: TextStyle(
              color: "#caab50".toColor(),
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
          Text(
            state.scanStatus is BarcodeScanApiSuccessStatus
                ? (state.scanStatus as BarcodeScanApiSuccessStatus)
                    .product!
                    .description
                : "",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            ),
          ),
          Divider(
            color: "#caab50".toColor(),
          ),
          Text(
            "Price",
            style: TextStyle(
              color: "#caab50".toColor(),
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
          Text(
            state.scanStatus is BarcodeScanApiSuccessStatus
                ? (state.scanStatus as BarcodeScanApiSuccessStatus)
                    .product!
                    .unitRetail
                    .toString()
                : "",
            style: const TextStyle(
              color: Colors.red,
              fontSize: 25.0,
            ),
          ),
          Divider(
            color: "#caab50".toColor(),
          ),
        ],
      ),
    );
  });
}

// class _MyAppState extends State<MyApp> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//             appBar: AppBar(title: const Text('Barcode scan')),
//             body: Builder(builder: (BuildContext context) {
//               return Container(
//                   alignment: Alignment.center,
//                   child: Flex(
//                       direction: Axis.vertical,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         ElevatedButton(
//                             onPressed: () => scanBarcodeNormal(),
//                             child: Text('Start barcode scan')),
//                         ElevatedButton(
//                             onPressed: () => scanQR(),
//                             child: Text('Start QR scan')),
//                         ElevatedButton(
//                             onPressed: () => startBarcodeScanStream(),
//                             child: Text('Start barcode scan stream')),
//                         Text('Scan result : $_scanBarcode\n',
//                             style: TextStyle(fontSize: 20))
//                       ]));
//             })));
//   }
// }
