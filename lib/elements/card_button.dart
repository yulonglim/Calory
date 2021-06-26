import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  final IconData iconData;
  final String buttonName;
  final Widget nextPage;
  final String duration;

  const CardButton(
      {Key? key,
      required this.iconData,
      required this.buttonName,
      required this.nextPage,
      required this.duration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: new InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => nextPage),
          );
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
          child: Container(
            alignment: Alignment.center,
            child: Row(
              children: [
                Icon(
                  iconData,
                  size: 80,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      buttonName,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Duration: ' + this.duration,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
