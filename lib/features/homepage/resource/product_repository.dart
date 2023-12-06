import 'dart:convert';


import 'dart:io';


import 'package:cloudinary_public/cloudinary_public.dart';


import 'package:dartz/dartz.dart';


import 'package:dio/dio.dart';


import 'package:ecommerce_project/common/constants.dart';


import 'package:ecommerce_project/features/auth/resources/user_repository.dart';


import 'package:ecommerce_project/features/homepage/model/add_product.dart';


import 'package:ecommerce_project/features/homepage/model/product.dart';


class ProductRepository {

  final UserRepository userRepository;


  ProductRepository({required this.userRepository});


  final List<Product> _items = [];


  List<Product> get items => _items;


  int _currentPage = 1;


  int _totalProductCount = -1;


  Future<Either<String, List<Product>>> fetchProduct(

      {bool isLoadMore = false}) async {

    try {

      if (_items.length == _totalProductCount && isLoadMore) {

        return Right(_items);

      }


      if (isLoadMore) {

        _currentPage++;

      } else {

        _currentPage = 1;


        _items.clear();


        _totalProductCount = -1;

      }


      final Dio dio = Dio();


      final Map<String, dynamic> headers = {

        "Authorization": "Bearer ${userRepository.token}",

      };


      final res = await dio.get("${Constants.baseUrl}/products",

          options: Options(headers: headers),

          queryParameters: {"page": _currentPage});


      final temp = List.from(res.data['results'])

          .map((e) => Product.fromMap(e))

          .toList();


      _totalProductCount = res.data['total'];


      // temp.shuffle();


      _items.clear();


      _items.addAll(temp);


      return Right(_items);

    } on DioException catch (e) {

      return Left(e.response?.data["message"] ?? "Unable to fetch products");

    } catch (e) {

      return Left(e.toString());

    }

  }


  Future<Either<String, Product>> fetchProductDetails(

      {required String productId}) async {

    try {

      final Dio dio = Dio();


      final Map<String, dynamic> header = {

        "Authorization": "Bearer ${userRepository.token}"

      };


      final res = await dio.get(

        "${Constants.baseUrl}/products/$productId",

        options: Options(headers: header),

      );


      final items = Product.fromMap(res.data['results']);


      return Right(items);

    } on DioException catch (e) {

      return Left(e.response?.data['message'] ?? "");

    } catch (e) {

      return Left(e.toString());

    }

  }


  Future<Either<String, void>> addToCart({required String productId}) async {

    try {

      final Dio dio = Dio();


      final Map<String, dynamic> header = {

        "Authorization": "Bearer ${userRepository.token}"

      };


      final _ = dio.post(

        "${Constants.baseUrl}/cart",

        data: {"quantity": 1, "product": productId},

        options: Options(headers: header),

      );


      return const Right(null);

    } on DioException catch (e) {

      return Left(e.response?.data['message'] ?? "");

    } catch (e) {

      return Left(e.toString());

    }

  }


  Future<Either<String, void>> addProduct({

    required String name,

    required File image,

    required String description,

    required String brand,

    required int price,
    required List<String> catagories,

  }) async {

    try {

      final Dio dio = Dio();


      final cloudnary = CloudinaryPublic('dnwz1vyoq', 'ry1ukruq');


      CloudinaryResponse res = await cloudnary.uploadFile(

        CloudinaryFile.fromFile(image.path, folder: name),

      );


      String tempImage = res.secureUrl;


      // List<String> category = ["insta phone"];


      AddProduct product = AddProduct(

        name: name,

        description: description,

        image: tempImage,

        brand: brand,

        price: price,

        catagories: catagories,

      );


      final Map<String, dynamic> header = {

        "Authorization": "Bearer ${userRepository.token}"

      };


      final _ = await dio.post("${Constants.baseUrl}/products/create",

          data: jsonEncode(product.toMap()),

          options: Options(

            headers: header,

          ));


      return const Right(null);

    } on DioException catch (e) {

      return Left(e.response?.data['error']['message'] ?? "Cannot add product");

    } catch (e) {

      return Left(e.toString());

    }

  }

}

