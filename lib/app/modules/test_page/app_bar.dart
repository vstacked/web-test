import 'package:flutter/material.dart';

class AppBar extends StatelessWidget {
  const AppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isWeb600 = size.width <= 600;
    return Container(
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.cyanAccent[700], Colors.lightBlue[600]],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.2, 0.9],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 100,
            child: IconButton(
              icon: Icon(Icons.menu, color: Colors.white70),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          Row(
            children: [
              if (!isWeb600) ...[Icon(Icons.ac_unit, color: Colors.white70, size: 20), const SizedBox(width: 10)],
              Text(!isWeb600 ? 'Tenderfarm' : 'Best Tenders',
                  style: TextStyle(color: Colors.white.withOpacity(.85), fontSize: 18.0))
            ],
          ),
          Row(children: [_horizontalMenu(icon: Icons.people), _horizontalMenu(icon: Icons.settings)])
        ],
      ),
    );
  }

  Widget _horizontalMenu({IconData icon}) {
    return SizedBox(
      width: 50,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Center(child: Icon(icon, color: Colors.white70)),
        ),
      ),
    );
  }
}
