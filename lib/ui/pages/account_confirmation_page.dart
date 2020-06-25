part of 'pages.dart';

class AccountConfirmationPage extends StatefulWidget {
  final RegistrationData registrationData;

  const AccountConfirmationPage(this.registrationData);
  @override
  _AccountConfirmationPageState createState() =>
      _AccountConfirmationPageState();
}

class _AccountConfirmationPageState extends State<AccountConfirmationPage> {
  bool isSigningUp = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context
            .bloc<PageBloc>()
            .add(GoToPreferencePage(widget.registrationData));
        return;
      },
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 22),
                    height: 56,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              context.bloc<PageBloc>().add(GoToSplashPage());
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Create New\nAccount",
                            style: blackTextFont.copyWith(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image:
                                (widget.registrationData.profilePicture == null)
                                    ? AssetImage("assets/user_pic.png")
                                    : FileImage(
                                        widget.registrationData.profilePicture),
                            fit: BoxFit.cover)),
                  ),
                  Text(
                    "Welcome",
                    style: blackTextFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "${widget.registrationData.name}",
                    textAlign: TextAlign.center,
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                  SizedBox(
                    height: 110,
                  ),
                  (isSigningUp)
                      ? SpinKitFadingCircle(color: mainColor, size: 45)
                      : SizedBox(
                          height: 45,
                          width: 250,
                          child: RaisedButton(
                            color: mainColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Text("Confirm My Account"),
                            onPressed: () async {
                              setState(() {
                                isSigningUp = true;
                              });

                              imageFileToUpload =
                                  widget.registrationData.profilePicture;

                              SignInSignUpResult result =
                                  await AuthServices.signUp(
                                      widget.registrationData.email,
                                      widget.registrationData.password,
                                      widget.registrationData.name);
                              if (result.user == null) {
                                setState(() {
                                  isSigningUp = false;
                                });
                                Flushbar(
                                  duration: Duration(milliseconds: 1500),
                                  backgroundColor: mainDark,
                                  flushbarPosition: FlushbarPosition.TOP,
                                  message: result.message,
                                )..show(context);
                              }
                            },
                          ),
                        )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
