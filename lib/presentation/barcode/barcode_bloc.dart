import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_barcode_scanner/data/dataproviders/repositories/data_repository.dart';
import 'package:soft_barcode_scanner/presentation/barcode/barcode_scan_state.dart';
import 'package:soft_barcode_scanner/utils/form_submission_status.dart';

import 'barcode_scan_event.dart';

class BarcodeScanBloc extends Bloc<BarcodeScanEvent, BarcodeScanState> {
  DataRepository dataRepository;

  BarcodeScanBloc({required this.dataRepository}) : super(BarcodeScanState()) {
    on<StartScanBarcodeEvent>(
        (event, emit) => {scanBarcodeNormal(event, emit)});
  }

  Future<void> scanBarcodeNormal(
    StartScanBarcodeEvent event,
    Emitter<BarcodeScanState> emitter,
  ) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      emit(
        state.copyWith(
            barcode: barcodeScanRes,
            barcodeScanStatus:
                BarcodeScanSuccessStatus(barcode: barcodeScanRes)),
      );
      // fetchProduct(barcodeScanRes, emitter);
      if (kDebugMode) {
        print(barcodeScanRes);
      }
    } catch (e) {
      emit(
        state.copyWith(
            barcode: '',
            barcodeScanStatus:
                BarcodeScanFailedStatus(errorMessage: e.toString())),
      );
    }
  }

  void fetchProduct(
      String barcodeScanRes, Emitter<BarcodeScanState> emitter) async {
    try {
      var result = await dataRepository.fetchProduct(barcodeScanRes);
      if (result.code == 200) {
        emit(state.copyWith(
          barcode: barcodeScanRes,
          barcodeScanStatus: BarcodeScanApiSuccessStatus(product: result.data),
        ));
      } else {
        emit(
          state.copyWith(
            barcode: barcodeScanRes,
            barcodeScanStatus: BarcodeScanFailedStatus(
                errorMessage: "${result.message}, Code: ${result.code}"),
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          barcode: barcodeScanRes,
          barcodeScanStatus:
              BarcodeScanFailedStatus(errorMessage: e.toString()),
        ),
      );
    }
  }
}
