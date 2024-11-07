import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khoyout/core/functions/show_snackbar.dart';
import 'package:khoyout/core/helpers/extenction.dart';
import 'package:khoyout/core/utils/app_colors.dart';
import 'package:khoyout/core/widgets/loader_widget.dart';
import 'package:khoyout/core/widgets/my_button.dart';
import 'package:khoyout/feature/cart/data/models/cart_item_model.dart';
import 'package:khoyout/feature/cart/presentation/widgets/quantity_control_button.dart';
import 'package:khoyout/feature/home/presentation/manager/home_cubit.dart';
import 'package:khoyout/feature/home/presentation/manager/home_state.dart';
import 'package:khoyout/generated/l10n.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/helpers/product_type.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.cartItemModel});
  final CartItemModel cartItemModel;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int count = 1;
  double width = 0.0;
  double height = 0.0;
  final controller = PageController(viewportFraction: 0.99, keepPage: true);
  List<String> options =[];
  @override
  void initState() {
    options = widget.cartItemModel.productModel.attributes.map((e) => e.name).toList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<HomeCubit>(context);
        return Scaffold(
          body: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  buildSliverAppBar(),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SmoothPageIndicator(
                              controller: controller,
                              count:
                              widget.cartItemModel.productModel.images.length,
                              effect: const WormEffect(
                                dotHeight: 16,
                                dotWidth: 16,
                                type: WormType.normal,
                                dotColor: Colors.grey,
                                activeDotColor: AppColors.primaryColor,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    widget.cartItemModel.productModel.name,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  '${widget.cartItemModel.productModel.price} EGP',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        String attributeName = widget.cartItemModel.productModel.attributes[index].name;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
                          child: Row(
                            children: [
                              Text(
                                attributeName,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              const Spacer(),
                              DropdownMenu(
                                width: 150,
                                label: Text(attributeName),
                                onSelected: (value) {
                                  setState(() {
                                    options[index] = value;
                                    cubit.concatenateVariantProduct(options);

                                    if(cubit.productIndex!=-1)
                                      {
                                        widget.cartItemModel.productModel.price=cubit.productVariants[cubit.productIndex].price;
                                        setState(() {

                                        });
                                      }
                                  });
                                },
                                initialSelection: options[index],
                                errorText: const InputDecoration().errorText,
                                inputDecorationTheme: InputDecorationTheme(
                                  constraints: const BoxConstraints(
                                    maxHeight: 50
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                dropdownMenuEntries: widget.cartItemModel.productModel.attributes[index].options.map(
                                      (e) => DropdownMenuEntry(
                                    label: e,
                                    value: e,
                                  ),
                                ).toList(),
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: widget.cartItemModel.productModel.attributes.length,
                    ),
                  ),

                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        const SizedBox(
                          height: 10,
                        ),
                        buildQuantityRow(),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: MyButton(
                            text: S.of(context).AddToCart,
                            onTap: () {
                              if(widget.cartItemModel.productModel.type==checkProductType(ProductType.variable))
                                {
                                  if(cubit.productIndex!=-1)
                                    {
                                      widget.cartItemModel.quantity = count;
                                      widget.cartItemModel.variantId=cubit.productVariants[cubit.productIndex].id;
                                      cubit.addToCart(
                                          widget.cartItemModel);
                                      context.pop();
                                    }
                                  else
                                    {
                                      showSnackBarF(context: context, text: S.of(context).PleaseSelectVariant);
                                    }
                                }
                              else
                                {
                                  widget.cartItemModel.quantity = count;
                                  cubit.addToCart(
                                      widget.cartItemModel);
                                  context.pop();
                                }

                            },
                          ),
                        ),
                        SizedBox(
                          height: height / 1.4,
                        ),
                      ],
                    ),
                  ),

                ],
              ),
              if(state is ProductVariationLoadingState)
                const LoaderWidget(),
            ],
          ),
        );
      },
    );
  }

  Widget buildQuantityRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QuantityControlButton(
            icon: Icons.remove,
            onPressed: () {
              setState(() {
                if (count > 1) {
                  count--;
                }
              });
            },
            color: AppColors.brown,
            heroTag: 'll',
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              count.toString(),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 22,
                fontWeight: FontWeight.w900
              ),
            ),
          ),
          QuantityControlButton(
            icon: Icons.add,
            onPressed: () {
              setState(() {
                count++;
              });
            },
            color: AppColors.orange,
            heroTag: 'll',
          ),
        ],
      ),
    );
  }

  SliverAppBar buildSliverAppBar() {
    return SliverAppBar(
      iconTheme: const IconThemeData(
          color: AppColors.orange, size: 30, grade: 60, weight: 50),
      expandedHeight: width/1.1,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          widget.cartItemModel.productModel.name,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        background: Hero(
          tag: widget.cartItemModel.productModel.id,
          child: PageView.builder(
            controller: controller,
            scrollDirection: Axis.horizontal,
            itemCount: widget.cartItemModel.productModel.images.length,
            itemBuilder: (context, index) => SizedBox(
              width: double.infinity,
              child: Image.network(
                widget.cartItemModel.productModel.images[index].src,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
