import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'city_cards.dart';

final _firestore = FirebaseFirestore.instance;

class CityCardBuilder extends StatefulWidget {
  @override
  _CityCardBuilderState createState() => _CityCardBuilderState();
}

class _CityCardBuilderState extends State<CityCardBuilder> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("CityCards").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final cards = snapshot.data.docs;
          List<CityCards> cityCards = [];

          for (var citycard in cards) {
            var cityCard;
            final cityName = citycard.data()['city'];
            final countryName = citycard.data()['country'];
            final placeRating = citycard.data()['rating'];
            final latitude = citycard.data()['latitude'];
            final longitude = citycard.data()['longitude'];

            cityCard = CityCards(
                city: cityName,
                country: countryName,
                rating: placeRating,
                latitude: latitude,
                longitude: longitude);
            cityCards.add(cityCard);
          }

          return ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: cityCards,
          );
        });
  }
}
