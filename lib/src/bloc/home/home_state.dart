part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable{
  const HomeState();

  @override
  List<Object> get props => [];
}

class StateHomeLoading extends HomeState {}

class StateHomeChangePage extends HomeState {
  final String pageName;
  final String titlePage;

  StateHomeChangePage({this.pageName, this.titlePage});

  @override
  List<Object> get props => [pageName, titlePage];

  @override
  String toString() => 'pageName';
}
