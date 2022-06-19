import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:marvel_task/model/characters.dart';
import 'package:marvel_task/presentation/assets_manager.dart';
import 'package:marvel_task/provider/character_provider.dart';
import 'package:marvel_task/screens/character_details.dart';
import 'package:marvel_task/screens/seatch_screen.dart';
import 'package:provider/provider.dart';

import '../presentation/color_manager.dart';
import '../presentation/font_manager.dart';
import '../presentation/string_manager.dart';
import '../presentation/style_manager.dart';
import '../presentation/values_manager.dart';
import '../utilities/common_fns.dart';
import '../utilities/dialog_helper.dart';
import '../widgets/character_screen_widgets/character_card.dart';
import '../widgets/character_screen_widgets/divider_widget.dart';


class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  bool _isInit = true;

   bool _isLoading = false;
   int _pageNumber = 1;
   bool _isLoadingMorePages = false;

  ScrollController _scrollController = ScrollController(); 
  CharactersModel? charactersModel;
  List<Character>? _characters =[];

 @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
       
          _pageNumber++;
          fetchAllCharactersData();
        
      }
    });
  }
  Future<void> fetchAllCharactersData([bool isFirstLoad = false]) async {
    if (isFirstLoad) {
      _pageNumber = 0;
      setState(() {
        _isLoading = true;
      });
    } else {
      setState(() {
        _isLoadingMorePages = true;
      });
    }
    try {
      await Provider.of<CharacterProvider>(context, listen: false)
          .fetchCharacters(_pageNumber.toString());
           
         var list = Provider.of<CharacterProvider>(context, listen: false).characters.data.results;
        _characters!.addAll(list);
        setState(() {
        _isLoadingMorePages = false;
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
        _isLoadingMorePages = false;
        _isLoading = false;
      });
  }
  
  @override
  void didChangeDependencies() {
    if(_isInit){
      fetchAllCharactersData(true);
    }
    _isInit= false;
    super.didChangeDependencies();
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: _isLoading
            ? progresBarWidget()
            : _characters!.isEmpty
                ? Center(
                    child: Text(
                      AppStrings.emptyData,
                      style: getBoldStyle(
                          fontSize: FontSize.s15, color: ColorManager.white),
                    ),
                  )
                : SafeArea(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: AppHeight.h8,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: AppWidth.w8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox.shrink(),
                              Image.asset(AssetManager.logoImage),
                              GestureDetector(
                                onTap: (){
                                  navigateTo(context, const SearchScreen());
                                },
                                child: Image.asset(AssetManager.marvel_search)),
                              
                            ],
                          ),
                        ),
                        SizedBox(
                          height: AppHeight.h8,
                        ),
                        Expanded(
                            child: ListView.separated(
                                controller: _scrollController,
                                physics: const BouncingScrollPhysics(),
                                separatorBuilder: (ctx, i) =>  DividerWidget(color: ColorManager.black,),
                                itemCount: _characters!.length,
                                itemBuilder: (ctx, i) {
                                  return _characterWidget(_characters![i]);
                                })),
                        _isLoadingMorePages
                            ? progresBarWidget()
                            : const SizedBox.shrink(),
                       
                      ],
                    ),
                ),
 
    );
  }

    Widget _characterWidget(Character character) => GestureDetector(
        onTap: () {
        navigateTo(context, CharacterDetailsScreen(character: character,));
        },
        child: CharacterCard(character: character),
      );
}