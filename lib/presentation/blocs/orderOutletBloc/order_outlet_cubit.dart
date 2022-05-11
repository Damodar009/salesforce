import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'order_outlet_state.dart';

class OrderOutletCubit extends Cubit<OrderOutletState> {
  OrderOutletCubit() : super(OrderOutletInitial());
}
