import 'package:flutter/material.dart';

class MenuDrawer extends StatefulWidget {
  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  int tabActive = 1;
  int subMenuActive = -1;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.cyanAccent[700], Colors.lightBlue[700]],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.1, 0.7],
        ),
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          _profile(),
          const SizedBox(height: 15),
          const Divider(color: Colors.white),
          const SizedBox(height: 15),
          Expanded(
            flex: 6,
            child: ListView(
              shrinkWrap: true,
              children: [
                _menu(0, Icons.home, 'Company'),
                _menu(1, Icons.search, 'Explore'),
                _menu(2, Icons.notifications, 'Notifications'),
                _menu(3, Icons.mail, 'Messages'),
                _menu(4, Icons.person, 'Profile'),
              ],
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.ac_unit, color: Colors.white70, size: 35),
                const SizedBox(width: 10),
                Text('Tenderfarm', style: TextStyle(color: Colors.white.withOpacity(.85), fontSize: 20.0))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _menu(int index, IconData icon, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  if (mounted)
                    setState(() {
                      tabActive = index;
                    });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: SizedBox(
                    height: 30,
                    child: Row(
                      children: [
                        Icon(icon, color: Colors.white70, size: 28),
                        const SizedBox(width: 15),
                        Text(
                          text,
                          style: TextStyle(fontSize: 18.0, color: tabActive == index ? Colors.white : Colors.white60),
                        ),
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
                    ),
                  ),
                ),
              ),
            ),
            if (tabActive == index)
              Positioned(
                left: -20,
                child: Container(
                  height: 40,
                  width: 4,
                  decoration: BoxDecoration(
                    color: Colors.amber[600],
                    borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
                  ),
                ),
              )
          ],
        ),
        if (tabActive == index && index == 1)
          Padding(
            padding: const EdgeInsets.only(left: 45),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _subMenu(0, 'Latest Tenders'),
                _subMenu(1, 'Best Tenders'),
                _subMenu(2, 'Team Search'),
              ],
            ),
          ),
      ],
    );
  }

  Widget _subMenu(int index, String text) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (mounted)
              setState(() {
                subMenuActive = index;
              });
          },
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              text,
              style: TextStyle(fontSize: 16.0, color: subMenuActive == index ? Colors.white : Colors.white60),
            ),
          ),
        ),
      );

  Widget _profile() {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 40,
          backgroundImage: NetworkImage(
            'https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixid=MXwxMjA3fDB8MHxzZWFyY2h8M3x8cGVyc29ufGVufDB8fDB8&ixlib=rb-1.2.1&w=1000&q=80',
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'David',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ],
    );
  }
}
