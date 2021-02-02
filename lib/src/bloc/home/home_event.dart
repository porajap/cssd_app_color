part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable{
  const HomeEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class EventHomeChangePage extends HomeEvent{
  final String pageName;

  EventHomeChangePage({this.pageName});

  @override
  // TODO: implement props
  List<Object> get props => [];

  @override
  String toString() => 'pageName';
}
