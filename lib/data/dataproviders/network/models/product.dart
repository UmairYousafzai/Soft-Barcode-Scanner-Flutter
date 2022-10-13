class Product {


  Product(
      {required this.description, required this.uan, required this.unitRetail});

  Product.fromJson(dynamic json) {
    description = json["Description"];
    uan = json["Uan"];
    unitRetail = json["UnitRetail"];
  }

  String description = "";
  String uan = "";
  double unitRetail = 0.0;
}
