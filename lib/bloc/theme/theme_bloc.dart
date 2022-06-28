import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitState()) {
    on<ThemechangeEvent>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("isDark", event.darkTheme);

      emit(ThemechangeState(event.darkTheme));
    });

    on<FetchthemeEvent>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool value = prefs.getBool("isDark") ?? false;
      emit(ThemechangeState(value));
    });
  }
}
