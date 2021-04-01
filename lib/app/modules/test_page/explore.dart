import 'package:flutter/material.dart';

import 'local_data.dart';

// tab and mobile < web sizing 1024  < web > 1500 web sizing
class Explore extends StatefulWidget {
  const Explore({Key key}) : super(key: key);

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isWeb1400 = size.width >= 1400;
    bool isWeb2000 = size.width >= 2000;
    bool isWeb1024 = size.width <= 1024;
    bool isWeb900 = size.width <= 900;
    bool isWeb770 = size.width <= 770;
    bool isWeb500 = size.width <= 500;
    bool isWeb600 = size.width <= 600 && !isWeb500;
    return Expanded(
      flex: isWeb2000 || isWeb900
          ? 6
          : isWeb1400
              ? 5
              : isWeb1024
                  ? 3
                  : 4,
      child: Container(
        color: Colors.grey[100],
        padding: EdgeInsets.only(top: 25.0, left: isWeb500 ? .0 : 25.0, right: isWeb500 ? .0 : 25.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  if (!isWeb600 && !isWeb500) ...[
                    Text(
                      'Best Tenders',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.red,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text('5', style: TextStyle(color: Colors.white, fontSize: 12)),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Icon(Icons.notifications_none_rounded, color: Colors.grey[400]),
                        ],
                      ),
                    ),
                    const SizedBox(width: 30),
                  ],
                  Flexible(
                    flex: isWeb600 || isWeb500 ? 1 : 0,
                    child: Container(
                      height: 40,
                      width: isWeb600 || isWeb500
                          ? size.width
                          : !isWeb770
                              ? size.width / 3.5
                              : size.width / 2.5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(color: Colors.grey[200], blurRadius: 4, spreadRadius: 3, offset: Offset(0, 5))
                        ],
                      ),
                      padding: const EdgeInsets.all(4.0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey[300],
                            size: 30,
                          ),
                          hintText: 'Search',
                          isDense: true,
                          hintStyle: TextStyle(color: Colors.grey[400]),
                        ),
                        cursorColor: Colors.lightBlue,
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ),
                  ),
                  if (isWeb600 || isWeb500) ...[
                    const SizedBox(width: 15),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.red,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text('5', style: TextStyle(color: Colors.white, fontSize: 12)),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Icon(Icons.notifications_none_rounded, color: Colors.grey[400]),
                        ],
                      ),
                    ),
                  ],
                  if (!isWeb770) ...[const SizedBox(width: 30), _profile()],
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Scrollbar(
                controller: _scrollController,
                thickness: 5.0,
                child: GridView.builder(
                  controller: _scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: isWeb500
                        ? 1.25
                        : isWeb1024
                            ? 1
                            : .95,
                    // mainAxisExtent: 375,
                    // crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    crossAxisCount: isWeb2000
                        ? 6
                        : isWeb1400
                            ? 4
                            : isWeb1024 && !isWeb500
                                ? 2
                                : isWeb500
                                    ? 1
                                    : 3,
                  ),
                  itemCount: companies.length,
                  itemBuilder: (_, i) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: _companyCard(companies[i], isWeb600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _companyCard(Map<String, dynamic> data, bool isMobileLayout) {
    bool _onHover = false;
    return StatefulBuilder(builder: (context, state) {
      return InkWell(
        onTap: () {},
        onHover: (value) {
          state(() {
            _onHover = value;
          });
        },
        child: Transform.scale(
          scale: _onHover ? 1.025 : 1,
          child: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [BoxShadow(color: Colors.grey[200], blurRadius: 4, spreadRadius: 3, offset: Offset(0, 7.5))],
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    data['title'],
                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[600]),
                  ),
                ),
                Image.network(data['img'], height: isMobileLayout ? 50 : 100, width: isMobileLayout ? 50 : 100),
                Column(
                  children: [
                    Text(
                      data['time'],
                      style: TextStyle(
                        color: data['isActive'] ? Colors.orangeAccent.withOpacity(.75) : Colors.grey[300],
                        fontSize: isMobileLayout ? 22.0 : 30.0,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      data['desc'],
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.grey[600], fontSize: isMobileLayout ? 12.0 : 14.0),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _detailsCompany("${data['teams']}", "teams", isMobileLayout),
                    _detailsCompany("${data['budget']}", "budget", isMobileLayout),
                    _detailsCompany("${data['success']}", "success", isMobileLayout),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Column _detailsCompany(String value, String title, bool isMobileLayout) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(color: Colors.grey[400], fontSize: isMobileLayout ? 12.0 : 14.0),
        ),
      ],
    );
  }

  Widget _profile() {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixid=MXwxMjA3fDB8MHxzZWFyY2h8M3x8cGVyc29ufGVufDB8fDB8&ixlib=rb-1.2.1&w=1000&q=80',
            ),
          ),
          const SizedBox(width: 10),
          Text('David'),
        ],
      ),
    );
  }
}
