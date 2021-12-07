import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;
  final String restauranId;
  Restaurants? _restaurantList;

  RestaurantListProvider({required this.restauranId, required this.apiService}) {
    _listRestaurant();
  }

  Restaurants get restaurant => _restaurantList!;
  late ResultState _state;
  String _message = '';
  String get message => _message;
  ResultState get state => _state;
  late dynamic _listRestaurantResult;

  Future<dynamic> _listRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final listRestaurant = await apiService.listRestaurant();
      if (listRestaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantList = listRestaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> searchRestaurant(String query) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurantSearch = await apiService.restaurantSearch(query);
      if (restaurantSearch.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Hasil Pencarian Tidak ditemukan';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _listRestaurantResult = restaurantSearch.restaurants;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }
}