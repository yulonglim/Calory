import 'package:flutter/material.dart';
import 'package:flutter_app/Pages/OneTimeWorkOutPage.dart';

class noPlan extends StatelessWidget {
  const noPlan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor.withAlpha(600),
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "You have not",
                    style: Theme.of(context).textTheme.headline2!
                        .merge(TextStyle(color: Colors.black)),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "set a goal!",
                    style: Theme.of(context).textTheme.headline2!
                        .merge(TextStyle(color: Colors.black)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.whatshot,
                      size: 80,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OneTimeWorkOut()),
                            );
                          },
                          child: Column(
                            children: [
                              Text(
                                'Start a one-time workout',
                                style: Theme.of(context).textTheme.headline4!
                                    .merge(TextStyle(color: Theme.of(context).secondaryHeaderColor)),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
