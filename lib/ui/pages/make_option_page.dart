part of 'pages.dart';

class MakeOptionPage extends StatefulWidget {
  final MakePollData makePollData;

  MakeOptionPage(this.makePollData);
  @override
  _MakeOptionPageState createState() => _MakeOptionPageState();
}

class _MakeOptionPageState extends State<MakeOptionPage> {
  TextEditingController descriptionOption = TextEditingController();
  List<String> newOption = [];
  bool isProfilePicture = false;
  bool isDescriptionValid = false;

  @override
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToMakePollPage(widget.makePollData));
        return;
      },
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                context
                                    .bloc<PageBloc>()
                                    .add(GoToMakePollPage(widget.makePollData));
                              },
                              child: Icon(MdiIcons.arrowLeft)),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                              "Option ${widget.makePollData.option.length + 1}")
                        ],
                      ),
                      Text("Next")
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 182,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  (widget.makePollData.photoDescription == null)
                                      ? AssetImage("assets/user_pic1.png")
                                      : FileImage(
                                          widget.makePollData.photoDescription),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: () async {
                            if (widget.makePollData.photoDescription == null) {
                              widget.makePollData.photoDescription =
                                  await getImage();
                            } else {
                              widget.makePollData.photoDescription = null;
                            }
                            setState(() {});
                          },
                          child: Container(
                            height: 28,
                            width: 28,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(
                                        (widget.makePollData.photoDescription ==
                                                null)
                                            ? "assets/btn_add_photo.png"
                                            : "assets/btn_del_photo.png"))),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    maxLines: null,
                    onChanged: (text) {
                      setState(() {
                        isDescriptionValid = text.length >= -1;
                      });
                    },
                    controller: descriptionOption,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Description",
                        hintText: "Description"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    height: 80,
                    width: 287,
                    decoration: BoxDecoration(
                        color: isDescriptionValid || isProfilePicture
                            ? mainColor
                            : Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: MaterialButton(
                      child: Text(
                        "Done",
                        style: blackTextFont.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: isDescriptionValid || isProfilePicture
                              ? Colors.white
                              : mainColor,
                        ),
                      ),
                      onPressed: () {
                        // newOption.add(descriptionOption.text);
                        widget.makePollData.option.add(descriptionOption.text);
                        context
                            .bloc<PageBloc>()
                            .add(GoToMakePollPage(widget.makePollData));
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
