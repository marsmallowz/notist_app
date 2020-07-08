part of 'pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int topNavBarIndex;
  PageController pageController;
  final Firestore firestore = Firestore();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    topNavBarIndex = 0;
    pageController = PageController(initialPage: topNavBarIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: mainDark,
          ),
          SafeArea(
            child: Container(
              color: accentColor2,
            ),
          ),
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                topNavBarIndex = index;
              });
            },
            children: <Widget>[
              HomePage(
                firestore: firestore,
              ),
              SettingPage(),
            ],
          ),
          Container(child: createTopNavBar()),
        ],
      ),
    );
  }

  Widget createTopNavBar() => Align(
        alignment: Alignment.topCenter,
        child: Container(
            margin: EdgeInsets.only(top: defaultMargin),
            height: 70,
            decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                )),
            child: BottomNavigationBar(
                elevation: 0,
//                backgroundColor: Colors.transparent,
                selectedItemColor: mainDark,
                unselectedItemColor: accentColor4,
                selectedFontSize: 55,
                unselectedFontSize: 40,
                currentIndex: topNavBarIndex,
                onTap: (index) {
                  setState(() {
                    topNavBarIndex = index;
                    pageController.jumpToPage(index);
                  });
                },
                items: [
                  BottomNavigationBarItem(
                      title:
                          Text("Note", style: GoogleFonts.roboto(fontSize: 13)),
                      icon: Container()),
                  BottomNavigationBarItem(
                      title: Text("Setting",
                          style: GoogleFonts.roboto(fontSize: 13)),
                      icon: Container()),
                ])),
      );
}
