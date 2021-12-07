import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/widget/card_list_restaurant.dart';
import 'package:restaurant_app/widget/search_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  static const routeName = '/search_widget';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchQuery = '';
  late RestaurantListProvider _provider;
  List<Restaurant> searchRestaurant = [];

  @override
  void initState() {
    super.initState();
    _provider =
        RestaurantListProvider(apiService: ApiService(), restauranId: '',);
  }

  Future getSearchRestaurant() async {
    final restaurants = await _provider.searchRestaurant(searchQuery);
    setState(() {
      searchRestaurant = restaurants;
    });
  }

  Future searchRestaurantFromQuery(String query) async {
    final restaurants = await _provider.searchRestaurant(query);

    if (!mounted) return;

    setState(() {
      searchQuery = query;
      searchRestaurant = restaurants;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: 787,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Text(
                                "RESTAURANTnesia",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                          ),
                        ),
                        SearchWidget(text: searchQuery, onChanged: searchRestaurantFromQuery),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child:ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: searchRestaurant.length,
                              itemBuilder: (context, index) {
                                Restaurant restaurantItem = searchRestaurant[index];
                                return ChangeNotifierProvider.value(value: _provider, child: Consumer<RestaurantListProvider>(builder: (context, state, _) {
                                  _provider = state;
                                  if (state.state == ResultState.Loading) {
                                    return Center(child: CircularProgressIndicator());
                                  } else if (state.state == ResultState.HasData) {
                                    return CardListRestaurant(restaurant: restaurantItem);
                                  } else if (state.state == ResultState.NoData) {
                                    return Center(child: Text(state.message));
                                  } else if (state.state == ResultState.Error) {
                                    return Center(child: Text(state.message));
                                  } else {
                                    return Center(child: Text(''));
                                  }
                                },),);
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Container(
                    height: 300,
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(top: 30, bottom: 0),
                    margin: EdgeInsets.only(top: 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: Colors.white,
                    ),
                    child: Container(
                        margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                        height: 530,
                        child: Consumer<RestaurantListProvider>(
                          builder: (BuildContext context, state, _) {
                            if (state.state == ResultState.Loading) {
                              return Center(child: CircularProgressIndicator());
                            } else if (state.state == ResultState.HasData) {
                              final restaurant = state.restaurant;
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: restaurant.restaurants.length,
                                itemBuilder: (context, index) {
                                  final restaurantElement = restaurant.restaurants[index];
                                  return CardListRestaurant(restaurant: restaurantElement);
                                },
                              );
                            } else if (state.state == ResultState.NoData) {
                              return Center(child: Text(state.message));
                            } else if (state.state == ResultState.Error) {
                              return Center(child: Text(state.message));
                            } else {
                              return Center(child: Text(''));
                            }
                          },
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _restaurantListItem(BuildContext context, Restaurant restaurantItem) {
    return ChangeNotifierProvider.value(value: _provider, child: Consumer<RestaurantListProvider>(builder: (context, state, _) {
      _provider = state;
      if (state.state == ResultState.Loading) {
        return Center(child: CircularProgressIndicator());
      } else if (state.state == ResultState.HasData) {
        final restaurant = state.restaurant;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: restaurant.restaurants.length,
          itemBuilder: (context, index) {
            final restaurantElement = restaurant.restaurants[index];
            return CardListRestaurant(restaurant: restaurantElement);
          },
        );
      } else if (state.state == ResultState.NoData) {
        return Center(child: Text(state.message));
      } else if (state.state == ResultState.Error) {
        return Center(child: Text(state.message));
      } else {
        return Center(child: Text(''));
      }
    },),);
  }
}
