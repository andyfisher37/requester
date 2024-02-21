import 'package:dio/dio.dart';

import '../models/request.dart';
//import 'package:ecommerce_app/model/search/search_Model.dart';
//import 'package:ecommerce_app/services/baseAPI.dart';

class SearchServices {
  static Future<List<Request>> viewRequestsSearch(
      int pageIndex, String searchVal) async {
    var url = ''; //'${BaseAPI.authPath}' + '/search';

    var response = await Dio().get(url, queryParameters: {
      "pagesize": 10,
      "page": pageIndex,
      'search_query': searchVal
    });

    final dataList = (response.data['data']['Request']['data'] as List)
        .map((e) => Request.fromJson(e))
        .toList();

    if (response.statusCode == 200) {
      final dataList = (response.data['data']['Request']['data'] as List)
          .map((e) => Request.fromJson(e))
          .toList();
    } else {
      print('response.reasonPhrase');
    }
    return dataList;
  }

  // static Future<List<DataProducts>> viewFoodsSearch(
  //     int pageIndex, String searchVal) async {
  //   var url = '${BaseAPI.authPath}' + '/search';

  //   var response = await Dio().get(url, queryParameters: {
  //     "pagesize": 10,
  //     "page": pageIndex,
  //     'search_query': searchVal
  //   });

  //   final dataList = (response.data['data']['Products']['data'] as List)
  //       .map((e) => DataProducts.fromJson(e))
  //       .toList();
  //   return dataList;
  // }
}
//   static Future<List<dynamic>> viewAllCategories(int pageIndex) async {
//     var url = '${BaseAPI.authPath}' + '/Requests';

//     var response = await Dio().get(url, queryParameters: {
//       "pagesize": 5,
//       "page": pageIndex,
//     });

//     final dataList = (response.data['data']['categories'] as List).toList();
//     return dataList;
//   }
// }



  // static Future<List<dynamic>> viewAllCategories(int pageIndex) async {
  //   var url = '${BaseAPI.authPath}' + '/Requests';

  //   var response = await Dio().get(url, queryParameters: {
  //     "pagesize": 5,
  //     "page": pageIndex,
  //   });

  //   final dataList = (response.data['data']['categories'] as List).toList();
  //   return dataList;
  // }