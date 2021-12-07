import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static final String _list = 'list';
  static final String _detail = 'detail/';
  static final String _search = 'search?q=';
  static final String _Review = 'review';
  static final String imgUrl = 'https://restaurant-api.dicoding.dev/images/small/';

  Future<Restaurants> listRestaurant() async {
    final response = await http.get(Uri.parse(_baseUrl + _list ));
    if (response.statusCode == 200) {
      return Restaurants.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
  Future<RestaurantDetails> detailRestaurant(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + _detail + id));
    if (response.statusCode == 200) {
      return RestaurantDetails.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
  Future<RestaurantSearch> restaurantSearch(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + _search + query));
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load the data from Searching Restaurant');
    }
  }

}