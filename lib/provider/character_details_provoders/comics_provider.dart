import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:marvel_task/model/character_comics.dart';

import '../../utilities/constants/url.dart';

class ComicsProvider with ChangeNotifier
{
  CharactersComicsModel? _charactersComicsModel;

  CharactersComicsModel get charactersComicsModel
  {
    return _charactersComicsModel!;
  }

   Future<void> fetchCharacters(String id,String page) async{
    try 
    {
      final url =
       Urls.getAllComics(id,page);
    
      final response =await http.get(Uri.parse(url));
       
      print('response is: ');
      print(json.decode(response.body));
      final responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode == 200) {
       
         final listOfcomics = json.decode(response.body);
        
            final mappedcomics = CharactersComicsModel.fromJson(listOfcomics);
        _charactersComicsModel = mappedcomics;
       
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