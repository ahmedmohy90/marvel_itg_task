import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:marvel_task/model/character_storeis_model.dart';

import '../../model/character_events_model.dart';
import '../../utilities/constants/url.dart';

class StoriesProvider with ChangeNotifier
{
  CharactersStoriesModel? _charactersStoriesModel;

  CharactersStoriesModel get charactersStoriesModel
  {
    return _charactersStoriesModel!;
  }

   Future<void> fetchStoriesCharacters(String id,String page) async{
    try 
    {
      final url =
       Urls.getAllStories(id,page);
    
      final response =await http.get(Uri.parse(url));
       
      print('response is: ');
      print(json.decode(response.body));
      final responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode == 200) {
       
         final listOfStories = json.decode(response.body);
        
            final mappedStories = CharactersStoriesModel.fromJson(listOfStories);
        _charactersStoriesModel = mappedStories;
       
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