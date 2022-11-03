import 'package:equatable/equatable.dart';
import 'package:pixbit_test/models/designations_model.dart';
import 'package:pixbit_test/models/employees_model.dart';

abstract class DesignationsMainState extends Equatable {}

class DesignationsLoadingState extends DesignationsMainState {
  List<Object?> get props => [];
}

class DesignationsLoadedState extends DesignationsMainState {
DesignationsLoadedState({this.designationsModel});
  List<DesignationsModel>? designationsModel=[];
  List<Object?> get props => [ designationsModel];
}

class DesignationsErrorState extends DesignationsMainState {
 DesignationsErrorState({this.message});
  var message;
  List<Object?> get props => [message];
}
