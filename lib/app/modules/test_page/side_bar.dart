import 'package:flutter/material.dart';

// tab and mobile < web sizing 1024  < web > 1500 web sizing
class SideBar extends StatefulWidget {
  const SideBar({Key key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  int tabActive = 1;
  int subMenuActive = -1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isWeb900 = size.width <= 900;
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.cyanAccent[700], Colors.lightBlue[900]],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.7],
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: !isWeb900
                  ? Row(crossAxisAlignment: CrossAxisAlignment.center, children: logoApps(true))
                  : Column(children: logoApps(false)),
            ),
            const SizedBox(height: 50),
            Expanded(
              flex: 5,
              child: ListView(
                shrinkWrap: true,
                children: [
                  _verticalMenu(0, !isWeb900, icon: Icons.home, text: 'COMPANY'),
                  _verticalMenu(1, !isWeb900, icon: Icons.search, text: 'EXPLORE'),
                  _verticalMenu(2, !isWeb900, icon: Icons.notifications, text: 'NOTIFICATIONS'),
                  if (!isWeb900) _card(),
                  _verticalMenu(3, !isWeb900, icon: Icons.mail, text: 'MESSAGES'),
                  _verticalMenu(4, !isWeb900, icon: Icons.person, text: 'PROFILE'),
                ],
              ),
            ),
            if (!isWeb900)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: _horizontalMenu(icon: Icons.settings)),
                  Expanded(child: _horizontalMenu(icon: Icons.people))
                ],
              )
            else
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 5),
                  children: [_horizontalMenu(icon: Icons.settings), _horizontalMenu(icon: Icons.people)],
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> logoApps(bool isRow) => [
        Icon(Icons.ac_unit, color: Colors.white70, size: isRow ? 20 : 25),
        if (isRow) const SizedBox(width: 20) else const SizedBox(height: 5),
        Text('Tenderfarm', style: TextStyle(color: Colors.white.withOpacity(.85), fontSize: isRow ? 18.0 : 12.5))
      ];

  Container _card() {
    return Container(
      height: 130,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      margin: const EdgeInsets.symmetric(vertical: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                child: Icon(Icons.ac_unit, color: Colors.white),
                backgroundColor: Colors.white10,
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  Text('Apple Inc.', style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 3),
                  Text('ending soon', style: TextStyle(color: Colors.white38, fontSize: 12.0)),
                ],
              )
            ],
          ),
          Text(
            'Hey, don\'t forget, there\'s still time to get that tender!',
            style: TextStyle(color: Colors.white70, wordSpacing: 2, letterSpacing: 1),
          ),
        ],
      ),
    );
  }

  Widget _horizontalMenu({IconData icon}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 60,
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(color: Colors.white10),
          child: Center(child: Icon(icon, color: Colors.white)),
        ),
      ),
    );
  }

  Widget _verticalMenu(int index, bool isRow, {IconData icon, String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              if (mounted)
                setState(() {
                  subMenuActive = -1;
                  tabActive = index;
                });
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                SizedBox(
                  height: isRow ? 35 : 50,
                  width: double.infinity,
                  child: isRow
                      ? Row(
                          children: [
                            Icon(icon, color: Colors.white.withOpacity(.85)),
                            const SizedBox(width: 20),
                            Text(text,
                                style: TextStyle(color: Colors.white.withOpacity(tabActive == index ? .85 : .4))),
                            if (index == 2) ...[
                              Spacer(),
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.orange,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text('1', style: TextStyle(color: Colors.white, fontSize: 12)),
                                ),
                              ),
                            ]
                          ],
                        )
                      : Column(
                          children: [
                            Icon(icon, color: Colors.white.withOpacity(.85)),
                            const SizedBox(height: 5),
                            Text(
                              text,
                              style: TextStyle(
                                color: Colors.white.withOpacity(tabActive == index ? .85 : .4),
                                fontSize: isRow ? 14.0 : 9.0,
                              ),
                            ),
                          ],
                        ),
                ),
                if (tabActive == index)
                  Positioned(
                    left: -20,
                    child: Container(
                      height: isRow ? 35 : 50,
                      width: 4,
                      decoration: BoxDecoration(
                        color: Colors.amber[600],
                        borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (tabActive == index && index == 1)
            Padding(
              padding: EdgeInsets.only(left: isRow ? 44 : 18, top: 7.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _verticalSubMenu(0, isRow, text: 'LATEST TENDERS'),
                  _verticalSubMenu(1, isRow, text: 'BEST TENDERS'),
                  _verticalSubMenu(2, isRow, text: 'TEAM SEARCH'),
                ],
              ),
            )
        ],
      ),
    );
  }

  Widget _verticalSubMenu(int index, bool isRow, {String text}) {
    return InkWell(
      onTap: () {
        if (mounted)
          setState(() {
            subMenuActive = index;
          });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white.withOpacity(subMenuActive == index ? .85 : .4), fontSize: isRow ? 14.0 : 12.0),
        ),
      ),
    );
  }
}
