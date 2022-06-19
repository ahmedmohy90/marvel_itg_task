import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:marvel_task/model/character_comics.dart';
import 'package:marvel_task/model/character_events_model.dart';
import 'package:marvel_task/model/character_series_model.dart';
import 'package:marvel_task/model/character_storeis_model.dart';
import 'package:marvel_task/model/characters.dart';
import 'package:marvel_task/presentation/assets_manager.dart';
import 'package:marvel_task/presentation/color_manager.dart';
import 'package:marvel_task/presentation/font_manager.dart';
import 'package:marvel_task/presentation/style_manager.dart';
import 'package:marvel_task/presentation/values_manager.dart';
import 'package:marvel_task/provider/character_details_provoders/comics_provider.dart';
import 'package:marvel_task/provider/character_details_provoders/events_provider.dart';
import 'package:marvel_task/provider/character_details_provoders/series_provider.dart';
import 'package:marvel_task/provider/character_details_provoders/stories_provider.dart';
import 'package:marvel_task/utilities/common_fns.dart';
import 'package:marvel_task/widgets/character_details_screen/comics_widget.dart';
import 'package:marvel_task/widgets/character_details_screen/events_widget.dart';
import 'package:marvel_task/widgets/character_details_screen/series_widget.dart';
import 'package:marvel_task/widgets/character_details_screen/stories_widget.dart';
import 'package:provider/provider.dart';

import '../presentation/string_manager.dart';
import '../provider/character_provider.dart';
import '../utilities/dialog_helper.dart';
import '../widgets/character_details_screen/shader_mask.dart';

class CharacterDetailsScreen extends StatefulWidget {
  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);
  final Character character;

  @override
  State<CharacterDetailsScreen> createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  bool _isInit = true;

  bool _isLoading = false;
  int _comicsPageNumber = 0;
  int _eventsPageNumber = 0;
  int _seriesPageNumber = 0;
  int _storiesPageNumber = 0;

  bool _isLoadingMorePagesComics = false;
  bool _isLoadingMorePagesEvents = false;
  bool _isLoadingMorePagesSeries = false;
  bool _isLoadingMorePagesStories = false;

  ScrollController _comicsScrollController = ScrollController();
  ScrollController _eventsScrollController = ScrollController();
  ScrollController _seriesScrollController = ScrollController();
  ScrollController _storiesScrollController = ScrollController();

  List<ComicsModel>? _comics = [];

  List<EventsModel>? _events = [];

  List<SeriesModel> _series = [];

  List<StoresModel> _stories = [];

  
    
  void comicsListener(){
    if (_comicsScrollController.offset >= _comicsScrollController.position.maxScrollExtent &&
        !_comicsScrollController.position.outOfRange) {
        _comicsPageNumber++;
        fetchCharacterComics();
  }
  }
    void seriesListener(){
    if (_seriesScrollController.offset >= _seriesScrollController.position.maxScrollExtent &&
        !_seriesScrollController.position.outOfRange) {
        _seriesPageNumber++;
        fetchCharacterSeries();
  }
  } 
   void storiesListener(){
    if (_storiesScrollController.offset >= _storiesScrollController.position.maxScrollExtent &&
        !_storiesScrollController.position.outOfRange) {
        _storiesPageNumber++;
        fetchCharacterStories();
  }
  }
  void eventsListener(){
    if (_eventsScrollController.offset >= _eventsScrollController.position.maxScrollExtent &&
        !_eventsScrollController.position.outOfRange) {
        _eventsPageNumber++;
        fetchCharacterEvents();
  }
  }
  
  
  @override
  void initState() {
    super.initState();
    _comicsScrollController.addListener(() {
      comicsListener();
      });

        _eventsScrollController.addListener(() {
      comicsListener();
      });

       _seriesScrollController.addListener(() {
      seriesListener();
      });

       _storiesScrollController.addListener(() {
      storiesListener();
      });
  
  }

