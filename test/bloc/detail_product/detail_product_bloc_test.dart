import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_restaurant_fic5/bloc/detail_product/detail_product_bloc.dart';
import 'package:flutter_restaurant_fic5/data/models/responses/add_product_response_model.dart';
import 'package:flutter_restaurant_fic5/data/remote_datasources/restaurant_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

import 'detail_product_bloc_test.mocks.dart';

@GenerateMocks([RestaurantDatasource])
void main() {
  late MockRestaurantDatasource mockDatasource;
  late DetailProductBloc detailProductBloc;

  setUp(() {
    mockDatasource = MockRestaurantDatasource();
    detailProductBloc = DetailProductBloc(mockDatasource);
  });

  const String jsonString = '''{
    "data": {
        "id": 1,
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
    "meta": {}
}''';

  const int idProduct = 1;

  final modelProduct = AddProductResponseModel.fromJson(jsonDecode(jsonString));

  blocTest<DetailProductBloc, DetailProductState>(
    'emits [Loaded] when MyEvent is get.',
    build: () {
      when(mockDatasource.getById(idProduct))
          .thenAnswer((realInvocation) async {
        return Right(modelProduct);
      });
      return detailProductBloc;
    },
    act: (bloc) => bloc.add(const DetailProductEvent.get(1)),
    expect: () => <DetailProductState>[
      const DetailProductState.loading(),
      DetailProductState.loaded(modelProduct),
    ],
  );

  blocTest<DetailProductBloc, DetailProductState>(
    'emits [Error] when MyEvent is get.',
    build: () {
      when(mockDatasource.getById(idProduct))
          .thenAnswer((realInvocation) async {
        return const Left('error');
      });
      return detailProductBloc;
    },
    act: (bloc) => bloc.add(const DetailProductEvent.get(1)),
    expect: () => <DetailProductState>[
      const DetailProductState.loading(),
      const DetailProductState.error('error'),
    ],
  );
}
