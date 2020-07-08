part of 'pages.dart';

class ZoomPhoto extends StatefulWidget {
  final File photoDescription;
  final String photoProfile;
  ZoomPhoto({this.photoDescription, this.photoProfile});
  @override
  _ZoomPhotoState createState() => _ZoomPhotoState();
}

class _ZoomPhotoState extends State<ZoomPhoto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: "zoomPhoto",
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: (widget.photoDescription == null)
                    ? NetworkImage(widget.photoProfile)
                    : FileImage(widget.photoDescription),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
