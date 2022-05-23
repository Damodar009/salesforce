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

class Availability {
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
