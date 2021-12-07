import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/widget/card_list_restaurant.dart';


class RestaurantListPage extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantListProvider>(
      create: (_) => RestaurantListProvider(apiService: ApiService(), restauranId: ''),
      child:SafeArea(
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "RESTAURANTnesia",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      SearchPage.routeName,
                                    );
                                  },
                                  child: Icon(Icons.search),
                                )
                              ],
                            )
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
                          builder: (context, state, _) {
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


  // Widget _buildFoodItem(BuildContext context, Restaurant restaurant) {
  //   return ListTile(
  //     contentPadding:
  //     const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  //     leading: ClipRRect(
  //       borderRadius: BorderRadius.circular(15.0),
  //       child: Image.network(
  //         restaurant.pictureId,
  //         width: 100,
  //       ),
  //     ),
  //     title: Text(restaurant.name),
  //     subtitle: Text('rating  ' + restaurant.rating.toString()),
  //     onTap: () {
  //       Navigator.pushNamed(context, RestaurantDetailPage.routeName,
  //           arguments: restaurant);
  //     },
  //   );
  // }
}


