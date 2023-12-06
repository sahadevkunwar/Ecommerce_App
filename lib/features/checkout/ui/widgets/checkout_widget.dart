import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/common/utils/snackbar_utils.dart';
import 'package:ecommerce_project/features/auth/resources/user_repository.dart';
import 'package:ecommerce_project/features/checkout/cubit/create_order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';

class CheckOutWidget extends StatefulWidget {
  const CheckOutWidget({Key? key}) : super(key: key);

  @override
  State<CheckOutWidget> createState() => _CheckOutWidgetState();
}

class _CheckOutWidgetState extends State<CheckOutWidget> {
  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    final userRepo = context.read<UserRepository>();
    if (userRepo.user != null) {
      _fullNameController.text = userRepo.user!.name;
      _addressController.text = userRepo.user!.address;
      _phoneNumberController.text = userRepo.user!.phone;
    }
  }

  void _showSuccessfulDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Order confirmed successfully'),
          actions: [
            Image.asset("assets/images/order_confirm.png"),
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Center(child: Text('Done')),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Checkout',
            style: GoogleFonts.poppins(fontSize: 16),
          ),
        ),
        body: BlocListener<CreateOrderCubit, CommonState>(
          listener: (context, state) {
            if (state is CommonLoadingState) {
              setState(() {
                isLoading = true;
              });
            } else {
              setState(() {
                isLoading = false;
              });
            }
            if (state is CommonErrorState) {
              SnackbarUtils.showMessage(
                  context: context, message: state.message);
            } else if (state is CommonSuccessState) {
              _showSuccessfulDialog(context);
            }
          },
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Full Name"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _fullNameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your name',
                        border: OutlineInputBorder(),
                        // You can add more decoration options here
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Address"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your address',
                        border: OutlineInputBorder(),
                        // You can add more decoration options here
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("City"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _cityController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your city',
                        border: OutlineInputBorder(),
                        // You can add more decoration options here
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Phone"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _phoneNumberController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your phone',
                        border: OutlineInputBorder(),
                        // You can add more decoration options here
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            context.read<CreateOrderCubit>().create(
                                fullName: _fullNameController.text,
                                phone: _phoneNumberController.text,
                                city: _cityController.text,
                                address: _addressController.text);
                          },
                          child: const Text('Confirm Order')))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
