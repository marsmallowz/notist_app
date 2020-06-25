import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notistapp/models/models.dart';
import 'package:notistapp/services/services.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  @override
  // TODO: implement initialState
  UserState get initialState => UserInitial();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is LoadUser) {
      User user = await UserServices.getUser(event.id);
      yield UserLoaded(user);
    } else if (event is SignOut) {
      yield UserInitial();
    } else if (event is UpdateData) {
      User updateUser = (state as UserLoaded)
          .user
          .copyWith(name: event.name, profilePicture: event.profileImage);
      await UserServices.updateUser(updateUser);
      yield UserLoaded(updateUser);
    }
  }
}
