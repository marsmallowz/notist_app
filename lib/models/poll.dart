part of 'models.dart';

class PollData {
  final String pollId;
  final String ownerId;
  final String description;
  final String photoDescription;
  Map polls;
  int view;

  PollData(
    this.pollId,
    this.ownerId, {
    this.description,
    this.photoDescription,
    this.polls,
    this.view,
  });

  @override
  // TODO: implement props
  List<Object> get props => [description, photoDescription];
}
