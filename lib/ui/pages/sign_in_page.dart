part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSignInValid = false;

  @override
  Widget build(BuildContext context) {
    context.bloc<ThemeBloc>().add(
          ChangeTheme(
            ThemeData().copyWith(primaryColor: mainColor),
          ),
        );

    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToSplashPage());
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              SizedBox(
                height: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 24),
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/border_shadow.png')),
                    ),
                  ),
                  Text(
                    "Sign In to Continue",
                    style: blackTextFont,
                  ),
                  SizedBox(
                    height: 19,
                  ),
                  Container(
                    width: 287,
                    child: TextField(
                      controller: emailController,
                      onChanged: (text) {
                        setState(() {
                          isEmailValid = EmailValidator.validate(text);
                        });
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "Your Email",
                          labelText: "Email Address"),
                    ),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Container(
                    width: 287,
                    child: TextField(
                      controller: passwordController,
                      onChanged: (text) {
                        setState(() {
                          isPasswordValid = text.length >= 8;
                        });
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.vpn_key),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "Password",
                          labelText: "Password"),
                    ),
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    height: 80,
                    width: 287,
                    decoration: BoxDecoration(
                        color: isEmailValid && isPasswordValid
                            ? mainColor
                            : Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: MaterialButton(
                        child: Text(
                          "Sign In",
                          style: blackTextFont.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: isEmailValid && isPasswordValid
                                ? Colors.white
                                : mainColor,
                          ),
                        ),
                        onPressed: isEmailValid && isPasswordValid
                            ? () async {
                                setState(() {
                                  isSignInValid = true;
                                });
                                SignInSignUpResult result =
                                    await AuthServices.signIn(
                                        emailController.text,
                                        passwordController.text);
                                if (result.user == null) {
                                  setState(() {
                                    isSignInValid = false;
                                  });
                                  Flushbar(
                                    duration: Duration(seconds: 4),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    backgroundColor: mainColor,
                                    message: result.message,
                                  )..show(context);
                                }
                              }
                            : null),
                  ),
                  Text(
                    "Forget Password?",
                    style: blackTextFont.copyWith(
                        fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      "Don’t have account?",
                      style: greyTextFont.copyWith(fontSize: 15),
                    ),
                    GestureDetector(
                      onTap: () {
                        context
                            .bloc<PageBloc>()
                            .add(GoToRegistrationPage(RegistrationData()));
                      },
                      child: Text(
                        " Register",
                        style: blackTextFont.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                    )
                  ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
