import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../core/logic/dio_helper.dart';
import '../../core/logic/helper_methods.dart';
import '../../model/cart_model.dart';
import '../../model/products_model.dart';
import '../../model/search_model.dart';
import '../../views/sheets/success_add_to_cart_sheet.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvents, CartStates> {
  CartBloc() : super(CartStates()) {
    on<ShowCartEvent>(_showCart);
    on<StoreProductCartEvent>(_storeProduct);
    on<DeleteProductCartEvent>(_deleteProduct);
    on<UpdateProductCartEvent>(_updateData);
    on<CounterProductsEvent>(_counterProduct);
  }

  CartData? cartData;
  List<CartModel> list = [];
  int amountProduct = 1;

  void _counterProduct(CounterProductsEvent event, Emitter<CartStates> emit) {
    if (event.isAdd) {
      amountProduct++;
      emit(AddCounterSuccessState());
    } else {
      amountProduct--;
      emit(MinusCounterSuccessState());
    }
  }

  Future<void> _showCart(ShowCartEvent event, Emitter<CartStates> emit)async{
    if (event.isLoading) {
      emit(GetCartLoadingState());
    }
    final response = await DioHelper().getData(endPoint: "client/cart");

    if (response.isSuccess) {
      showMessage(
        message: response.message,
        type: MessageType.success,
      );
      final model = CartData.fromJson(response.response!.data);
      cartData = model;
      list = model.list;
      emit(GetCartSuccessState(model: cartData!, list: list));
    } else {
      emit(GetCartFailureState());
      showMessage(message: response.message);
    }
  }

  Future<void> _storeProduct(StoreProductCartEvent event, Emitter<CartStates> emit) async {
    emit(AddToCartLoadingState(id: event.id));
    final response = await DioHelper().sendData(endPoint: "client/cart", data: {
      "product_id": "${event.id}",
      "amount": '${event.amount}',
    });

    if (response.isSuccess) {
      if (event.isProduct) {
        showModalBottomSheet(
          context: navigatorKey.currentContext!,
          builder: (context) => SuccessAddToCartSheet(
            model: event.model,
            searchModel: event.searchModel,
          ),
        );
      } else {
        showMessage(
          message: response.message,
          type: MessageType.success,
        );
      }
      add(ShowCartEvent(isLoading: false));
      emit(AddToCartSuccessState());
    } else {
      emit(AddToCartFailedState());
      showMessage(message: 'لم يتم إضافة المنتج');
    }
  }


  Future<void> _updateData(UpdateProductCartEvent event, Emitter<CartStates> emit) async {
    emit(UpdateAmountLoadingState());
    final response = await DioHelper()
        .updateData(endPoint: "client/cart/${event.id}", data: {
      'amount': event.amount,
    });

    if (response.isSuccess) {
      add(ShowCartEvent(isLoading: false));
      emit(UpdateAmountSuccessState());
    } else {
      showMessage(message: response.message);
      emit(UpdateAmountFailedState());
    }
  }


  Future<void> _deleteProduct(DeleteProductCartEvent event, Emitter<CartStates> emit) async {
    emit(DeleteFromCartLoadingState(id: event.id));
    Navigator.pop(navigatorKey.currentContext!);
    final response = await DioHelper()
        .deleteData(endPoint: 'client/cart/delete_item/${event.id}');

    if (response.isSuccess) {
      list.removeWhere((element) => element.id == event.id);

      emit(DeleteFromCartSuccessState());
      showMessage(message: response.message, type: MessageType.success);
      add(ShowCartEvent(isLoading: false));
    } else {
      emit(DeleteFromCartFailedState());
    }
  }
}
