import 'package:flutter/material.dart';

class MyToggleButtons extends StatefulWidget {
  final String _option1;
  final String _option2;
  final String _option3;
  final Function result;


  MyToggleButtons(this._option1, this._option2, this._option3, this.result);

  @override
  _ToggleButtonsState createState() =>
      _ToggleButtonsState(this._option1, this._option2, this._option3, this.result);
}

class _ToggleButtonsState extends State<MyToggleButtons> {
  //set the initial state of each button whether it is selected or not
  List<bool> isSelected = [true, false, false];
  List<String> iconList = <String>[];
  final Function result;

  _ToggleButtonsState(String _option1, String _option2, String _option3, this.result) {
    iconList = [_option1, _option2, _option3];
  }

  @override
  Widget build(BuildContext context) {
    //wrap the GridView wiget in an Ink wiget and set the width and height,
    //otherwise the GridView widget will fill up all the space of its parent widget
    return Ink(
      width: 200,
      height: 60,
      color: Colors.white,
      child: GridView.count(
        primary: true,
        crossAxisCount: 3, //set the number of buttons in a row
        crossAxisSpacing: 8, //set the spacing between the buttons
        childAspectRatio: 2, //set the width-to-height ratio of the button,
        //>1 is a horizontal rectangle
        children: List.generate(isSelected.length, (index) {
          //using Inkwell widget to create a button
          return InkWell(
              splashColor: Colors.yellow, //the default splashColor is grey
              onTap: () {
                //set the toggle logic
                setState(() {
                  for (int indexBtn = 0;
                      indexBtn < isSelected.length;
                      indexBtn++) {
                    if (indexBtn == index) {
                      isSelected[indexBtn] = true;
                      result(indexBtn);
                    } else {
                      isSelected[indexBtn] = false;
                    }
                  }
                });
              },
              child: Ink(
                  decoration: BoxDecoration(
                    //set the background color of the button when it is selected/ not selected
                    color: isSelected[index]
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                    // here is where we set the rounded corner
                    borderRadius: BorderRadius.circular(8),
                    //don't forget to set the border,
                    //otherwise there will be no rounded corner
                    border: Border.all(color: Theme.of(context).primaryColor),
                  ),
                  child: Center(
                    child: Text(iconList[index],
                        //set the color of the icon when it is selected/ not selected
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: isSelected[index]
                                ? Colors.white
                                : Colors.grey)),
                  )));
        }),
      ),
    );
  }
}
