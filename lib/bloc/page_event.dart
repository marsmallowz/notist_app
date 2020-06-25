part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();
}

class GoToSplashPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToLoginPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToMainPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToRegistrationPage extends PageEvent {
  final RegistrationData registrationData;

  GoToRegistrationPage(this.registrationData);
  @override
  List<Object> get props => [];
}

class GoToPreferencePage extends PageEvent {
  final RegistrationData registrationData;

  GoToPreferencePage(this.registrationData);
  @override
  List<Object> get props => [];
}

class GoToAccountConfirmationPage extends PageEvent {
  final RegistrationData registrationData;

  GoToAccountConfirmationPage(this.registrationData);
  @override
  List<Object> get props => [];
}

class GoToMakePollPage extends PageEvent {
  final MakePollData makePollData;
  GoToMakePollPage(this.makePollData);
  @override
  List<Object> get props => [];
}

class GoToMakeOptionPage extends PageEvent {
  final MakePollData makePollData;
  GoToMakeOptionPage(this.makePollData);
  @override
  List<Object> get props => [];
}

class GoToPollPage extends PageEvent {
  final PollData pollData;
  GoToPollPage(this.pollData);
  @override
  List<Object> get props => [];
}
