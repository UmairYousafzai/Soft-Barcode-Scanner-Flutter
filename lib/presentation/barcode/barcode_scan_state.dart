import 'package:soft_barcode_scanner/data/dataproviders/network/models/product.dart';

class BarcodeScanState {
  final BarcodeScanStatus scanStatus;
  final String barcode;

  BarcodeScanState({
    this.barcode = "",
    this.scanStatus = const BarcodeScanInitialStatus(),
  });

  BarcodeScanState copyWith({
    String? barcode,
    BarcodeScanStatus? barcodeScanStatus,
  }) {
    return BarcodeScanState(
      barcode: barcode ?? this.barcode,
      scanStatus: barcodeScanStatus ?? scanStatus,
    );
  }
}

abstract class BarcodeScanStatus {
  const BarcodeScanStatus();
}

class BarcodeScanInitialStatus extends BarcodeScanStatus {
  const BarcodeScanInitialStatus();
}

class BarcodeScanSuccessStatus extends BarcodeScanStatus {
  final String barcode;

  BarcodeScanSuccessStatus({required this.barcode});
}

class BarcodeScanApiSuccessStatus extends BarcodeScanStatus {
  final Product? product;

  BarcodeScanApiSuccessStatus({required this.product});
}

class BarcodeScanFailedStatus extends BarcodeScanStatus {
  final String errorMessage;

  BarcodeScanFailedStatus({required this.errorMessage});
}
