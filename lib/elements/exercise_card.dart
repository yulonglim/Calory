import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseItem {
  final String title;
  final String description;
  final int value;
  final bool durationBased;

  ExerciseItem(this.title, this.value, this.durationBased, this.description);
}

class ExerciseCard extends StatelessWidget {
  final ExerciseItem item;
  final Animation<double> animation;
  final VoidCallback onClicked;

  const ExerciseCard({Key? key, required this.item, required this.animation, required this.onClicked})
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
              contentPadding: EdgeInsets.all(16),
              title: new InkWell(
                onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(item.title,),
                    content: Text(item.description),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(
                        item.title,
                        style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).secondaryHeaderColor),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Text(
                      item.value.toString() + ' s',
                      style: TextStyle(
                          fontSize: 32,
                          color: Theme.of(context).secondaryHeaderColor),
                    ),
                  ],
                ),
              ),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).secondaryHeaderColor,
                ),
                child: Text(
                  'Done',
                  style: TextStyle(
                      fontSize: 24, color: Theme.of(context).primaryColor),
                ),
                onPressed: onClicked,
              )),
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
              contentPadding: EdgeInsets.all(16),
              title: new InkWell(
                onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(item.title),
                    content: Text(item.description),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(
                        item.title,
                        style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).secondaryHeaderColor),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Text(
                      'x ' + item.value.toString(),
                      style: TextStyle(
                          fontSize: 32,
                          color: Theme.of(context).secondaryHeaderColor),
                    ),
                  ],
                ),
              ),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).secondaryHeaderColor,
                ),
                child: Text(
                  'Done',
                  style: TextStyle(
                      fontSize: 24, color: Theme.of(context).primaryColor),
                ),
                onPressed: onClicked,
              )),
        ),
      );
    }
  }
}
