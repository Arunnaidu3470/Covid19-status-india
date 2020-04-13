import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black45,
        child: ListView(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20, left: 10),
              child: Text(
                'COVID19',
                style: Theme.of(context)
                    .primaryTextTheme
                    .headline3
                    .copyWith(color: Colors.white70),
              ),
            ),
            Divider(),
            InkWell(
              customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                      topRight: Radius.circular(50))),
              splashColor: Colors.green,
              highlightColor: Colors.green.withOpacity(0.2),
              onTap: () {},
              child: ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('About App',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .bodyText2
                        .copyWith(color: Colors.white70)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
