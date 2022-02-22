import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';
import 'package:quickly_delivery/constants/constants.dart';

class Place {
  String? streetNumber;
  String? street;
  String? city;
  String? zipCode;
  String? country;
  String? state;

  Place({
    this.streetNumber,
    this.street,
    this.city,
    this.zipCode,
    this.country,
    this.state,
  });

  @override
  String toString() {
    return 'Place(streetNumber: $streetNumber, street: $street, city: $city, zipCode: $zipCode)';
  }
}

class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;

  final apiKey = Platform.isAndroid ? Constants.androidKey : Constants.iosKey;

  Future<List<Suggestion>?> fetchSuggestions(String input, String lang) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=(cities)&language=$lang&components=country:IN&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(Uri.parse(request));

    log('https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types="(cities)"&language=$lang&components=country:IN&key=$apiKey&sessiontoken=$sessionToken');

    log("=============response.statusCode.toString()=========");
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      log(result.toString());
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<Place> getPlaceDetailFromId(String placeId) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(Uri.parse(request));
    log("getPlaceDetailFromId==============");
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      log(result.toString());
      if (result['status'] == 'OK') {
        final components =
            result['result']['address_components'] as List<dynamic>;
        // build result
        final place = Place();
        components.forEach((c) {
          final List type = c['types'];
          if (type.contains('street_number')) {
            place.streetNumber = c['long_name'];
          }
          if (type.contains('route')) {
            place.street = c['long_name'];
          }
          if (type.contains('locality')) {
            place.city = c['long_name'];
          }
          if (type.contains('postal_code')) {
            place.zipCode = c['long_name'];
          }
          if (type.contains('country')) {
            place.country = c['long_name'];
          }
          if (type.contains('administrative_area_level_1')) {
            place.state = c['long_name'];
          }
        });
        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
