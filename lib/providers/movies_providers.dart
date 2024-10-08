import 'dart:convert';

import 'package:marvel/models/movies_model.dart';
import 'package:marvel/providers/base_provider.dart';
import 'package:marvel/services/api.dart';

class MoviesProviders extends BaseProvider {
  List<MoviesModel> movies = [];


  fetchMovies() async {

    setIsLoading(true);
    var data = await api.get("https://mcuapi.herokuapp.com/api/v1/movies");

    if (data.statusCode == 200) {
      setIsFaild(false);
      var decodeData = jsonDecode(data.body)["data"];
      movies= List<MoviesModel>.from(decodeData.map((e)=>MoviesModel.fromJson(e)));
    }
    else{
      setIsFaild(true);
    }

    setIsLoading(false);
  }
}
