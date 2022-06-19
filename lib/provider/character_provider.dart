import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:marvel_task/model/characters.dart';
import 'package:marvel_task/utilities/constants/url.dart';

class CharacterProvider with ChangeNotifier
{


 CharactersModel? _characters;

  CharactersModel get characters{
    return _characters!;
  }

  Future<void> fetchCharacters(String page) async{
    try 
    {
      final url =
      // "https://gateway.marvel.com/v1/public/characters?offset=$page&apikey=e84610d6d97db0f0a28a9263fcfb003a&hash=6585fe5187cea41c28056c67e17ce293&ts=1&limit=20";
       Urls.getAllCharacters(page);
    
      final response =await http.get(Uri.parse(url));
       
      print('response is: ');
      print(json.decode(response.body));
      final responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode == 200) {
       
         final listOfCharacters = json.decode(response.body);
        
            final mappedCharacters = CharactersModel.fromJson(listOfCharacters) ;
        _characters = mappedCharacters;
       
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