import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kiwi/kiwi.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import '../../../../../core/design/app_image.dart';
import '../../../../../features/my_account/edit_profile/edit_profile_bloc.dart';
import '../../../../../features/my_account/get_profile/get_profile_bloc.dart';

class CustomMyData extends StatefulWidget {
  final bool isMain;
  const CustomMyData({super.key, this.isMain = true});

  @override
  State<CustomMyData> createState() => _CustomMyDataState();
}

class _CustomMyDataState extends State<CustomMyData> {
  final bloc = KiwiContainer().resolve<ProfileBloc>()..add(GetProfileEvent());
  final editProfileBloc = KiwiContainer().resolve<EditProfileBloc>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        if (state is GetProfileDataSuccessState) {
          return Column(
            children: [
              FadeIn(
                duration: const Duration(milliseconds: 500),
                child: StatefulBuilder(
                  builder: (context, setState1) => Container(
                    alignment: Alignment.center,
                    clipBehavior: Clip.antiAlias,
                    height: 70.h,
                    width: 75.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: editProfileBloc.imagePath != null
                            ? FileImage(
                          File(
                            editProfileBloc.imagePath!,
                          ),
                        )
                            : CachedNetworkImageProvider(
                          state.data.image,
                        ) as ImageProvider,
                      ),
                    ),
                    child: widget.isMain
                        ? const SizedBox()
                        : GestureDetector(
                      onTap: () async {
                        final file = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (file != null) {
                          editProfileBloc.imagePath = file.path;
                          setState1(() {});
                        }
                      },
                      child: AppImage(
                        'assets/icons/account/Camera.svg',
                        height: 25.h,
                        fit: BoxFit.fitHeight,
                        color: AppColor.mainColor,
                      ),
                    ),
                  ),
                ),
              ),
              verticalSpace(4),
              Text(
                state.data.fullname,
                style: TextStyle(
                    color: widget.isMain ? AppColor.white : AppColor.mainColor,
                    fontSize: widget.isMain ? 14.sp : 16.sp,
                    fontWeight: FontWeight.bold),
              ),
              verticalSpace(2),
              Text(
                "+${state.data.phone}",
                style: TextStyle(
                  color: widget.isMain
                      ? const Color(0xffA2D273)
                      : const Color(0xffA7A7A7),
                  fontSize: widget.isMain ? 14.sp : 16.sp,
                  fontWeight: FontWeight.w400,
                ),
                textDirection: TextDirection.ltr,
              ),
            ],
          );
        } else {
          return SizedBox(
            height: 110.h,
            child: Center(
              child: CircularProgressIndicator(
                color: AppColor.mainColor,
              ),
            ),
          );
        }
      },
    );
  }
}