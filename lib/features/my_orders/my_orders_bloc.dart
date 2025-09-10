import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta/meta.dart';
import '../../core/logic/dio_helper.dart';
import '../../core/logic/helper_methods.dart';
import '../../model/all_order_model.dart';
import '../../model/order_model.dart';
import '../../views/sheets/thank_you_sheet.dart';
part 'my_orders_event.dart';
part 'my_orders_state.dart';

class MyOrdersBloc extends Bloc<MyOrdersEvents, MyOrdersStates> {
  MyOrdersBloc() : super(MyOrdersStates()) {
    on<GetCurrentOrdersEvent>(_getCurrentOrder);
    on<GetFinishedOrdersEvent>(_getFinishedOrder);
    on<GetMyOrderEvent>(_getMyOrder);
    on<CancelOrderEvent>(_cancelOrder);
    on<AddOrderEvent>(_addOrder);
  }

  bool isLoading = true;
  List<CurrentOrdersModel> currentOrders = [];
  List<CurrentOrdersModel> finishedOrders = [];

  Future<void> _getCurrentOrder(
    GetCurrentOrdersEvent event,
    Emitter<MyOrdersStates> emit,
  ) async {
    if (event.isLoading || isLoading) {
      emit(GetCurrentOrdersLoadingState());
    }
    final response = await DioHelper().getData(
      endPoint: '/client/orders/current',
    );
    if (response.isSuccess) {
      emit(GetCurrentOrdersSuccessState());
      currentOrders = AllOrdersData.fromJson(response.response!.data).list;
      if (currentOrders.isEmpty) {
        emit(GetCurrentOrdersEmptyState(isEmpty: true));
      }
      isLoading = false;
    } else {
      emit(GetCurrentOrdersFailedState());
    }
  }

  Future<void> _getFinishedOrder(
    GetFinishedOrdersEvent event,
    Emitter<MyOrdersStates> emit,
  ) async {
    if (event.isLoading || isLoading) {
      emit(GetFinishedOrdersLoadingState());
    }
    final response = await DioHelper().getData(
      endPoint: '/client/orders/finished',
    );
    if (response.isSuccess) {
      emit(GetFinishedOrdersSuccessState());
      finishedOrders = AllOrdersData.fromJson(response.response!.data).list;
      if (finishedOrders.isEmpty) {
        emit(GetFinishedOrdersEmptyState(isEmpty: true));
      }
      isLoading = false;
    } else {
      emit(GetFinishedOrdersFailedState());
    }
  }

  OrderModel? orderModel;

  Future<void> _getMyOrder(
    GetMyOrderEvent event,
    Emitter<MyOrdersStates> emit,
  ) async {
    emit(GetOrderLoadingState());

    final response = await DioHelper().getData(
      endPoint: '/client/orders/${event.id}',
    );
    if (response.isSuccess) {
      emit(GetOrderSuccessState());
      orderModel = MyOrderData.fromJson(response.response!.data).data;
    } else {
      emit(GetOrderFailedState());
    }
  }

  Future<void> _cancelOrder(
    CancelOrderEvent event,
    Emitter<MyOrdersStates> emit,
  ) async {
    emit(CancelOrderLoadingState());
    final response = await DioHelper().sendData(
      endPoint: '/client/orders/${event.id}/cancel',
    );
    if (response.isSuccess) {
      add(GetCurrentOrdersEvent(isLoading: true));
      add(GetFinishedOrdersEvent(isLoading: true));
      Future.delayed(const Duration(milliseconds: 300), () {
        Navigator.pop(navigatorKey.currentContext!);
      });
      Future.delayed(const Duration(milliseconds: 2000), () {});
    } else {
      emit(CancelOrderFailedState());
    }
  }

  String? addressId;
  TextEditingController? note;

  Future<void> _addOrder(
    AddOrderEvent event,
    Emitter<MyOrdersStates> emit,
  ) async {
    emit(AddOrderLoadingState());
    final response = await DioHelper().sendData(
      endPoint: '/client/orders',
      data: {
        'note': note?.text,
        'address_id': addressId,
        'pay_type': event.payType,
        'date': event.date,
        'time': event.time,
      },
    );
    if (response.isSuccess) {
      emit(AddOrderSuccessState());
      showModalBottomSheet(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35.r),
            topRight: Radius.circular(35.r),
          ),
        ),
        context: navigatorKey.currentContext!,
        builder: (context) => const ThankYouSheet(),
      );
    } else {
      emit(AddOrderFailedState());
      showMessage(message: response.message, type: MessageType.success);
    }
  }
}
