import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:marvel_task/model/character_comics.dart';
import 'package:marvel_task/model/character_series_model.dart';

import '../../model/character_events_model.dart';
import '../../utilities/constants/url.dart';

class SeriesProvider with ChangeNotifier
{
  CharactersSeriesModel? _charactersSeriesModel;

  CharactersSeriesModel get charactersSeriesModel
  {
    return _charactersSeriesModel!;
  }

   Future<void> fetchSeriesCharacters(String id,String page) async{
    try 
    {
      final url =
       Urls.getAllSeries(id,page);
    
      final response =await http.get(Uri.parse(url));
       
      print('response is: ');
      print(json.decode(response.body));
      final responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode == 200) {
       
         final listOfSeries = json.decode(response.body);
        
            final mappedSeries = CharactersSeriesModel.fromJson(listOfSeries);
        _charactersSeriesModel = mappedSeries;
       
      } else {
        print(responseData['message']);
        print(response.statusCode);
        throw HttpException(responseData['message']);
      }
    } catch (error) {
      throw error;
    }
    notifyListeners();
  }


 }