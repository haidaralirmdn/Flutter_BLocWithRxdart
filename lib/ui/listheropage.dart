import 'dart:async';
import 'package:bloc_hero/blocs/bloc.dart';
import 'package:bloc_hero/ui/detailHero.dart';
import 'package:flutter/material.dart';
import 'package:bloc_hero/models/superHeroModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loadmore/loadmore.dart';

class ListHeroPage extends StatefulWidget {
  @override
  _ListHeroPageState createState() => _ListHeroPageState();
}

class _ListHeroPageState extends State<ListHeroPage> {

  var id = 1;

  @override
  void initState() {
    bloc.fetchAll();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutterBloc Hero List'),
      ),
      body: StreamBuilder(
        stream: bloc.allData,
        builder: (context, AsyncSnapshot<List<SuperHeroModel>> snapShot) {
          if (snapShot.hasData) {
            return buildList(snapShot);
          } else if (snapShot.hasError) {
            return Text(snapShot.error.toString());
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      )
    );
  }

  Widget buildList(AsyncSnapshot<List<SuperHeroModel>> snapShot) {
    return Container(
      child: LoadMore(
        isFinish: snapShot.data.length <= 10,
        onLoadMore: _loadMore,
        child: ListView.builder(
            itemCount: snapShot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () async {
                  id = snapShot.data[index].id;
                  saveID(id);
                  Navigator.of(context)
                      .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                    return new DetailHeroPage();
                  }));
                },
                leading: CircleAvatar(backgroundImage: NetworkImage(snapShot.data[index].images.sm),),
                title: Text(snapShot.data[index].name),
                subtitle: Text(snapShot.data[index].biography.fullName),
              );
            }),
      ),
    );
  }
}

Future<bool> saveID(int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('id', id);
  // ignore: deprecated_member_use
  return prefs.commit();
}

Future<bool> _loadMore() async {
  print("onLoadMore");
  await Future.delayed(Duration(seconds: 0, milliseconds: 100));
  return true;
}
