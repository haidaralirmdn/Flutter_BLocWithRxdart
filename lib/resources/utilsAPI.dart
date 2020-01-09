import 'dart:async';
import 'package:bloc_hero/models/detailSuperHeroModel.dart';
import 'package:bloc_hero/models/superHeroModel.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UtilsAPI {
  Client client = Client();
  static final baseURL = 'https://akabab.github.io/superhero-api/api/';

  //GET HERO LIST
  Future<List<SuperHeroModel>> fetchHeroList() async {
    print('masuk');
    final response = await client.get(baseURL+'all.json');
    if(response.statusCode == 200){
      return compute(superHeroModelFromJson, response.body);
    } else {
      throw Exception('Failed to load');
    }
  }

  //GET DETAIL HERO
  Future<DetailSuperHeroModel> fetchDetailHero() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    print('masuk');
    final response = await client.get(baseURL+'id/'+sf.getInt('id').toString()+'.json');
    if(response.statusCode == 200){
      return compute(detailSuperHeroModelFromJson, response.body);
    } else {
      throw Exception('Failed to load');
    }
  }
}