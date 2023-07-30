import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_project/common/constants.dart';
import 'package:ecommerce_project/features/auth/resources/user_repository.dart';
import 'package:ecommerce_project/features/orders/model/order.dart';

class OrderRepository {
  final UserRepository userRepository;

  OrderRepository({required this.userRepository});

  final List<ProductOrder> _orders = [];
  List<ProductOrder> get orders => _orders;

  Future<Either<String, void>> createOrder({
    required String fullName,
    required String phone,
    required String address,
    required String city,
  }) async {
    try {
      final Dio dio = Dio();
      final Map<String, dynamic> body = {
        "address": address,
        "city": city,
        "phone": phone,
        "full_name": fullName,
      };
      final _ = await dio.post('${Constants.baseUrl}/orders',
          data: body,
          options: Options(
              headers: {"Authorization": "Bearer ${userRepository.token}"}));
      return const Right(null);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? "unable to create order");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<ProductOrder>>> fetchOrder() async {
    try {
      final Dio dio = Dio();
      final Map<String, dynamic> headers = {
        "Authorization": "Bearer ${userRepository.token}",
      };
      final res = await dio.get("${Constants.baseUrl}/orders",
          options: Options(headers: headers));
      final temp = List.from(res.data['results'])
          .map((e) => ProductOrder.fromMap(e))
          .toList();
      _orders.clear();
      _orders.addAll(temp);
      return Right(_orders);
    } on DioException catch (e) {
      return Left(e.response?.data["message"] ?? "Unable to fetch products");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
