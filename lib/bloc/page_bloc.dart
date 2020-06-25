import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notistapp/models/models.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  @override
  // TODO: implement initialState
  PageState get initialState => OnInitialPage();

  @override
  Stream<PageState> mapEventToState(PageEvent event) async* {
    if (event is GoToSplashPage) {
      yield OnSplashPage();
    } else if (event is GoToLoginPage) {
      yield OnLoginPage();
    } else if (event is GoToMainPage) {
      yield OnMainPage();
    } else if (event is GoToRegistrationPage) {
      yield OnRegistrationPage(event.registrationData);
    } else if (event is GoToAccountConfirmationPage) {
      yield OnAccountConfirmationPage(event.registrationData);
    } else if (event is GoToMakePollPage) {
      yield OnMakePollPage(event.makePollData);
    } else if (event is GoToMakeOptionPage) {
      yield OnMakeOption(event.makePollData);
    } else if (event is GoToPollPage) {
      yield OnShowPostPolling(event.pollData);
    }
  }
}
