part of 'retailers_bloc.dart';

abstract class RetailersState extends Equatable {
  const RetailersState();

  @override
  List<Object> get props => [];
}

class RetailersInitial extends RetailersState {}

class SaveAllRetailersLoadingState extends RetailersState {}

class SaveAllRetailersLoadedState extends RetailersState {}

class SaveAllRetailersFailedState extends RetailersState {}
