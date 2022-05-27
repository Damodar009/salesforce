import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:salesforce/data/models/RetailerModel.dart';

import '../../../data/models/SalesDataModel.dart';
import '../../../domain/entities/SalesData.dart';
import '../../../domain/usecases/hiveUseCases/hiveUseCases.dart';
import '../../../injectable.dart';
import '../../../utils/hiveConstant.dart';

part 'new_order_state.dart';

class NewOrderCubit extends Cubit<NewOrderState> {
  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
  NewOrderCubit() : super(NewOrderInitial());

  getOrders(SalesData salesDataModel) {
    print("this is running");
    emit(NewOrderLoaded(salesDataModel));
  }

  getRetailers(RetailerModel retailerModel) {
    print("new retailer is created");
    emit(NewRetailerCreated(retailerModel));
  }

  saveSalesDataToHive(SalesData salesdata) async {
    Box box = await Hive.openBox(HiveConstants.salesDataCollection);
    var sucess = useCaseForHiveImpl.saveValuestoHiveBox(box, salesdata);
    sucess.fold(
        (l) => {
              //box.close()
            },
        (r) => {
              // box.close()
            });
  }

  setInitialState() {
    emit(NewOrderInitial());
  }
}
