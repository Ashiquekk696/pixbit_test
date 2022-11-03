import 'package:equatable/equatable.dart';

abstract class HomeMainEvent extends Equatable {}

class HomeDataEvent extends HomeMainEvent {
  var page;
  HomeDataEvent({this.page});
  List<Object?> get props => [page];
}
