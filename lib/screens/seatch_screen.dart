import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marvel_task/presentation/assets_manager.dart';
import 'package:marvel_task/presentation/color_manager.dart';
import 'package:marvel_task/presentation/font_manager.dart';
import 'package:marvel_task/presentation/string_manager.dart';
import 'package:marvel_task/presentation/style_manager.dart';
import 'package:marvel_task/presentation/values_manager.dart';
import 'package:marvel_task/utilities/common_fns.dart';
import 'package:marvel_task/widgets/character_screen_widgets/divider_widget.dart';
import 'package:marvel_task/widgets/search/search_widget.dart';
import 'package:provider/provider.dart';
import 'package:retry/retry.dart';

import '../model/characters.dart';
import '../provider/search_provider.dart';
import '../utilities/dialog_helper.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchTxt= '';
  String checkSearchText = '';
  final _searchController = TextEditingController();
  int _pageNumber = 1;
  bool _firstLoading = false;
  ScrollController _scrollController = ScrollController();
  bool isEmptySearch =true;
  bool _isEndOfResult = false;
  bool _isLoadingMorePages = false;

  CharactersModel? _searchCharResult;
  List<Character> _serchResult = [];
  Future<void> fetchSearchResult([bool isFirstLoad = false]) async
  {
     if (isFirstLoad) {
      _pageNumber = 1;
     
    }
    setState(() {
     _isLoadingMorePages = true;
    });
   try{
     if(isFirstLoad) {
       setState(() {
        _firstLoading = true;
      });
     }
     if(checkSearchText !=  _searchTxt){
       _serchResult = [];
     }
    await Provider.of<SearchProvider>(context, listen: false).fetchSearch(_pageNumber.toString(),_searchTxt);
    var list  = Provider.of<SearchProvider>(context, listen: false).searchCharacters.data.results;
   
    _serchResult.addAll(list);
     setState(() {
       
        _isEndOfResult = false;
        _firstLoading = false;
        _isLoadingMorePages = false;
     
    });
                  checkSearchText =  _searchTxt;
   }on HttpException catch (error) {
      print(error.message);

      ShowDialogHelper.showErrorMessage(error.message, context,);
    
      setState(() {
    _firstLoading = false;
            _isLoadingMorePages = false;

      });
    } on SocketException catch (error) {
      print('socketException');

      ShowDialogHelper.showErrorMessage(error.message, context,);
 setState(() {
    _firstLoading = false;
            _isLoadingMorePages = false;

      });
    }catch(error){
      
         ShowDialogHelper.showErrorMessage(AppStrings.responseError, context,);
   
        }
      if (mounted){
       setState(() {
    _firstLoading = false;
            _isLoadingMorePages = false;

      });
      }
      }
   


  

@override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _pageNumber++;
        fetchSearchResult();
      }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
   
    _searchController.dispose();
    _scrollController.dispose();
     super.dispose();
  }
  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      backgroundColor: ColorManager.searchBGColor,
      extendBodyBehindAppBar: true,
      body:SafeArea(
        child: 
       
        Column(
          
          children: [
            Container(
              height: AppHeight.h70,
              color: ColorManager.black,
              child: Center(
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: AppWidth.w8,),
                    Expanded(
                      child: Container(
                        height: AppHeight.h48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppWidth.w12),
                          color: ColorManager.primary,
                        ),
                        
                        child: TextFormField(
                             controller: _searchController,
              onChanged: (value){
               setState(() {
                  _searchTxt = value;
               });
               if(_searchTxt == ''){
                 setState(() {
                 isEmptySearch = true;
               });
               }
              },
              onFieldSubmitted: (value){
                _searchTxt = value;
      
                fetchSearchResult(true);
                FocusScope.of(context).unfocus();
               setState(() {
                 isEmptySearch = false;
               });
              },
      
              cursorColor:ColorManager.secondPrimaryColor,
               cursorWidth: 2,
              // cursorHeight: heightHelpler(16.0, context),
              key: const ValueKey('search'),
              style: Theme.of(context).textTheme.headline5,
              textInputAction: TextInputAction.search,
              
              focusNode: null,
              decoration: InputDecoration(
                hintText: AppStrings.searchHintText,
                hintStyle:getRegularStyle(fontSize: FontSize.s14, color: ColorManager.lightGrayColor),
                suffixIcon: 
                _searchTxt == ''
                ? const SizedBox.shrink()
                :GestureDetector(
                  onTap: (){
                    _searchTxt = '';
                    _searchController.clear();
                   
               setState(() {
                _firstLoading =false;
                isEmptySearch = true;
               });
                    FocusScope.of(context).unfocus();
                  },
                  child:   Icon(Icons.close, color: ColorManager.lightGrayColor, )
                  
                ),
               isDense: true, 
            
                border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
                
              ),
              validator: (value) {},
              keyboardType: TextInputType.text,
            
                        ),
                      ),
                    ),
                    SizedBox(width: AppWidth.w8,),
                    GestureDetector(
                      onTap: (){
                        popScreen(context);
                      },
                      child: Text(AppStrings.cancelText,style: getSemiBoldStyle(fontSize: FontSize.s14, color: ColorManager.secondPrimaryColor,)
                      ,),
                    ),
                    SizedBox(width: AppWidth.w8,),
        
                  ],
                ),
              ),
            ), isEmptySearch
        ? Container()

        :_firstLoading
        ?  Center(child: progresBarWidget())
      
        :_serchResult.isEmpty
        ?Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              SizedBox(
                height: AppHeight.h24,
              ),
              Text(AppStrings.noSearchFound, style: getBoldStyle(fontSize: FontSize.s18, color: ColorManager.white),),
              Text(_searchTxt, style: getBoldStyle(fontSize: FontSize.s18, color: ColorManager.white))
              
            ],
          ),
        )
        :
             Expanded(child: 
             ListView.separated(
               itemBuilder: (ctx, i){
                 return SearchWidget(character: _serchResult[i]);
                      }, 
               separatorBuilder:(ctx, i)=>  DividerWidget(color: ColorManager.lightGrayColor),
               itemCount: _serchResult.length
               )
             )
          ],
        ),
      )
      
      );
    
       
    
  }
}


       
