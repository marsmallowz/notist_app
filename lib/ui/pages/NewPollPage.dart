part of 'pages.dart';

class NewPollPage extends StatefulWidget {
  final DocumentSnapshot snapshot;
  final String nameProfile;
  final String photoProfile;

  NewPollPage({this.nameProfile, this.snapshot, this.photoProfile});

  @override
  _NewPollPageState createState() => _NewPollPageState();
}

class _NewPollPageState extends State<NewPollPage> {
  TextEditingController apaaja = TextEditingController();

  Future<void> _updateData(DocumentSnapshot snapshot) async =>
      await Firestore.instance.runTransaction((transaction) async {
        await transaction.update(snapshot.reference, <String, dynamic>{
          'description': apaaja.text,
        });
        Navigator.pop(context, true);
      });

  Future<void> _removeNote(DocumentSnapshot snapshot) async =>
      await Firestore.instance.runTransaction((transaction) async {
        await transaction.delete(snapshot.reference);
        Navigator.pop(context, true);
      });

  Query get query => Firestore.instance
      .collection('users')
      .where("name", isEqualTo: "${widget.snapshot['ownerId']}");

  @override
  Widget build(BuildContext context) {
    apaaja = TextEditingController(text: widget.snapshot['description']);
    DateTime date = DateTime.fromMillisecondsSinceEpoch(
        widget.snapshot['date'].millisecondsSinceEpoch);
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

    return Scaffold(
      backgroundColor: parseColor(widget.snapshot['colorNote']),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black.withOpacity(0.7)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_photo_alternate,
              color: Colors.black.withOpacity(0.7),
            ),
            onPressed: () {},
          ),
//          IconButton(
//            icon: Icon(
//              Icons.more_vert,
//              color: Colors.white,
//            ),
//          ),
          FlatButton(
            textColor: Colors.white,
            onPressed: () {
              _removeNote(widget.snapshot);
            },
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.black.withOpacity(0.7)),
            ),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
          FlatButton(
            textColor: Colors.white,
            onPressed: () {
              _updateData(widget.snapshot);
            },
            child: Text(
              "Update",
              style: TextStyle(color: Colors.black.withOpacity(0.7)),
            ),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: (widget.photoProfile == ""
                                ? AssetImage("assets/user_pic1.png")
                                : NetworkImage(widget.photoProfile)),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.nameProfile,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black.withOpacity(0.7)),
                  )
                ],
              ),
            ),
//            Text(widget.description),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("${widget.snapshot['tittle']}"),
                  Text(' | '),
                  Text(
                    '$formattedDate',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ('${widget.snapshot['descriptionPhoto']}' == "")
                      ? Container()
                      : Container(
                          height: 450,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      '${widget.snapshot['descriptionPhoto']}'),
                                  fit: BoxFit.cover)),
                        ),
                  ('${widget.snapshot['descriptionPhoto']}' == "")
                      ? TextField(
                          controller: apaaja,
                          minLines: 27,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        )
                      : TextField(
                          controller: apaaja,
                          keyboardType: TextInputType.multiline,
                          minLines: 2,
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
