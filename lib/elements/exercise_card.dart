import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseItem {
  final String title;
  final int value;
  final bool durationBased;

  ExerciseItem(this.title, this.value, this.durationBased);
}

class ExerciseCard extends StatelessWidget {
  final ExerciseItem item;
  final Animation<double> animation;
  final VoidCallback onClicked;

  const ExerciseCard({Key key, this.item, this.animation, this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (item.durationBased) {
      return SizeTransition(
        sizeFactor: animation,
        child: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).primaryColor,
          ),
          child: ListTile(
            horizontalTitleGap: MediaQuery.of(context).size.width * 0.1,
            contentPadding: EdgeInsets.all(16),
            leading: Container(
              child: Text(
                item.title,
                style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).secondaryHeaderColor),
              ),
            ),
            title: Text(
              item.value.toString() + ' s',
              style: TextStyle(
                  fontSize: 32, color: Theme.of(context).secondaryHeaderColor),
            ),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).secondaryHeaderColor,
              ),
              child: Text(
                'Done',
                style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).primaryColor),
              ),
              onPressed: onClicked,
            )
          ),
        ),
      );
    } else {
      return SizeTransition(
        sizeFactor: animation,
        child: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).primaryColor,
          ),
          child: ListTile(
            horizontalTitleGap: MediaQuery.of(context).size.width * 0.1,
            contentPadding: EdgeInsets.all(16),
            leading: Container(
              child: Text(
                item.title,
                style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).secondaryHeaderColor),
              ),
            ),
            title: Text(
              'x ' + item.value.toString(),
              style: TextStyle(
                  fontSize: 32, color: Theme.of(context).secondaryHeaderColor),
            ),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).secondaryHeaderColor,
              ),
              child: Text(
                'Done',
                style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).primaryColor),
              ),
              onPressed: onClicked,
            )
          ),
        ),
      );
    }
  }
}
