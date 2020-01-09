import 'package:bloc_hero/models/detailSuperHeroModel.dart';
import 'package:bloc_hero/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc_hero/models/superHeroModel.dart';

class Bloc {
  final _repository = Repository();
  final _fetcher = PublishSubject <List<SuperHeroModel>>();
  final _fetcherD = PublishSubject <DetailSuperHeroModel>();

  Observable<List<SuperHeroModel>> get allData => _fetcher.stream;
  Observable<DetailSuperHeroModel> get detailData => _fetcherD.stream;

  fetchAll() async {
    List<SuperHeroModel> superhero = await _repository.fetchAllData();
    _fetcher.sink.add(superhero);
  }

  fetchDetail() async {
    if(!_fetcherD.isClosed){
      DetailSuperHeroModel detail = await _repository.fetchDetailData();
      _fetcherD.sink.add(detail);
    }
    DetailSuperHeroModel detail = await _repository.fetchDetailData();
    _fetcherD.sink.add(detail);
  }

  dispose() async{
    _fetcher.close();
    await _fetcherD.drain();
    _fetcherD.close();
  }

}

final bloc = Bloc();