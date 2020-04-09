import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yyets/model/RRUser.dart';
import 'package:flutter_yyets/ui/pages/SearchPage.dart';
import 'package:flutter_yyets/utils/toast.dart';

import 'RankPage.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("排名"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchPageDelegate());
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: RankPage(),
      drawer: HomeDrawer(),
    );
  }
}

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: MediaQuery.removePadding(
          removeTop: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Color.fromARGB(0, 0, 0, 0),
                child: Image.network("https://flutter.cn/favicon.ico"),
              ),
              Expanded(
                child: ListView(children: [
                  ListTile(
                    leading: Icon(Icons.adb),
                    title: Text("我的收藏"),
                    onTap: () {
                      if (RRUser.isLogin) {
                        Navigator.pushNamed(context, "/favorites");
                      } else {
                        showToast("请先登录");
                        Navigator.pushNamed(context, "/login");
                      }
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.adb),
                    title: Text("边下边播"),
                    onTap: () {},
                  )
                ]),
              )
            ],
          ),
          context: context,
        ));
  }
}
