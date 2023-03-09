import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_board/domain/auth/i_auth_repository.dart';
import 'package:todo_board/domain/core/utilities/strings.dart';

import '../../main.dart';

part 'auth_bloc.freezed.dart';

part 'auth_event.dart';

part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authFacade;

  AuthBloc(this._authFacade) : super(const AuthState.initial()) {
    on<AuthEvent>(
      (event, emit) async {
        await event.map(
          authCheckRequested: (e) async {
            log.i("authCheckRequested started");
            emit(const AuthState.submitting());
            final userOption = await _authFacade.getSignedInUser();
            String? userId;
            await SharedPreferences.getInstance().then((value) {
              userId = value.getString(Strings.cUserIdForSharePreferences);
            });
            if (userId == "" || userId == null) {
              emit(const AuthState.unauthenticated());
            } else {
              emit(
                userOption.fold(
                  () {
                    return const AuthState.unauthenticated();
                  },
                  (user) {
                    if (userId == user.id.getOrCrash()) {
                      return const AuthState.authenticated();
                    } else {
                      return const AuthState.unauthenticated();
                    }
                  },
                ),
              );
            }
          },
          signedOut: (e) async {
            log.i("signedOut started");
            emit(const AuthState.submitting());
            await _authFacade.signOut();
            await SharedPreferences.getInstance().then((value) {
              value.setString(Strings.cUserIdForSharePreferences, "");
            });
            emit(const AuthState.unauthenticated());
          },
        );
      },
    );
  }
}
