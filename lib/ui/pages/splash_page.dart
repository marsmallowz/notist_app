part of 'pages.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 164,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/border_shadow.png')),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 8),
              child: Text(
                "Wellcome to Notist",
                style: blackTextFont.copyWith(
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              child: Text(
                "Make a Note for your Partner",
                style: blackTextFont.copyWith(
                    fontSize: 20, fontWeight: FontWeight.w300),
              ),
            ),
            Container(
              height: 55,
              width: 287,
              margin: EdgeInsets.only(top: 50, bottom: 30),
              child: RaisedButton(
                color: Colors.white,
                onPressed: () {
                  context.bloc<PageBloc>().add(GoToLoginPage());
                },
                child:
                    Text('Get Started', style: TextStyle(color: Colors.black)),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.black,
                        width: 1,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(5)),
              ),
//              decoration: BoxDecoration(
//                  borderRadius: BorderRadius.circular(5), color: Colors.black),
//              child: OutlineButton(
//                child: Text(
//                  "Get Started",
//                  style: blackTextFont.copyWith(fontSize: 15),
//                ),
//                borderSide: BorderSide(color: Colors.black),
//                shape: StadiumBorder(),
//                onPressed: () {},
//              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                    style: blackTextFont.copyWith(fontSize: 15),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
