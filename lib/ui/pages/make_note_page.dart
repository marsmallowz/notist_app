part of 'pages.dart';

class MakeNotePage extends StatefulWidget {
  final List<Color> colorsHex = [
    cardWhite,
    cardTosca,
    cardOrange,
    cardRed,
    cardYellow
  ];
  @override
  _MakeNotePageState createState() => _MakeNotePageState();
}

class _MakeNotePageState extends State<MakeNotePage> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController tittleController = TextEditingController();
  File photoDescription;
  String selectedColor = "";

  var uuid = new Uuid();
  Color parseWidget(data) {
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

  void initState() {
    // TODO: implement initState
    super.initState();
//    descriptionController.text = description;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return;
      },
      child: Scaffold(
        backgroundColor: parseWidget(selectedColor),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: mainDark),
          actions: [
            IconButton(
              icon: Icon(Icons.add_photo_alternate),
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text("Chose Image Picker"),
                          backgroundColor: Colors.white,
                          actions: [
                            FlatButton(
                              onPressed: () async {
                                if (photoDescription == null) {
                                  photoDescription =
                                      await getImage(ImageSource.camera);
                                } else {
                                  photoDescription = null;
                                }
                                setState(() {});
                              },
                              child: Text("Camera"),
                            ),
                            FlatButton(
                              onPressed: () async {
                                if (photoDescription == null) {
                                  photoDescription =
                                      await getImage(ImageSource.gallery);
                                } else {
                                  photoDescription = null;
                                }
                                setState(() {});
                              },
                              child: Text("Gallery"),
                            ),
                          ],
                        ),
                    barrierDismissible: true);
              },
            ),
            // ignore: missing_return
            BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
              if (userState is UserLoaded) {
                return FlatButton(
                  onPressed: () {
                    if (tittleController.text == "" ||
                        descriptionController.text == "") {
                      Flushbar(
                        duration: Duration(seconds: 4),
                        flushbarPosition: FlushbarPosition.TOP,
                        backgroundColor: mainColor,
                        message: "Tittle or Description must be filled!",
                      )..show(context);
                    } else {
                      imageFileToUpload = photoDescription;
                      if (imageFileToUpload != null) {
                        uploadImage(imageFileToUpload).then((downloadURL) {
                          imageFileToUpload = null;
                          PostServices.makePost(
                            descriptionPhoto: downloadURL,
                            pathPost: uuid.v1(),
                            tittle: tittleController.text,
                            colorNote: selectedColor,
                            description: descriptionController.text,
                            ownerId: userState.user.email,
                          );
                        });
                      } else {
                        PostServices.makePost(
                          pathPost: uuid.v1(),
                          tittle: tittleController.text,
                          colorNote: selectedColor,
                          description: descriptionController.text,
                          ownerId: userState.user.email,
                        );
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(color: mainDark),
                  ),
                  shape:
                      CircleBorder(side: BorderSide(color: Colors.transparent)),
                );
              }
            }),
          ],
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(children: [
            Stack(
              alignment: Alignment.center,
              children: [
                (photoDescription == null)
                    ? Container()
                    : Hero(
                        tag: 'zoomPhoto',
                        child: Container(
                          height: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: FileImage(photoDescription),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ZoomPhoto(
                                            photoDescription: photoDescription,
                                          )));
                            },
                          ),
                        ),
                      ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Wrap(
              spacing: 10,
              children: generateColorOptionWidgets(context),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              maxLength: 20,
              controller: tittleController,
              decoration: InputDecoration(hintText: "Tittle"),
            ),
            SizedBox(
              height: 20,
            ),
            (photoDescription == null)
                ? TextField(
                    minLines: 27,
                    maxLines: null,
                    controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Description"),
                  )
                : TextField(
                    minLines: 2,
                    maxLines: null,
                    controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Description"),
                  ),
          ]),
        ),
      ),
    );
  }

  List<Widget> generateColorOptionWidgets(BuildContext context) {
    return widget.colorsHex
        .map((e) => SelectableColor(
              e,
//              width: width,
              isSelected: selectedColor.contains(e.toString()),
              onTap: () {
                setState(() {
                  selectedColor = e.toString();
                });
              },
            ))
        .toList();
  }
}

//class ZoomPhoto extends StatefulWidget {
//  final File photoDescription;
//  ZoomPhoto(this.photoDescription);
//  @override
//  _ZoomPhotoState createState() => _ZoomPhotoState();
//}
//
//class _ZoomPhotoState extends State<ZoomPhoto> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Center(
//        child: Hero(
//          tag: "zoomPhoto",
//          child: Container(
//            decoration: BoxDecoration(
//              image: DecorationImage(
//                image: FileImage(widget.photoDescription),
//                fit: BoxFit.cover,
//              ),
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
//if (photoDescription == null) {
//photoDescription = await getImage(ImageSource.gallery);
//} else {
//photoDescription = null;
//}
//setState(() {});
