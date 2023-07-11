// Mocks generated by Mockito 5.4.2 from annotations
// in flutter_restaurant_fic5/test/bloc/detail_product/detail_product_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:flutter_restaurant_fic5/data/models/requests/add_product_request_model.dart'
    as _i7;
import 'package:flutter_restaurant_fic5/data/models/responses/add_product_response_model.dart'
    as _i6;
import 'package:flutter_restaurant_fic5/data/models/responses/products_response_model.dart'
    as _i5;
import 'package:flutter_restaurant_fic5/data/models/upload_image_response_model.dart'
    as _i8;
import 'package:flutter_restaurant_fic5/data/remote_datasources/restaurant_datasource.dart'
    as _i3;
import 'package:image_picker/image_picker.dart' as _i9;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [RestaurantDatasource].
///
/// See the documentation for Mockito's code generation for more information.
class MockRestaurantDatasource extends _i1.Mock
    implements _i3.RestaurantDatasource {
  MockRestaurantDatasource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<String, _i5.ProductsResponseModel>> getAll() =>
      (super.noSuchMethod(
        Invocation.method(
          #getAll,
          [],
        ),
        returnValue:
            _i4.Future<_i2.Either<String, _i5.ProductsResponseModel>>.value(
                _FakeEither_0<String, _i5.ProductsResponseModel>(
          this,
          Invocation.method(
            #getAll,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<String, _i5.ProductsResponseModel>>);
  @override
  _i4.Future<_i2.Either<String, _i5.ProductsResponseModel>> getByUserId(
          int? userId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getByUserId,
          [userId],
        ),
        returnValue:
            _i4.Future<_i2.Either<String, _i5.ProductsResponseModel>>.value(
                _FakeEither_0<String, _i5.ProductsResponseModel>(
          this,
          Invocation.method(
            #getByUserId,
            [userId],
          ),
        )),
      ) as _i4.Future<_i2.Either<String, _i5.ProductsResponseModel>>);
  @override
  _i4.Future<_i2.Either<String, _i6.AddProductResponseModel>> getById(
          int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getById,
          [id],
        ),
        returnValue:
            _i4.Future<_i2.Either<String, _i6.AddProductResponseModel>>.value(
                _FakeEither_0<String, _i6.AddProductResponseModel>(
          this,
          Invocation.method(
            #getById,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.Either<String, _i6.AddProductResponseModel>>);
  @override
  _i4.Future<_i2.Either<String, _i6.AddProductResponseModel>> addProduct(
          _i7.AddProductRequestModel? model) =>
      (super.noSuchMethod(
        Invocation.method(
          #addProduct,
          [model],
        ),
        returnValue:
            _i4.Future<_i2.Either<String, _i6.AddProductResponseModel>>.value(
                _FakeEither_0<String, _i6.AddProductResponseModel>(
          this,
          Invocation.method(
            #addProduct,
            [model],
          ),
        )),
      ) as _i4.Future<_i2.Either<String, _i6.AddProductResponseModel>>);
  @override
  _i4.Future<_i2.Either<String, _i8.UploadImageResponseModel>> uploadImage(
          _i9.XFile? image) =>
      (super.noSuchMethod(
        Invocation.method(
          #uploadImage,
          [image],
        ),
        returnValue:
            _i4.Future<_i2.Either<String, _i8.UploadImageResponseModel>>.value(
                _FakeEither_0<String, _i8.UploadImageResponseModel>(
          this,
          Invocation.method(
            #uploadImage,
            [image],
          ),
        )),
      ) as _i4.Future<_i2.Either<String, _i8.UploadImageResponseModel>>);
}