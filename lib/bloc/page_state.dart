part of 'page_bloc.dart';

abstract class PageState extends Equatable {
  const PageState();
}

class OnInitialPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnLoginPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnSplashPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnMainPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnRegistrationPage extends PageState {
  final RegistrationData registrationData;

  OnRegistrationPage(this.registrationData);
  @override
  List<Object> get props => [];
}

class OnAccountConfirmationPage extends PageState {
  final RegistrationData registrationData;

  OnAccountConfirmationPage(this.registrationData);
  @override
  List<Object> get props => [];
}

class OnMakePollPage extends PageState {
  final MakePollData makePollData;

  OnMakePollPage(this.makePollData);

  @override
  List<Object> get props => [];
}

class OnMakeOption extends PageState {
  final MakePollData makePollData;

  OnMakeOption(this.makePollData);

  @override
  List<Object> get props => [];
}

class OnShowPostPolling extends PageState {
  final PollData pollData;

  OnShowPostPolling(this.pollData);

  @override
  List<Object> get props => [];
}
