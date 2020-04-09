import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yyets/app/Api.dart';
import 'package:flutter_yyets/ui/widgets/MoviesGridWidget.dart';

class RankPage extends StatefulWidget {
  @override
  State createState() => _RankPageState();
}

class _RankPageState extends State<RankPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 6, vsync: this);
  }

  Future _refresh = Api.loadRank();

  void refresh() {
    setState(() {
      _refresh = Api.loadRank();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _refresh,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (!snapshot.hasError) {
            return _body(snapshot.data);
          } else {
            return Center(
              child: FlatButton(
                child: Text("加载失败，点击重试"),
                onPressed: () => refresh(),
              ),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _body(Map<String, dynamic> data) {
    return Column(
      children: <Widget>[
        Container(
          height: 45,
          child: TabBar(
            controller: _controller,
            tabs: <Widget>[
              Tab(text: "今日"),
              Tab(text: "本月"),
              Tab(text: "电影"),
              Tab(text: "新剧"),
              Tab(text: "日剧"),
              Tab(text: "全部"),
            ],
          ),
        ),
        Flexible(
            child: TabBarView(
          controller: _controller,
          children: <Widget>[
            RefreshIndicator(
                onRefresh: () async => refresh(),
                child: MoviesGridWidget(data["today_list"])),
            MoviesGridWidget(data["month_list"]),
            MoviesGridWidget(data["movie_list"]),
            MoviesGridWidget(data["new_list"]),
            MoviesGridWidget(data["japan_list"]),
            MoviesGridWidget(data["total_list"]),
          ],
        ))
      ],
    );
  }
}
