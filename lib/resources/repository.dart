import 'dart:async';
import 'package:bloc_hero/models/detailSuperHeroModel.dart';
import 'package:bloc_hero/models/superHeroModel.dart';
import 'utilsAPI.dart';

class Repository {
  final utilsApi = UtilsAPI();

  Future<List<SuperHeroModel>> fetchAllData() => utilsApi.fetchHeroList();
  Future<DetailSuperHeroModel> fetchDetailData() => utilsApi.fetchDetailHero();

}