import 'package:hive/hive.dart';
import 'package:salesforce/domain/entities/sales.dart';
import 'package:salesforce/injectable.dart';
import 'package:salesforce/utils/hiveConstant.dart';
import '../../../domain/usecases/hiveUseCases/hiveUseCases.dart';

class ReturnAndSale {
  int? _returned;
  String? _product;
  bool? _orderStatus;
  String? _requestedDate;

  getReturn() {
    return _returned;
  }

  getProduct() {
    return _product;
  }

  getOrderStatus() {
    return _orderStatus;
  }

  getRequestedDate() {
    return _requestedDate;
  }

  setReturn(int returned) {
    _returned = returned;
  }

  setProduct(String product) {
    _product = product;
  }

  setOrderStatus(bool orderStatus) {
    _orderStatus = orderStatus;
  }

  setRequestedDate(String date) {
    _requestedDate = date;
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
  success.fold(
      (l) => {box.close(), print("")}, (r) => {salesData = r, box.close()});

  return salesData;
}

saveOrderDataTOHive(List<Sales> orderData) async {
  Box box = await Hive.openBox(HiveConstants.requestOrders);
  useCaseForHiveImpl.saveValuestoHiveBox(box, orderData).fold(
      (l) => {print("saving orderData to hive is failed")},
      (r) => {print("saving orderData to hive is passed")});
}

Future<List<Sales>> getOrderDataFromHive() async {
  List<Sales> orderData = [];
  Box box = await Hive.openBox(HiveConstants.requestOrders);
  useCaseForHiveImpl.getAllValuesFromHiveBox(box).fold(
      (l) => {print("getting  orderData from hive is failed")},
      (r) => {
            for (int i = 0; i < r.length; i++) {orderData.add(r[i])},
            print("getting orderData to hive is passed")
          });
  return orderData;
}