Future<void> fetchCharacterComics([bool isFirstLoad = false]) async {
    if (isFirstLoad) {
      _comicsPageNumber = 0;
      setState(() {
        _isLoading = true;
      });
    } else {
      setState(() {
        _isLoadingMorePagesComics = true;
      });
    }
    try {
      await Provider.of<ComicsProvider>(context, listen: false).fetchCharacters(
          widget.character.id.toString(), _comicsPageNumber.toString());

      var list = Provider.of<ComicsProvider>(context, listen: false)
          .charactersComicsModel
          .data
          .results;
      _comics!.addAll(list);
      print(_comics);
      setState(() {
        _isLoadingMorePagesComics = false;
        _isLoading = false;
      });
    } on HttpException catch (error) {
      ShowDialogHelper.showErrorMessage(error.message, context);
    } on SocketException catch (error) {
      ShowDialogHelper.showErrorMessage(error.message, context);
    } catch (error) {
      ShowDialogHelper.showErrorMessage(AppStrings.responseError, context);
    }
    setState(() {
      _isLoadingMorePagesComics = false;
      _isLoading = false;
    });
  }

Future<void> fetchCharacterEvents([bool isFirstLoad = false]) async {
    if (isFirstLoad) {
      _eventsPageNumber = 0;
      setState(() {
        _isLoading = true;
      });
    } else {
      setState(() {
        _isLoadingMorePagesEvents = true;
      });
    }
    try {
      await Provider.of<EventsProvider>(context, listen: false).fetchEventsCharacters(
          widget.character.id.toString(), _eventsPageNumber.toString());

      var list = Provider.of<EventsProvider>(context, listen: false)
          .charactersEventsModel
          .data
          .results;
      _events!.addAll(list);
      print(_events);
      setState(() {
        _isLoadingMorePagesEvents = false;
        _isLoading = false;
      });
    } on HttpException catch (error) {
      ShowDialogHelper.showErrorMessage(error.message, context);
    } on SocketException catch (error) {
      ShowDialogHelper.showErrorMessage(error.message, context);
    } catch (error) {
      ShowDialogHelper.showErrorMessage(AppStrings.responseError, context);
    }
    setState(() {
      _isLoadingMorePagesEvents = false;
      _isLoading = false;
    });
  }

Future<void> fetchCharacterSeries([bool isFirstLoad = false]) async {
    if (isFirstLoad) {
      _seriesPageNumber = 0;
      setState(() {
        _isLoading = true;
      });
    } else {
      setState(() {
        _isLoadingMorePagesSeries = true;
      });
    }
    try {
      await Provider.of<SeriesProvider>(context, listen: false).fetchSeriesCharacters(
          widget.character.id.toString(), _seriesPageNumber.toString());

      var list = Provider.of<SeriesProvider>(context, listen: false)
          .charactersSeriesModel
          .data
          .results;
      _series.addAll(list);
      print(_series);
      setState(() {
        _isLoadingMorePagesSeries = false;
        _isLoading = false;
      });
    } on HttpException catch (error) {
      ShowDialogHelper.showErrorMessage(error.message, context);
    } on SocketException catch (error) {
      ShowDialogHelper.showErrorMessage(error.message, context);
    } catch (error) {
      ShowDialogHelper.showErrorMessage(AppStrings.responseError, context);
    }
    setState(() {
      _isLoadingMorePagesSeries = false;
      _isLoading = false;
    });
  }

