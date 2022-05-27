part of 'new_order_cubit.dart';

abstract class NewOrderState extends Equatable {
  const NewOrderState();
}

class NewOrderInitial extends NewOrderState {
  @override
  List<Object> get props => [];
}

class NewOrderLoaded extends NewOrderState {
  final SalesData salesData;
  const NewOrderLoaded(this.salesData);

  @override
  List<Object> get props => [salesData];
}

class NewRetailerCreated extends NewOrderState {
  final RetailerModel retailerModel;
  const NewRetailerCreated(this.retailerModel);

  @override
  List<Object> get props => [retailerModel];
}
