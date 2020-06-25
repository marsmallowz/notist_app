part of 'widgets.dart';

class SelectableColor extends StatelessWidget {
  final bool isSelected;
  final bool isEnabled;
  final double width;
  final double height;
  final Color color;
  final Function onTap;

  const SelectableColor(
    this.color, {
    this.isSelected = false,
    this.isEnabled = true,
    this.width = 20,
    this.height = 20,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        width: width,
        height: height,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: color, boxShadow: [
          BoxShadow(
//            color: Colors.grey, offset: Offset(3.0, 3.5), //(x,y)
//            blurRadius: 1.0,
            color: Colors.grey,
            offset: const Offset(2.0, 2.0),
            blurRadius: 1.0,
            spreadRadius: 1.0,
          )
        ]
//          border: Border.all(
//              color:
//                  (!isSelected) ? Colors.transparent : Colors.lightBlueAccent,
//              width: 1),
                ),
      ),
    );
  }
}
//Container(
//width: width,
//height: height,
//decoration: BoxDecoration(
//shape: BoxShape.circle,
//color: (!isEnabled)
//? accentColor1
//    : isSelected ? mainColor : Colors.transparent,
//border: Border.all(
//color: (!isEnabled)
//? accentColor1
//    : isSelected ? Colors.transparent : accentColor1)),
//),
