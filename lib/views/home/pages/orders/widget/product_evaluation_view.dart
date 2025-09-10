import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vegetable_orders_project/views/home/pages/orders/widget/product_evaluate_item.dart';
import '../../../../../core/design/custom_app_bar.dart';

class ProductEvaluationView extends StatelessWidget {
  const ProductEvaluationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'تقييم المنتجات'),
      body: Padding(padding: EdgeInsets.only(top: 5.h),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          itemBuilder: (context, index) => const ProductEvaluateItem(),
          itemCount: 4,
        ),
      ),
    );
  }
}