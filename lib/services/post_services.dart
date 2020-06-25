part of 'services.dart';

class PostServices {
  static CollectionReference _postCollection =
      Firestore.instance.collection('posts');

  static Future<void> makePost(
      {String pollId,
      Timestamp createAt,
      String ownerId,
      String profilePicture,
      String tittle,
      String colorNote,
      String description,
      String descriptionPhoto,
      List optionDescription,
      Map poll,
      int view,
      String pathPost}) async {
    _postCollection.document(pathPost).setData({
      'date': Timestamp.fromMillisecondsSinceEpoch(
          DateTime.now().millisecondsSinceEpoch),
      'ownerId': ownerId,
      'profilePicture': profilePicture ?? "",
      'tittle': tittle,
      'colorNote': colorNote ?? "",
      'description': description,
      'descriptionPhoto': descriptionPhoto ?? "",
    });
//    var i;
//    for (i = 0; i < optionDescription.length; i++) {
//      _postCollection
//          .document(pathPost)
//          .collection('option')
//          .document('option ${i + 1}')
//          .setData({
//        'optionDescription': optionDescription[i],
//      });
//    }
  }
}
