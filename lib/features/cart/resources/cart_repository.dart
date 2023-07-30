import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_project/common/constants.dart';
import 'package:ecommerce_project/features/auth/resources/user_repository.dart';

import '../models/cart.dart';

class CartRepository {
  final UserRepository userRepository;

  CartRepository({required this.userRepository});

  List<Cart> _carts = [];

  List<Cart> get cart => _carts;

  Future<Either<String, List<Cart>>> fetchCarts() async {
    try {
      final Dio dio = Dio();
      final res = await dio.get("${Constants.baseUrl}/cart/",
          options: Options(
              headers: {"Authorization": "Bearer ${userRepository.token}"}));
      final items =
          List.from(res.data["results"]).map((e) => Cart.fromMap(e)).toList();
      _carts.clear();
      _carts.addAll(items);
      return Right(_carts);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? "Unable to fetch cart data");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Cart>> updateCartsQuantity({
    required String cartId,
    required int quantity,
  }) async {
    try {
      final Dio dio = Dio();
      final res = await dio.put("${Constants.baseUrl}/cart/$cartId",
          data: {"quantity": quantity},
          options: Options(
              headers: {"Authorization": "Bearer ${userRepository.token}"}));
      final items = Cart.fromMap(res.data['results']);
      final _index = _carts.indexWhere((element) => element.id == items.id);
      if (_index != -1) {
        _carts[_index] = items;
      }
      return Right(items);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? "Unable to fetch cart data");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