Future<void> fetchCharacterStories([bool isFirstLoad = false]) async {
    if (isFirstLoad) {
      _storiesPageNumber = 0;
      setState(() {
        _isLoading = true;
      });
    } else {
      setState(() {
        _isLoadingMorePagesStories = true;
      });
    }
    try {
      await Provider.of<StoriesProvider>(context, listen: false).fetchStoriesCharacters(
          widget.character.id.toString(), _storiesPageNumber.toString());

      var list = Provider.of<StoriesProvider>(context, listen: false)
          .charactersStoriesModel
          .data
          .results;
      _stories.addAll(list);
      print(_stories);
      setState(() {
        _isLoadingMorePagesStories = false;
        _isLoading = false;
      });
    } on HttpException catch (error) {
      ShowDialogHelper.showErrorMessage(error.message, context);
    } on SocketException catch (error) {
      ShowDialogHelper.showErrorMessage(error.message, context);
    } catch (error) {
      ShowDialogHelper.showErrorMessage(AppStrings.responseError, context);
    }
    setState(() {
      _isLoadingMorePagesStories = false;
      _isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      fetchCharacterComics(true);
      fetchCharacterEvents(true);
      fetchCharacterSeries(true);
      fetchCharacterStories(true);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _comicsScrollController.dispose();
    _eventsScrollController.dispose();
    _seriesScrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _isLoading
          ? progresBarWidget()
          : Stack(
           fit: StackFit.expand,
            children: [
               Image.network('${widget.character.thumbnail.path}.jpg', fit: BoxFit.fill,),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  decoration:  BoxDecoration(
                    color: Colors.black.withOpacity(0.8)
                  ),
                ),
                
              ),
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    elevation: 0,
                    backgroundColor: Colors.black.withOpacity(0.7),
                    expandedHeight: AppHeight.h182,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.network('${widget.character.thumbnail.path}.jpg', fit: BoxFit.cover,),
                      title: Text(widget.character.name, style: getBoldStyle(fontSize: FontSize.s14, color: ColorManager.primary),),
                      centerTitle: true,
                    ),
                  ),
                     SliverToBoxAdapter(
                       child: SingleChildScrollView(
                                       child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.stretch,
                                         children: <Widget>[
                        // ShaderMaskWidget.fromUrl(
                        //     imageUrl: '${widget.character.thumbnail.path}.jpg',
                        //     name: widget.character.name),
                        SizedBox(
                          height: AppHeight.h24,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: AppWidth.w8),
                          child: Text(
                            AppStrings.charDescription,
                            style: getBoldStyle(
                                fontSize: FontSize.s15,
                                color: ColorManager.secondPrimaryColor),
                          ),
                        ),
                        SizedBox(
                          height: AppHeight.h8,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: AppWidth.w8),
                          child: Text(
                            widget.character.description == ""
                            ?AppStrings.charNoDescription
                            :widget.character.description,
                            style: getRegularStyle(
                                fontSize: FontSize.s13, color: ColorManager.primary),
                          ),
                        ),
                        SizedBox(
                          height: AppHeight.h24,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: AppWidth.w8),
                          child: Text(
                            AppStrings.charComics,
                            style: getBoldStyle(
                                fontSize: FontSize.s15,
                                color: ColorManager.secondPrimaryColor),
                          ),
                        ),
                        SizedBox(
                          height: AppHeight.h8,
                        ),
                        Container(
                          height: AppHeight.h178,
                          margin: EdgeInsets.symmetric(horizontal: AppWidth.w8),
                          child: _comics!.isEmpty
                              ? Center(
                                  child: Text(
                                  AppStrings.charNoComics,
                                  style: getBoldStyle(
                                      fontSize: FontSize.s15,
                                      color: ColorManager.primary),
                                ))
                              : Row(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      controller: _comicsScrollController,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _comics!.length,
                                        itemBuilder: ((context, index) {
                                          return ComicsWidget(comic: _comics![index],comics:_comics!);
                                        }),
                                      ),
                                  ),
                                  _isLoadingMorePagesComics
                                  ?progresBarWidget()
                                  :const SizedBox.shrink()
                                ],
                              ),
                        ),
                        SizedBox(
                          height: AppHeight.h24,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: AppWidth.w8),
                          child: Text(
                            AppStrings.charEvents,
                            style: getBoldStyle(
                                fontSize: FontSize.s15,
                                color: ColorManager.secondPrimaryColor),
                          ),
                        ),
                        SizedBox(
                          height: AppHeight.h8,
                        ),
                       Container(
                          height: AppHeight.h178,
                          margin: EdgeInsets.symmetric(horizontal: AppWidth.w8),
                          child: _events!.isEmpty
                              ? Center(
                                  child: Text(
                                  AppStrings.charNoEvents,
                                  style: getBoldStyle(
                                      fontSize: FontSize.s15,
                                      color: ColorManager.primary),
                                ))
                              : Row(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      controller: _eventsScrollController,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _events!.length,
                                        itemBuilder: (context, index) {
                                          return EventsWidget(event: _events![index],enevnts: _events!,);
                                        },
                                      ),
                                  ),
                                  _isLoadingMorePagesEvents
                                  ?progresBarWidget()
                                  :const SizedBox.shrink()
                                ],
                              ),
                        ),
                         SizedBox(
                          height: AppHeight.h24,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: AppWidth.w8),
                          child: Text(
                            AppStrings.charSeries,
                            style: getBoldStyle(
                                fontSize: FontSize.s15,
                                color: ColorManager.secondPrimaryColor),
                          ),
                        ),
                        SizedBox(
                          height: AppHeight.h8,
                        ),
                       Container(
                          height: AppHeight.h178,
                          margin: EdgeInsets.symmetric(horizontal: AppWidth.w8),
                          child: _series.isEmpty
                              ? Center(
                                  child: Text(
                                  AppStrings.charNoSeries,
                                  style: getBoldStyle(
                                      fontSize: FontSize.s15,
                                      color: ColorManager.primary),
                                ))
                              : Row(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      controller: _seriesScrollController,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _series.length,
                                        itemBuilder: (context, index) {
                                          return SeriesWidget(series: _series[index], seriesList: _series,);
                                        },
                                      ),
                                  ),
                                  _isLoadingMorePagesSeries
                                  ?progresBarWidget()
                                  :const SizedBox.shrink()
                                ],
                              ),
                        ),
                       SizedBox(
                          height: AppHeight.h24,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: AppWidth.w8),
                          child: Text(
                            AppStrings.charStories,
                            style: getBoldStyle(
                                fontSize: FontSize.s15,
                                color: ColorManager.secondPrimaryColor),
                          ),
                        ),
                        SizedBox(
                          height: AppHeight.h8,
                        ),
                       Container(
                          height: AppHeight.h178,
                          margin: EdgeInsets.symmetric(horizontal: AppWidth.w8),
                          child: _stories.isEmpty
                              ? Center(
                                  child: Text(
                                  AppStrings.charNoStories,
                                  style: getBoldStyle(
                                      fontSize: FontSize.s15,
                                      color: ColorManager.primary),
                                ))
                              : Row(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      controller: _storiesScrollController,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _stories.length,
                                        itemBuilder: (context, index) {
                                          return StoriesWidget(stories: _stories[index],storiesList: _stories,);
                                        },
                                      ),
                                  ),
                                  _isLoadingMorePagesStories
                                  ?progresBarWidget()
                                  :const SizedBox.shrink()
                                ],
                              ),
                        ),
                        SizedBox(
                          height: AppHeight.h24,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: AppWidth.w8),
                          child: Text(
                            AppStrings.relatedLinks,
                            style: getBoldStyle(
                                fontSize: FontSize.s15,
                                color: ColorManager.secondPrimaryColor),
                          ),
                        ),
                        SizedBox(height: AppHeight.h16,),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: AppWidth.w8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppStrings.details,
                                style: getBoldStyle(fontSize: FontSize.s18, color: ColorManager.primary,),
                              ),
                                Icon( Icons.arrow_forward_ios, color: ColorManager.primary,)
                            ],
                          ),
                        ),
                        SizedBox(height: AppHeight.h16,),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: AppWidth.w8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppStrings.wiki,
                                style: getBoldStyle(fontSize: FontSize.s18, color: ColorManager.primary,),
                              ),
                                Icon( Icons.arrow_forward_ios, color: ColorManager.primary,)
                            ],
                          ),
                        ),
                        SizedBox(height: AppHeight.h16,),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: AppWidth.w8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppStrings.comicsLink,
                                style: getBoldStyle(fontSize: FontSize.s18, color: ColorManager.primary,),
                              ),
                                Icon( Icons.arrow_forward_ios, color: ColorManager.primary,)
                            ],
                          ),
                        ),
                        SizedBox(height: AppHeight.h24,)
                         ],
                                       ),
                                     ),
                     ),
          
                ],
              )
             ],
          ),
    );
  }
}
