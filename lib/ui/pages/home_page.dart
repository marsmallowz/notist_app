part of 'pages.dart';

class HomePage extends StatefulWidget {
  final Firestore firestore;
//  /final PollData pollData;

  HomePage({Key key, this.firestore}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String yourName = "";
  String yourPhoto = "";
  void initState() {
    super.initState();
    yourName = "";
    yourPhoto = "";
  }

//  int _currentIndex = 1;
//  Stream<QuerySnapshot> get query =>
//      widget.firestore.collection('posts').snapshots();
  Query get query =>
      widget.firestore.collection('posts').orderBy("date", descending: true);

//  Future<void> _goToPollingPosts(DocumentSnapshot snapshot) async =>
//
//      // await context.bloc<PageBloc>().add(GoToPollPage(widget.pollData));
//      await Navigator.of(context).push(
//        MaterialPageRoute(
//          builder: (BuildContext context) => NewPollPage(
//            description: 'Apa Aja',
//            snapshot: snapshot,
//          ),
//        ),
//      );

  Future<void> _goToPollingPost(DocumentSnapshot snapshot) async =>
      Firestore.instance
          .collection('users')
          .where("email", isEqualTo: "${snapshot['ownerId']}")
          .getDocuments()
          .then((value) async {
        value.documents.forEach((element) {
          yourName = "${element.data["name"]}";
          yourPhoto = "${element.data["profilePicture"]}";
        });
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => NewPollPage(
              nameProfile: yourName,
              photoProfile: yourPhoto,
              snapshot: snapshot,
            ),
          ),
        );
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ignore: missing_return
          BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
            if (userState is UserLoaded) {
              if (imageFileToUpload != null) {
                uploadImage(imageFileToUpload).then((downloadURL) {
                  imageFileToUpload = null;
                  context
                      .bloc<UserBloc>()
                      .add(UpdateData(profileImage: downloadURL));
                });
              }
            }
            return Container();
          }),
          Container(
            margin: EdgeInsets.only(
                top: 75, left: defaultMargin, right: defaultMargin),
            child: FirestoreAnimatedStaggered(
              query: query,
              staggeredTileBuilder: (int index, DocumentSnapshot snapshot) =>
                  StaggeredTile.count(
                      2, ('${snapshot['descriptionPhoto']}' != "") ? 3.4 : 1.5),
              crossAxisCount: 4,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              itemBuilder: (
                BuildContext context,
                DocumentSnapshot snapshot,
                Animation<double> animation,
                int index,
              ) =>
                  FadeTransition(
                opacity: animation,
                child: MessageGridTile(
                  index: index,
                  document: snapshot,
                  onTap: _goToPollingPost,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 50,
              width: 50,
              margin:
                  EdgeInsets.only(bottom: defaultMargin, right: defaultMargin),
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor: mainDark,
                child: SizedBox(
                  height: 26,
                  width: 26,
                  child: Icon(
                    MdiIcons.plus,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => MakeNotePage(),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MessageGridTile extends StatelessWidget {
  final int index;
  final DocumentSnapshot document;
  final Function(DocumentSnapshot) onTap;

  const MessageGridTile({
    Key key,
    this.index,
    this.document,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
//    QuerySnapshot snapshot = document.getDocuments();
    DateTime date = DateTime.fromMillisecondsSinceEpoch(
        document['date'].millisecondsSinceEpoch);
    String formattedDate = DateFormat('MMM d, yyy kk:mm a').format(date);
    Color parseColor(data) {
      switch (data) {
        case 'Color(0xffffffff)':
          return cardWhite;
        case 'Color(0xffe0a458)':
          return cardOrange;
        case 'Color(0xff56bbb5)':
          return cardTosca;
        case 'Color(0xffea6f86)':
          return cardRed;
        case 'Color(0xfff0e672)':
          return cardYellow;
      }
      return cardNote;
    }
//    Firestore.instance
//        .collection('users')
//        .where("email", isEqualTo: "${document['ownerId']}")
//        .getDocuments()
//        .then((value) async {
//      value.documents.forEach((element) {
//        yourName = "${element.data["name"]}";
//        yourPhoto = "${element.data["profilePicture"]}";
//      });

    return InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => onTap?.call(document),
        child: StreamBuilder(
            stream: Firestore.instance
                .collection('users')
                .where("email", isEqualTo: "${document['ownerId']}")
                .snapshots(),
            builder: (context, snapshot) {
              final dataUser = snapshot.data.documents;

              return Stack(
                children: [
                  if ('${document['descriptionPhoto']}' != "")
                    Column(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10)),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        '${document['descriptionPhoto']}'),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: parseColor('${document['colorNote']}'),
//                          border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: defaultMargin, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    '${document['tittle']}',
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    '${document['description']}',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 13),
                                    maxLines: 2,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    '$formattedDate',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  else
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: parseColor('${document['colorNote']}')),
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
//                                Text("${dataUser[0]["name"]}"),
                            Container(
                              margin: EdgeInsets.only(bottom: 5),
                              child: Text(
                                '${document['tittle']}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.w700),
                                maxLines: 1,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 12),
                              child: Text(
                                '${document['description']}',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13),
                                maxLines: 2,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${dataUser[0]["name"]}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black.withOpacity(0.7)),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      "Profesi",
                                      style: TextStyle(fontSize: 10),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: ("${dataUser[0]["profilePicture"]}" ==
                                                  ""
                                              ? AssetImage(
                                                  "assets/user_pic1.png")
                                              : NetworkImage(
                                                  "${dataUser[0]["profilePicture"]}")),
                                          fit: BoxFit.cover)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            }));
  }
}
