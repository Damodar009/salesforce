import 'package:hive/hive.dart';
import 'package:salesforce/injectable.dart';
import 'package:salesforce/utils/hiveConstant.dart';
import '../../../domain/usecases/hiveUseCases/hiveUseCases.dart';

class RerturnAndSale {
  int? _returned;
  String? _product;
  getReturn() {
    return _returned;
  }

  getProduct() {
    return _product;
  }

  setReturn(int returned) {
    _returned = returned;
  }

  setProduct(String product) {
    _product = product;
  }
}

class OrderAvailability {
  int? stock;
  bool? availability;
  String? product;

  getStock() {
    return stock;
  }

  getavailability() {
    return availability;
  }

  String? getproduct() {
    return product;
  }

  setStock(int? stock) {
    this.stock = stock;
  }

  setavailability(bool? availability) {
    this.availability = availability;
  }

  setproduct(String? product) {
    this.product = product;
  }
}

var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();

Future<List<dynamic>> getSalesDataFromHive() async {
  List<dynamic> salesData = [];
  Box box = await Hive.openBox(HiveConstants.salesDataCollection);
  var success = useCaseForHiveImpl.getAllValuesFromHiveBox(box);
  success.fold((l) => {box.close(), print("retreiving file get failed ")},
      (r) => {salesData = r, box.close()});

  return salesData;
}
