import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeBloc() : super(StateHomeLoading());

  HomeState get initialState => StateHomeLoading();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    switch(event.runtimeType){
      case EventHomeChangePage:
        yield* _mapEventHomeChangePage(event);
        break;
    }
  }

  Stream<HomeState> _mapEventHomeChangePage(EventHomeChangePage event) async*{
    String _titlePage;
    switch(event.pageName.toUpperCase()){
      case "DASHBOARD":
        _titlePage = "Dash Board";
        break;
      case "REQUEST":
        _titlePage = "Create Request";
        break;
      case "RETURN":
        _titlePage = "Return Confirm";
        break;
      case "TRACKING":
        _titlePage = "Tracking";
        break;
    }
    yield StateHomeChangePage(pageName: event.pageName, titlePage: _titlePage);
  }
}
