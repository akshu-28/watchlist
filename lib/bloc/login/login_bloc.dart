import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/login_request.dart';
import '../../model/login_response.dart';
import '../../repository/login_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class OtpvalidationBloc extends Bloc<OtpvalidationEvent, OtpvalidationState> {
  OtpvalidationBloc() : super(LoginInitial()) {
    on<OtpvalidationRequestEvent>((event, emit) async {
      emit(OtpvalidationLoad());
      try {
        var response =
            await OtpvalidationRepository().login(event.otpvalidationRequest);
        emit(OtpvalidationDone(response));
      } catch (e) {
        emit(OtpvalidationError(e.toString()));
      }
    });
  }
}
