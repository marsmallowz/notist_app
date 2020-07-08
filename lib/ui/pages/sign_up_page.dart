part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  final RegistrationData registrationData;

  SignUpPage(this.registrationData);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.registrationData.name;
    emailController.text = widget.registrationData.email;
  }

  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: mainDark)));
    return WillPopScope(
        onWillPop: () async {
          context.bloc<PageBloc>().add(GoToSplashPage());
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
                              style: blackTextFont.copyWith(
                                  fontSize: 22, fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 90,
                      height: 104,
                      child: Stack(
                        children: [
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: (widget.registrationData
                                                .profilePicture ==
                                            null)
                                        ? AssetImage("assets/user_pic1.png")
                                        : FileImage(widget
                                            .registrationData.profilePicture),
                                    fit: BoxFit.cover)),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () async {
                                await showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                          title: Text("Chose Image Picker"),
                                          backgroundColor: Colors.white,
                                          actions: [
                                            FlatButton(
                                              onPressed: () async {
                                                if (widget.registrationData
                                                        .profilePicture ==
                                                    null) {
                                                  widget.registrationData
                                                          .profilePicture =
                                                      await getImage(
                                                          ImageSource.camera);
                                                } else {
                                                  widget.registrationData
                                                      .profilePicture = null;
                                                }
                                                setState(() {});
                                              },
                                              child: Text("Camera"),
                                            ),
                                            FlatButton(
                                              onPressed: () async {
                                                if (widget.registrationData
                                                        .profilePicture ==
                                                    null) {
                                                  widget.registrationData
                                                          .profilePicture =
                                                      await getImage(
                                                          ImageSource.gallery);
                                                } else {
                                                  widget.registrationData
                                                      .profilePicture = null;
                                                }
                                                setState(() {});
                                              },
                                              child: Text("Gallery"),
                                            ),
                                          ],
                                        ),
                                    barrierDismissible: true);
                              },
                              child: Container(
                                height: 28,
                                width: 28,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage((widget
                                                    .registrationData
                                                    .profilePicture ==
                                                null)
                                            ? "assets/btn_add_photo.png"
                                            : "assets/btn_del_photo.png"))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 36,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Email",
                          hintText: "Email"),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Full Name",
                          hintText: "Full name"),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Password",
                          hintText: "Password"),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      obscureText: true,
                      controller: retypePasswordController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Retype Password",
                          hintText: "Retype Password"),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FloatingActionButton(
                      child: Icon(Icons.arrow_forward),
                      backgroundColor: mainColor,
                      elevation: 0,
                      onPressed: () {
                        if (!(nameController.text.trim() != "" &&
                            emailController.text.trim() != "" &&
                            passwordController.text.trim() != "" &&
                            retypePasswordController.text.trim() != "")) {
                          Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: mainDark,
                            message: "Please fill all the fields",
                          )..show(context);
                        } else if (passwordController.text !=
                            retypePasswordController.text) {
                          Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: mainDark,
                            message: "Mismatch password and retype password",
                          )..show(context);
                        } else if (passwordController.text.length < 8) {
                          Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: mainDark,
                            message: "Password's length min 8 characters",
                          )..show(context);
                        } else if (!EmailValidator.validate(
                            emailController.text)) {
                          Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: mainDark,
                            message: "Wrong email address",
                          )..show(context);
                        } else {
                          widget.registrationData.name = nameController.text;
                          widget.registrationData.email = emailController.text;
                          widget.registrationData.password =
                              passwordController.text;
                          context.bloc<PageBloc>().add(
                              GoToAccountConfirmationPage(
                                  widget.registrationData));
                        }
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
