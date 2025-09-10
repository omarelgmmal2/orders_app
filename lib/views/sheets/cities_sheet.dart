import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import 'package:vegetable_orders_project/core/utils/text_style_theme.dart';
import 'package:vegetable_orders_project/generated/locale_keys.g.dart';
import '../../features/get_cities/get_cities_bloc.dart';
import '../../model/cities_model.dart';

class CitiesSheet extends StatefulWidget {
  const CitiesSheet({super.key});

  @override
  State<CitiesSheet> createState() => _CitiesSheetState();
}

class _CitiesSheetState extends State<CitiesSheet> {
  final bloc = KiwiContainer().resolve<GetCitiesBloc>()..add(GetCitiesEvent());

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.h,
      child: ColoredBox(
        color: AppColor.white,
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Column(
            children: [
              Text(
                LocaleKeys.register_choose_your_city.tr(),
                style: TextStyleTheme.textStyle16Bold,
              ),
              verticalSpace(12),
              BlocBuilder(
                bloc: bloc,
                builder: (context, state) {
                  if (state is GetCitiesLoadingState) {
                    return Expanded(
                      child: Center(
                        child: SizedBox(
                          height: 30.w,
                          width: 30.w,
                          child: CircularProgressIndicator(
                            color: AppColor.mainColor,
                          ),
                        ),
                      ),
                    );
                  } else if (state is GetCitiesSuccessState) {
                    return Expanded(
                      child: Container(
                        color: AppColor.white,
                        child: ListView.builder(
                          itemBuilder: (context, index) => _Item(
                            city: state.cityData[index],
                          ),
                          itemCount: state.cityData.length,
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final CityModel city;
  const _Item({required this.city,}) : super();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context, city);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        height: 32.h,
        decoration: BoxDecoration(
            color: AppColor.mainColor.withOpacity(.13),
            borderRadius: BorderRadius.circular(9.r),
        ),
        child: Center(
          child: Text(city.name),
        ),
      ),
    );
  }
}