part of 'shared.dart';

Future<File> getImage(ImageSource source) async {
  final _picker = ImagePicker();
  var image = await _picker.getImage(source: source);
  final File file = File(image.path);
  return file;
//  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//  return image;
}

Future<String> uploadImage(File image) async {
  String fileName = basename(image.path);

  StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
  StorageUploadTask task = ref.putFile(image);
  StorageTaskSnapshot snapshot = await task.onComplete;

  return await snapshot.ref.getDownloadURL();
}
