// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:play_nuvem/src/features/cloud/cloud_state.dart';


import '../../shared/generated_id/generated_id.dart';
import '../../shared/models/cloud_model.dart';
import '../../shared/services/local_storage/i_local_storage.dart';

class CloudController extends ChangeNotifier {
  final ILocalStorage _localStorage;

   CloudController(
    this._localStorage,
  );

  CloudState _state = CloudInitialState();
  CloudState get state => _state;

  void changeState(CloudState newValue) {
    _state = newValue;
    notifyListeners();
  }
 

  List<Cloud> _listCloud = [];
  List<Cloud> get listCloud {
    return _listCloud;
  }

  Future<void> loadListCloud() async{
    changeState(CloudLoadingState());
    try {
       String result = await _localStorage.getString('listCloud');

      // Converte json em List<Cloud>
      if(result.isNotEmpty) {
         _listCloud = CloudModel.fromJson(result).list;
        changeState(CloudSuccessState());
      } else {
        changeState(CloudSuccessState());
      }
           
     

    } catch (error, StackTrace) {
      print("Exception occured: $error by $StackTrace");
      changeState(CloudErrorState());
    }
  }

  Future<bool?> saveCloud(Cloud cloud) async{
    try {
    bool hasId = cloud.id != null;
    if (hasId) {
      var result = await _updateCloud(cloud);
     changeState(CloudSuccessState());
      return result;
    } else {
      var result = await _addCloud(cloud);
      changeState(CloudSuccessState());
      return result;
      
    }
      
    } catch (error, StackTrace) {
      print("Exception occured: $error by $StackTrace");
    }
  }

  

  Future<bool> _addCloud(Cloud cloud) async {
    // Atribuir id no novo Objeto CloudModel
    if(_listCloud.isNotEmpty) {
      cloud.id = GeneratedId.generateId(_listCloud);

      _listCloud.add(cloud);
    //Converte lista nova para json e salva no local storage
      String json = CloudModel(_listCloud).toJson();
      return await _localStorage.saveString('listCloud', json);
      
    } else {
      await loadListCloud();
       cloud.id = GeneratedId.generateId(_listCloud);

      _listCloud.add(cloud);
    //Converte lista nova para json e salva no local storage
      String json = CloudModel(_listCloud).toJson();
      return await _localStorage.saveString('listCloud', json);
      
    }
  }

  Future<bool> _updateCloud(Cloud cloud) async {
    // Pegar index da cloud na lista
    if (_listCloud.isNotEmpty) {
      var index = _listCloud.indexWhere((element) => element.id == cloud.id);
      // Substituir cloud na list
      _listCloud[index] = cloud;
      //Converte lista nova para json e salva no local storage
       String json = CloudModel(_listCloud).toJson();
      return await _localStorage.saveString('listCloud', json);
    } else {
      await loadListCloud();
      var index = _listCloud.indexWhere((element) => element.id == cloud.id);
      // Substituir cloud na list
      _listCloud[index] = cloud;
      //Converte lista nova para json e salva no local storage
      String json = CloudModel(_listCloud).toJson();
      return await _localStorage.saveString('listCloud', json);
    }
  }

  Future<bool> removeCloud(Cloud cloud) async{
     // Pegar index da cloud na lista
    if (_listCloud.isNotEmpty) {
      var index = _listCloud.indexWhere((element) => element.id == cloud.id);
      // Remover cloud da list
      _listCloud.removeAt(index);
      //Converte lista nova para json e salva no local storage
      String json = CloudModel(_listCloud).toJson();
      var result = await _localStorage.saveString('listCloud', json);
      changeState(CloudSuccessState());
      return result;
    } else {
      await loadListCloud();
      var index = _listCloud.indexWhere((element) => element.id == cloud.id);
      // Remover cloud da list
      _listCloud.removeAt(index);
      //Converte lista nova para json e salva no local storage
     String json = CloudModel(_listCloud).toJson();
     var result = await _localStorage.saveString('listCloud', json);
      changeState(CloudSuccessState());
      return result;
    }
  } 
  
}
