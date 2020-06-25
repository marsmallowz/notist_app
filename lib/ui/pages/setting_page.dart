part of 'pages.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMM d, yyy kk:mm a').format(now);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$formattedDate'),
            Text('$now'),
            RaisedButton(
              child: Text("SignOut"),
              onPressed: () {
                context.bloc<UserBloc>().add(SignOut());
                AuthServices.signOut();
              },
            )
          ],
        ),
      ),
    );
  }
}
