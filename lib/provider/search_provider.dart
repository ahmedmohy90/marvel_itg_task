import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:retry/retry.dart';

import '../model/characters.dart';
import '../utilities/constants/url.dart';

class SearchProvider with ChangeNotifier
{

 CharactersModel? _searchCharacters;

  CharactersModel get searchCharacters{
    return _searchCharacters!;
  }



Future<void> fetchSearch(String page, String searchText) async
{
    final url = Urls.searchByName(page, searchText);
    try {
      final response = await retry(
        () => http.get(Uri.parse(url), 
        ).timeout(const Duration(seconds: 15)),
        retryIf: (e) => e is TimeoutException || e is SocketException,
        maxAttempts: 4,

      );
      print('response is: ');
      print(json.decode(response.body));
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
         final listOfCharacters = json.decode(response.body);
        
          final mappedSearch = CharactersModel.fromJson(listOfCharacters) ;
        _searchCharacters = mappedSearch;
      } else if (response.statusCode == 500) {
        print('server error');
        print(response.statusCode);
        throw const HttpException("Sorry, an unexpected error has occurred.");
      } else {
        print(json.decode(response.body)['detail']);
        print(response.statusCode);
        throw HttpException(responseData['message']);
      }
    } catch (error) {
      throw error;
    }
    notifyListeners();
  }
 
}