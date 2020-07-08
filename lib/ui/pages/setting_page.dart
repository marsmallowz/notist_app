part of 'pages.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

//    DateTime now = DateTime.now();
//    String formattedDate = DateFormat('MMM d, yyy kk:mm a').format(now);
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ignore: missing_return
            BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
              if (userState is UserLoaded) {
                return Column(
                  children: [
                    Container(
                      height: screenSize.width / 2,
                      width: screenSize.width / 2,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: (userState.user.profilePicture == ""
                                  ? AssetImage("assets/user_pic1.png")
                                  : NetworkImage(
                                      userState.user.profilePicture)),
                              fit: BoxFit.cover)),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          userState.user.name,
                          style: TextStyle(fontSize: 20),
                        ))
                  ],
                );
              }
            }),
//            Text('$formattedDate'),
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
