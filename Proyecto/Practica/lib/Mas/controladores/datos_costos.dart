import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:untitled/Mas/modelos/Costos.dart';
import 'package:http/http.dart' as http;

class DatosCostos extends ChangeNotifier {
  String userUrl = 'http://192.168.18.13:3000/api/costos';

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<DataCostos>? costos = [];


  Future<List<DataCostos>?> fetchUsers() async {
    _isLoading = true;
    notifyListeners();

    final result = await http.get(Uri.parse(userUrl)).catchError((e) {
      print("Error Fetching Users" + e.toString());
    });


    if(result.statusCode == 200){
      Map<String, dynamic> _datos = json.decode(result.body);

      var _costos = _datos["Datos"];

      if (_costos != null) {
        costos = Costos.fromJson(_datos).datos;
      }

      _isLoading = false;
      notifyListeners();
      return costos;
    }
    else{
      _isLoading = false;
      notifyListeners();
      throw Exception('Error - ${result.statusCode}');
    }


  }
}