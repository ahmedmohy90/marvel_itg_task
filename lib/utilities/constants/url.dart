import 'package:marvel_task/utilities/marvel_client_constants/marvel_client.dart';

import '../../presentation/string_manager.dart';

class Urls {

static bool isProd= false;
// staging domain url
static String stageDomain = "https://gateway.marvel.com:443/v1/public/";

//production domain url
static String prodDomain = "https://gateway.marvel.com:443/v1/public/";
static String ulrDomain() {
  if(isProd){
    return prodDomain;
  }else{
    return stageDomain;
  }
}
static String getAllCharacters(String offset){
  return 
    '${ulrDomain()}${AppStrings.getAllCharacters}?offset=$offset&apikey=${MarvelClientConfig.apiKey}&hash=${MarvelClientConfig.hash}&ts=${MarvelClientConfig.ts}&limit=${MarvelClientConfig.pageLimit}';
}

static String getAllComics(String id,String offset){
  return 
    '${ulrDomain()}${AppStrings.getAllCharacters}/$id/${AppStrings.getAllComics}?offset=$offset&apikey=${MarvelClientConfig.apiKey}&hash=${MarvelClientConfig.hash}&ts=${MarvelClientConfig.ts}&limit=${MarvelClientConfig.pageLimit2}';
}

static String getAllEvents(String id,String offset){
  return 
    '${ulrDomain()}${AppStrings.getAllCharacters}/$id/${AppStrings.getAllEvents}?offset=$offset&apikey=${MarvelClientConfig.apiKey}&hash=${MarvelClientConfig.hash}&ts=${MarvelClientConfig.ts}&limit=${MarvelClientConfig.pageLimit2}';
}
static String getAllSeries(String id,String offset){
  return 
    '${ulrDomain()}${AppStrings.getAllCharacters}/$id/${AppStrings.getAllSeries}?offset=$offset&apikey=${MarvelClientConfig.apiKey}&hash=${MarvelClientConfig.hash}&ts=${MarvelClientConfig.ts}&limit=${MarvelClientConfig.pageLimit2}';
}

static String getAllStories(String id,String offset){
  return 
    '${ulrDomain()}${AppStrings.getAllCharacters}/$id/${AppStrings.getAllStories}?offset=$offset&apikey=${MarvelClientConfig.apiKey}&hash=${MarvelClientConfig.hash}&ts=${MarvelClientConfig.ts}&limit=${MarvelClientConfig.pageLimit2}';
}
static String searchByName(String offset,String searchText){
  return 
    '${ulrDomain()}${AppStrings.getAllCharacters}?${AppStrings.nameStartsWith}=$searchText&offset=$offset&apikey=${MarvelClientConfig.apiKey}&hash=${MarvelClientConfig.hash}&ts=${MarvelClientConfig.ts}&limit=${MarvelClientConfig.pageLimit}';
}
}