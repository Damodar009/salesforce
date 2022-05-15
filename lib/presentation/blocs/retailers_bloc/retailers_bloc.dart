import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salesforce/data/models/RetailerPojo.dart';
import 'package:salesforce/injectable.dart';

import '../../../domain/usecases/usecasesForRemoteSource.dart';

part 'retailers_event.dart';
part 'retailers_state.dart';

class RetailersBloc extends Bloc<RetailersEvent, RetailersState> {

  var useCaseForRemoteSourceimpl = getIt<UseCaseForRemoteSourceimpl>();
  
  RetailersBloc() : super(RetailersInitial()) {
    on<RetailersEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SaveAllRetailersEvent> ((event, emit) async{
      emit(SaveAllRetailersLoadingState());

      // final isSuccessful = await useCaseForRemoteSourceimpl.saveAllRetailer(listOfRetailers);
    },);
  }
}
