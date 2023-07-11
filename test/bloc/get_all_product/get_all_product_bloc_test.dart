import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_restaurant_fic5/bloc/get_all_product/get_all_product_bloc.dart';
import 'package:flutter_restaurant_fic5/data/models/responses/products_response_model.dart';
import 'package:flutter_restaurant_fic5/data/remote_datasources/restaurant_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_product_bloc_test.mocks.dart';

@GenerateMocks([RestaurantDatasource])
void main() {
  late GetAllProductBloc getAllProductBloc;
  late MockRestaurantDatasource mockRestaurantDatasource;

  setUp(() {
    mockRestaurantDatasource = MockRestaurantDatasource();
    getAllProductBloc = GetAllProductBloc(mockRestaurantDatasource);
  });

  final String jsonString = '''
{"data": [
        {
            "id": 6,
            "attributes": {
                "name": "Gemati Coffe",
                "description": "Coffe & Eatery",
                "latitude": "-7.550337836789965",
                "longitude": "110.77169609703935",
                "address": "Jl. Matoa Raya I",
                "createdAt": "2023-06-15T09:42:23.355Z",
                "updatedAt": "2023-06-29T13:22:49.183Z",
                "publishedAt": "2023-06-15T08:35:25.622Z",
                "photo": "https://img.freepik.com/premium-photo/grodno-belarus-march-2019-inside-interior-modern-pub-sport-bar-with-dark-loft-design-style-with-red-chairs_97694-3440.jpg",
                "userId": "27"
            }
        },
        {
            "id": 26,
            "attributes": {
                "name": "Alang Puyuh",
                "description": "Cafe & Resto",
                "latitude": "-3.016910909077944",
                "longitude": "120.15385069886861",
                "address": "Jl. Andi Kambo",
                "createdAt": "2023-06-22T02:31:08.204Z",
                "updatedAt": "2023-06-25T08:58:03.274Z",
                "publishedAt": "2023-06-15T08:35:25.622Z",
                "photo": "https://images.unsplash.com/photo-1533090699061-11bd9fc5a96b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=686&q=80",
                "userId": "1"
            }
        }
        ],
        "meta": {
        "pagination": {
            "page": 1,
            "pageSize": 25,
            "pageCount": 1,
            "total": 19
        }
    }
        }
''';

  final modelResponse = ProductsResponseModel.fromJson(jsonDecode(jsonString));

  blocTest<GetAllProductBloc, GetAllProductState>(
    'test get all product bloc, emit loaded when event get',
    build: () {
      when(mockRestaurantDatasource.getAll())
          .thenAnswer((realInvocation) async {
        return Right(modelResponse);
      });
      return getAllProductBloc;
    },
    act: (bloc) => bloc.add(const GetAllProductEvent.get()),
    expect: () => <GetAllProductState>[
      const GetAllProductState.loading(),
      GetAllProductState.loaded(modelResponse),
    ],
  );

  blocTest<GetAllProductBloc, GetAllProductState>(
    'test get all product bloc, emit error when event get',
    build: () {
      when(mockRestaurantDatasource.getAll())
          .thenAnswer((realInvocation) async {
        return const Left('error');
      });
      return getAllProductBloc;
    },
    act: (bloc) => bloc.add(const GetAllProductEvent.get()),
    expect: () => <GetAllProductState>[
      const GetAllProductState.loading(),
      const GetAllProductState.error(),
    ],
  );
}
