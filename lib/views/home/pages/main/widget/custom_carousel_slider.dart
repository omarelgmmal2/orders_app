import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/design/app_image.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/features/slider/slider_bloc.dart';

class CustomCarouselSlider extends StatefulWidget {
  const CustomCarouselSlider({super.key});

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  int currentIndex = 0;
  final bloc = KiwiContainer().resolve<SliderBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        if (state is SliderLoadingState) {
          return Center(
            child: CircularProgressIndicator(color: AppColor.mainColor),
          );
        } else if (state is SliderSuccessState) {
          return Stack(
            children: [
              CarouselSlider(
                items: List.generate(
                  state.model.length,
                  (index) => AppImage(
                    state.model[index].media,
                    fit: BoxFit.fill,
                    height: 164.h,
                    width: double.infinity.w,
                  ),
                ),
                options: CarouselOptions(
                  height: 164.h,
                  autoPlay: true,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    currentIndex = index;
                    setState(() {});
                  },
                ),
              ),
              Positioned(
                bottom: 7.h,
                left: 0.w,
                right: 0.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    state.model.length,
                    (index) => Padding(
                      padding: EdgeInsetsDirectional.only(end: 3.w),
                      child: CircleAvatar(
                        radius: index == currentIndex ? 6.r : 4.r,
                        backgroundColor: index == currentIndex
                            ? AppColor.white
                            : AppColor.white.withOpacity(0.38),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (state is SliderFailureState) {
          return Text(state.msg);
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
