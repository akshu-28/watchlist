import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:watchlist/model/registration_request.dart';

import 'package:watchlist/repository/registration_repo.dart';

import '../../model/registration_response.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial()) {
    on<RegistrationRequestEvent>((event, emit) async {
      emit(RegistrationLoad());
      try {
        var response = await RegistrationRepository()
            .registration(event.registrationRequest);
        emit(RegistrationDone(response));
      } catch (e) {
        emit(RegistrationError(e.toString()));
      }
    });
    on<AgreeEvent>((event, emit) async {
      emit(AgreeState(event.agree));
    });
  }
}
