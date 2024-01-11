import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/common/constants.dart';
import 'package:ecommerce_project/common/utils/snackbar_utils.dart';
import 'package:ecommerce_project/features/auth/ui/widgets/login_signup_widget.dart';
import 'package:ecommerce_project/features/dashboard/screens/dash_board_screen.dart';
import 'package:ecommerce_project/features/homepage/cubit/add_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:page_transition/page_transition.dart';

class AddProductWidget extends StatefulWidget {
  const AddProductWidget({super.key});

  @override
  State<AddProductWidget> createState() => _AddProductWidgetState();
}

class _AddProductWidgetState extends State<AddProductWidget> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _brandController = TextEditingController();
  final _priceController = TextEditingController();

  //for category list dropdown menu
  final categoryItems = Constants.categoriesList;
  String? selectedCategoryValue;

  File? productImage;

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  List<String> tempCategory = [];

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add product'),
        ),
        body: BlocListener<AddProductCubit, CommonState>(
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
                context: context,
                message: state.message,
                backgroundColor: Colors.red,
              );
            } else if (state is CommonSuccessState) {
              Navigator.of(context).pushAndRemoveUntil(
                  PageTransition(
                    child: const DashBoardScreen(),
                    type: PageTransitionType.fade,
                  ),
                  (route) => false);
              SnackbarUtils.showMessage(
                context: context,
                message: 'Product added successfully',
                backgroundColor: Colors.green,
              );
            }
          },
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final imagePicker = ImagePicker();

                        final res = await imagePicker.pickImage(
                            source: ImageSource.gallery);

                        if (res != null) {
                          setState(() {
                            productImage = File(res.path);
                          });
                        }
                      },
                      child: DottedBorder(
                        dashPattern: const [6],
                        borderType: BorderType.Rect,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          child: ClipRRect(
                            child: SizedBox(
                              height: 150,
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: productImage == null
                                  ? const Column(
                                      children: [
                                        Icon(Icons.filter, size: 40),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Center(child: Text('Add produc image'))
                                      ],
                                    )
                                  : Image.file(
                                      productImage!,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      controller: _nameController,
                      hintText: 'Enter product name',
                      labelText: 'Product Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter product name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    CustomTextFormField(
                      controller: _descriptionController,
                      hintText: 'Enter description',
                      maxLines: 7,
                      labelText: 'Description',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter description';
                        } else {
                          return null;
                        }
                      },
                    ),
                    CustomTextFormField(
                      controller: _brandController,
                      hintText: 'Enter brand',
                      labelText: 'Brand',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter brand';
                        } else {
                          return null;
                        }
                      },
                    ),
                    CustomTextFormField(
                      controller: _priceController,
                      hintText: 'Enter price',
                      labelText: 'Price',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter price';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField2<String>(
                        isExpanded: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(16),
                          // ),
                          labelText: 'Category',
                          // helperText: 'hello',
                        ),
                        hint: const Text(
                          '',
                          style: TextStyle(fontSize: 14),
                        ),
                        value: selectedCategoryValue ?? categoryItems.first,
                        items: categoryItems
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a category.';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            selectedCategoryValue = value.toString();
                            tempCategory.add(value
                                .toString()); // Add selected category to the tempCategory list
                          });
                          // Do something when selected item is changed.
                          // selectedCategoryValue = value.toString();
                        },
                        onSaved: (value) {
                          setState(() {
                            selectedCategoryValue = value.toString();
                            tempCategory.add(value
                                .toString()); // Add selected category to the tempCategory list
                          });

                          // selectedCategoryValue = value.toString();
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 8),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 24,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[400],
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel')),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[400],
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState?.save();
                                context.read<AddProductCubit>().addProduct(
                                      name: _nameController.text,
                                      image: File(productImage!.path),
                                      description: _descriptionController.text,
                                      brand: _brandController.text,
                                      price: int.parse(_priceController.text),
                                      catagories: tempCategory,
                                    );
                              }
                            },
                            child: const Text('Add Product'))
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
