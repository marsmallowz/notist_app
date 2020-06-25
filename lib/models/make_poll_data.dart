part of 'models.dart';

class MakePollData {
  String pollId;
  String ownerId;
  String description;
  File photoDescription;
  List<String> option = [];
  int view;
  String pathPost;
  String datePost;

//  MakePollData({
//    this.pollId,
//    this.ownerId,
//    this.description,
//    this.photoDescription,
//    this.option = const [],
//    this.view,
//  });

  @override
  // TODO: implement props
  List<Object> get props => [description, photoDescription];
}
