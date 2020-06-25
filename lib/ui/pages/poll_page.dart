part of 'pages.dart';

class PollPage extends StatefulWidget {
  final PollData pollData;
  final DocumentSnapshot snapshot;
  final String description;
  PollPage(this.pollData, {this.description, this.snapshot});

  @override
  _PollPageState createState() => _PollPageState();
}

class _PollPageState extends State<PollPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text(widget.description == null ? 'Kosong' : 'ada'),
      ),
    );
  }
}
