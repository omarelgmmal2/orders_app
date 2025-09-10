import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vegetable_orders_project/core/utils/app_color.dart';
import 'package:vegetable_orders_project/core/utils/spacing.dart';
import 'package:vegetable_orders_project/views/home/pages/my_account/screens/about_application_view.dart';
import 'package:vegetable_orders_project/views/home/pages/my_account/screens/connect_with_us_view.dart';
import 'package:vegetable_orders_project/views/home/pages/my_account/screens/frequently_questions_view.dart';
import 'package:vegetable_orders_project/views/home/pages/my_account/screens/personal_data_view.dart';
import 'package:vegetable_orders_project/views/home/pages/my_account/screens/privacy_policy_view.dart';
import 'package:vegetable_orders_project/views/home/pages/my_account/screens/suggestions_complaints_view.dart';
import 'package:vegetable_orders_project/views/home/pages/my_account/screens/terms_view.dart';
import 'package:vegetable_orders_project/views/home/pages/my_account/screens/titles_view.dart';
import 'package:vegetable_orders_project/views/home/pages/my_account/screens/wallet_view.dart';
import 'package:vegetable_orders_project/views/home/pages/my_account/widget/custom_app_bar_account.dart';
import 'package:vegetable_orders_project/views/home/pages/my_account/widget/item_my_account.dart';
import '../../../../core/logic/helper_methods.dart';
import '../../../../features/categories/get_category_bloc.dart';
import '../../../../features/logout/logout_bloc.dart';
import '../../../../features/my_account/get_profile/get_profile_bloc.dart';
import '../../../../features/products/products_bloc.dart';
import '../../../../features/slider/slider_bloc.dart';
import '../../../../generated/locale_keys.g.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  final bloc = KiwiContainer().resolve<LogoutBloc>();

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SafeArea(
          child: Theme(
            data: ThemeData().copyWith(
              splashColor: Colors.transparent,
              primaryColor: AppColor.mainColor,
            ),
            child: ListView(
              addRepaintBoundaries: false,
              children: [
                const CustomAppBarAccount(),
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 22.h),
                  child: Column(
                    children: [
                      DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(
                              color: const Color(0xffF6F6F6),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () => navigateTo(
                                      toPage: const PersonalDataView(),
                                  ),
                                  child: ItemMyAccount(
                                    icon: 'account_details',
                                    title: LocaleKeys.my_account_personal_data
                                        .tr(),
                                  ),
                                ),
                                InkWell(
                                  onTap: () =>
                                      navigateTo(toPage: const WalletView()),
                                  child: ItemMyAccount(
                                    icon: 'Wallet',
                                    title: LocaleKeys.my_account_wallet.tr(),
                                  ),
                                ),
                                InkWell(
                                  onTap: () =>
                                      navigateTo(toPage: const TitlesView()),
                                  child: ItemMyAccount(
                                    icon: 'Location',
                                    title: LocaleKeys.my_account_addresses.tr(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ),
                      verticalSpace(18),
                      DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(
                              color: const Color(0xffF6F6F6),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () => navigateTo(
                                      toPage: const FrequentlyQuestionsView()),
                                  child: ItemMyAccount(
                                    icon: 'Questions',
                                    title: LocaleKeys.my_account_faqs.tr(),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => navigateTo(
                                      toPage: const PrivacyPolicyView()),
                                  child: ItemMyAccount(
                                    icon: 'privacy_policy',
                                    title: LocaleKeys.my_account_policy.tr(),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => navigateTo(
                                      toPage: const ConnectWithUsView()),
                                  child: ItemMyAccount(
                                    icon: 'Call_Calling',
                                    title: LocaleKeys.my_account_call_us.tr(),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => navigateTo(
                                      toPage:
                                      const SuggestionsComplaintsView()),
                                  child: ItemMyAccount(
                                    icon: 'Edit',
                                    title: LocaleKeys.my_account_complaints.tr(),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    const url =
                                        'https://play.google.com/store/apps/details?id=com.alalmiya.thamra';
                                    await Share.share(
                                        'This app is very usefull.\n\n$url');
                                  },
                                  child: ItemMyAccount(
                                    icon: 'share',
                                    title: LocaleKeys.my_account_share_app.tr(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ),
                      verticalSpace(18),
                      DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(
                              color: const Color(0xffF6F6F6),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () => navigateTo(
                                      toPage: const AboutApplicationView()),
                                  child: ItemMyAccount(
                                    icon: 'application',
                                    title: LocaleKeys.my_account_about_app.tr(),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    String code =
                                    context.locale.languageCode == "en"
                                        ? "ar"
                                        : "en";
                                    await context.setLocale(Locale(code));
                                    setState(() {});

                                    KiwiContainer()
                                        .resolve<ProfileBloc>()
                                        .add(GetProfileEvent());
                                    KiwiContainer().resolve<ProductsBloc>()
                                      ..isTransitionFav = true
                                      ..isTransitionProduct = true;
                                    KiwiContainer().resolve<GetCategoryBloc>().isTransitionCategory = true;
                                    KiwiContainer().resolve<SliderBloc>().isTransitionSlider = true;
                                  },
                                  child: ItemMyAccount(
                                    icon: 'language',
                                    title: LocaleKeys.my_account_change_language
                                        .tr(),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    navigateTo(toPage: const TermsView());
                                  },
                                  child: ItemMyAccount(
                                    icon: 'Note',
                                    title: LocaleKeys.my_account_terms.tr(),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    const url =
                                        'https://play.google.com/store/apps/details?id=com.alalmiya.thamra';
                                    await Share.share(
                                        'This app is very usefull.\n\n$url');
                                  },
                                  child: ItemMyAccount(
                                    icon: 'Star',
                                    title: LocaleKeys.my_account_rate_app.tr(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ),
                      verticalSpace(18),
                      DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(
                              color: const Color(0xffF6F6F6),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    bloc.add(LogoutEvent());
                                  },
                                  child: BlocBuilder(
                                    bloc: bloc,
                                    builder: (context, state) {
                                      if (state is LogoutLoadingState) {
                                        return SizedBox(
                                          height: 45.h,
                                          width: double.infinity,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color: AppColor.mainColor,
                                            ),
                                          ),
                                        );
                                      }
                                      return ItemMyAccount(
                                        title: LocaleKeys.my_account_log_out.tr(),
                                        icon: 'Turn_off',
                                        isLogout: true,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
