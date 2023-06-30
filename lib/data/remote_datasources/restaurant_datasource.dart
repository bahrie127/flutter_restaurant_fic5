import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_restaurant_fic5/common/constants.dart';
import 'package:flutter_restaurant_fic5/data/local_datasources/auth_local_datasource.dart';
import 'package:flutter_restaurant_fic5/data/models/requests/add_product_request_model.dart';
import 'package:flutter_restaurant_fic5/data/models/responses/add_product_response_model.dart';
import 'package:flutter_restaurant_fic5/data/models/responses/products_response_model.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../models/upload_image_response_model.dart';

class RestaurantDatasource {
  Future<Either<String, ProductsResponseModel>> getAll() async {
    final response = await http.get(
      Uri.parse('${Constants.baseUrl}/api/restaurants'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return Right(
        ProductsResponseModel.fromJson(
          jsonDecode(response.body),
        ),
      );
    } else {
      return const Left('API ERROR');
    }
  }

  Future<Either<String, ProductsResponseModel>> getByUserId(int userId) async {
    final response = await http.get(
      Uri.parse('${Constants.baseUrl}/api/restaurants?filters[userId]=$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return Right(
        ProductsResponseModel.fromJson(
          jsonDecode(response.body),
        ),
      );
    } else {
      return const Left('API ERROR');
    }
  }

  Future<Either<String, AddProductResponseModel>> getById(int id) async {
    final response = await http.get(
      Uri.parse('${Constants.baseUrl}/api/restaurants/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return Right(
        AddProductResponseModel.fromJson(
          jsonDecode(response.body),
        ),
      );
    } else {
      return const Left('API ERROR');
    }
  }

  Future<Either<String, AddProductResponseModel>> addProduct(
      AddProductRequestModel model) async {
    final token = await AuthLocalDatasource().getToken();
    final response = await http.post(
      Uri.parse('${Constants.baseUrl}/api/restaurants'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      return Right(
        AddProductResponseModel.fromJson(
          jsonDecode(response.body),
        ),
      );
    } else {
      return const Left('API ERROR');
    }
  }

  Future<Either<String, UploadImageResponseModel>> uploadImage(
      XFile image) async {
    final token = await AuthLocalDatasource().getToken();
    final header = <String, String>{
      'Authorization': 'Bearer $token',
    };
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${Constants.baseUrl}/api/upload'),
    );

    final bytes = await image.readAsBytes();

    final multiPartFile =
        http.MultipartFile.fromBytes('files', bytes, filename: image.name);

    request.files.add(multiPartFile);
    request.headers.addAll(header);

    http.StreamedResponse response = await request.send();

    final responseList = await response.stream.toBytes();
    final String responseData = String.fromCharCodes(responseList);

    if (response.statusCode == 200) {
      return Right(
          UploadImageResponseModel.fromJson(jsonDecode(responseData)[0]));
    } else {
      return const Left('error upload image');
    }
  }
}
