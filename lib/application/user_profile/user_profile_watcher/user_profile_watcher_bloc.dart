import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_board/domain/auth/auth_failure.dart';
import 'package:todo_board/domain/core/utilities/logger/simple_log_printer.dart';
import 'package:todo_board/domain/user_profile/i_user_profile_repository.dart';
import 'package:todo_board/domain/user_profile/user_profile.dart';

part 'user_profile_watcher_bloc.freezed.dart';
part 'user_profile_watcher_event.dart';
part 'user_profile_watcher_state.dart';

@injectable
class UserProfileWatcherBloc
    extends Bloc<UserProfileWatcherEvent, UserProfileWatcherState> {
  final IUserProfileRepository _userProfileRepository;
  final log = getLogger();

  UserProfileWatcherBloc(this._userProfileRepository)
      : super(const UserProfileWatcherState.initial()) {
    on<UserProfileWatcherEvent>((event, emit) async {
      await event.map(
        watchUserProfileStarted: (e) async {
          log.i("watchUserProfileStarted started");
          emit(const UserProfileWatcherState.loadInProgress());
          await _userProfileRepository
              .getUpdatedUser()
              .then((failureOrUserProfile) {
            add(
              UserProfileWatcherEvent.userProfileReceived(failureOrUserProfile),
            );
          }).catchError((error) {
            log.e("error in loading UserProfile from firebase:$error");
            add(
              UserProfileWatcherEvent.userProfileReceived(
                  left(const AuthFailure.userProfileDataError())),
            );
          });
        },
        userProfileReceived: (e) async {
          log.i("userProfileReceived started");
          emit(e.failureOrUserProfile.fold(
            (failure) => UserProfileWatcherState.loadFailure(failure),
            (userProfile) => UserProfileWatcherState.loadSuccess(userProfile),
          ));
        },
      );
    });
  }
}
