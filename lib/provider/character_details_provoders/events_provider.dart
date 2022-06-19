import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:marvel_task/model/character_comics.dart';

import '../../model/character_events_model.dart';
import '../../utilities/constants/url.dart';

class EventsProvider with ChangeNotifier
{
  CharactersEventsModel? _charactersEventsModel;

  CharactersEventsModel get charactersEventsModel
  {
    return _charactersEventsModel!;
  }

   Future<void> fetchEventsCharacters(String id,String page) async{
    try 
    {
      final url =
       Urls.getAllEvents(id,page);
    
      final response =await http.get(Uri.parse(url));
       
      print('response is: ');
      print(json.decode(response.body));
      final responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode == 200) {
       
         final listOfEvents = json.decode(response.body);
        
            final mappedEvents = CharactersEventsModel.fromJson(listOfEvents);
        _charactersEventsModel = mappedEvents;
       
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