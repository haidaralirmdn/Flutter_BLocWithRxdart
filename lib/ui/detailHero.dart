import 'package:bloc_hero/blocs/bloc.dart';
import 'package:bloc_hero/models/detailSuperHeroModel.dart';
import 'package:flutter/material.dart';

class DetailHeroPage extends StatefulWidget {

  @override
  _DetailHeroPageState createState() => _DetailHeroPageState();
}

class _DetailHeroPageState extends State<DetailHeroPage> {

  @override
  void initState() {
    super.initState();
    bloc.fetchDetail();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Hero'),
      ),
      body: StreamBuilder(
          stream: bloc.detailData,
          builder: (context, AsyncSnapshot<DetailSuperHeroModel> snapShot) {
            if (snapShot.hasData) {
              return _buildUserWidget(snapShot.data);
            } else if (snapShot.hasError) {
              return _buildErrorWidget(snapShot.error);
            } else {
              return _buildLoadingWidget();
            }
          },
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Error occured: $error", style: Theme.of(context).textTheme.subtitle),
          ],
        ));
  }
  Widget _buildUserWidget(DetailSuperHeroModel hero) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(hero.images.sm),
            ),
            Text(
              "${hero.name}",
              style: Theme.of(context).textTheme.title,
            ),
            Text(hero.biography.fullName, style: Theme.of(context).textTheme.subtitle),
            Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            Text(hero.biography.publisher, style: Theme.of(context).textTheme.body1),
          ],
        ));
  }
  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Loading data from API...",
                style: Theme.of(context).textTheme.subtitle),
            Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),)
          ],
        ));
  }
}
