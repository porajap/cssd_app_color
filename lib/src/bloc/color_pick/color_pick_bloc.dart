import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'color_pick_event.dart';

part 'color_pick_state.dart';

class ColorPickBloc extends Bloc<ColorPickEvent, ColorPickState> {
  ColorPickBloc(ColorPickState initialState) : super(initialState);

  @override
  ColorPickState get initialState => InitialColorPickState();

  @override
  Stream<ColorPickState> mapEventToState(ColorPickEvent event) async* {
    // TODO: Add your event logic
  }
}
