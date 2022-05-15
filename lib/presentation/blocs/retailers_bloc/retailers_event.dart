part of 'retailers_bloc.dart';

abstract class RetailersEvent extends Equatable {
  const RetailersEvent();

  @override
  List<Object> get props => [];
}

class SaveAllRetailersEvent extends RetailersEvent {}
