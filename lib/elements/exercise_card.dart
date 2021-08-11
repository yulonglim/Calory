import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/database/exercise_data.dart';

class ExerciseCard extends StatelessWidget {
  final ExerciseData item;
  final Animation<double>? animation;
  final VoidCallback onClicked;

  ExerciseCard(
      {Key? key, required this.item, this.animation, required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (item.exerciseValue == null) { //check if time based or rep based
      return SizeTransition(
        sizeFactor: animation!,
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
                  title: Text(item.exerciseName,
                      style: Theme.of(context).textTheme.headline1!),
                  content: Text(
                      item.exerciseDescription.split('. ').join('.\n\n'),
                      style: Theme.of(context).textTheme.bodyText2),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Text(
                      item.exerciseName,
                      style: Theme.of(context).textTheme.headline4!.merge(
                          TextStyle(
                              color: Theme.of(context).secondaryHeaderColor)),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Text(
                    item.exerciseTime.toString() + 's',
                    style: Theme.of(context).textTheme.headline3!.merge(
                        TextStyle(
                            color: Theme.of(context).secondaryHeaderColor)),
                  ),
                ],
              ),
            ),
            //
          ),
        ),
      );
    } else {
      return SizeTransition(
        sizeFactor: animation!,
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
                  title: Text(item.exerciseName,
                      style: Theme.of(context).textTheme.headline1!),
                  content: Text(
                      item.exerciseDescription.split('. ').join('.\n\n'),
                      style: Theme.of(context).textTheme.bodyText2),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Text(
                      item.exerciseName,
                      style: Theme.of(context).textTheme.headline4!.merge(
                          TextStyle(
                              color: Theme.of(context).secondaryHeaderColor)),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Text(
                    'x' + item.exerciseValue.toString(),
                    style: Theme.of(context).textTheme.headline3!.merge(
                        TextStyle(
                            color: Theme.of(context).secondaryHeaderColor)),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
