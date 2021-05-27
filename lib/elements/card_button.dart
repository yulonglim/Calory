import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  final IconData iconData;
  final String buttonName;
  final Widget nextPage;

  const CardButton({Key? key, required this.iconData, required this.buttonName, required this.nextPage})
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
            child: Column(
              children: [
                Icon(
                  iconData,
                  size: 80,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  buttonName,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
