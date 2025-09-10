import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vegetable_orders_project/core/logic/dio_helper.dart';
import 'package:vegetable_orders_project/core/utils/app_strings.dart';
import 'package:vegetable_orders_project/model/products_model.dart';
import '../../core/logic/helper_methods.dart';
part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvents, ProductsStates> {
  ProductsBloc() : super(ProductsStates()) {
    on<ProductsEvent>(_getData);
    on<GetFavsProductsEvent>(_getFavoriteData);
    on<AddProductsToFavsEvent>(_addProductToFavs);
    on<RemoveProductsFromFavsEvent>(_removeProductFromFavs);
  }

  bool isTransitionProduct = false;
  bool isTransitionFav = false;
  static Map<int, bool> favorites = {};
  List<ProductsModel> list = [];

  Future<void> _getData(ProductsEvent event, Emitter<ProductsStates> emit) async {
    emit(ProductsLoadingState());
    final response = await DioHelper().getData(
      endPoint: AppStrings.productsEndPoint,
    );
    if (response.isSuccess) {
      isTransitionProduct = false;
      final model = ProductsData.fromJson(response.response!.data);
      for(var element in model.model){
        favorites.addAll({element.id: element.isFavorite});
      }
      list = model.model;
      emit(ProductsSuccessState(list: list));
    } else {
      emit(ProductsFailureState(msg: response.message));
    }
  }


  List<ProductsModel> favsList = [];

  Future<void> _getFavoriteData(GetFavsProductsEvent event,Emitter<ProductsStates>emit)async{
    emit(GetFavoriteProductLoadingState());
    final response = await DioHelper().getData(endPoint: "client/products/favorites");
    if(response.isSuccess){
      isTransitionFav = false;
      final favsModel = ProductsData.fromJson(response.response!.data);
      favsList = favsModel.model;
      emit(GetFavoriteProductSuccessState());
    } else {
      emit(GetFavoriteProductFailureState(msg: response.message));
    }
  }


  Future<void> _addProductToFavs(AddProductsToFavsEvent event, Emitter<ProductsStates> emit) async {
    favorites[event.id] = !favorites[event.id]!;
    emit(StartAddSuccessState());
    final response = await DioHelper()
        .sendData(endPoint: 'client/products/${event.id}/add_to_favorite');
    if (response.isSuccess) {
      showMessage(
          message: response.response!.data['message'],
          type: MessageType.success);
      add(ProductsEvent());
      add(GetFavsProductsEvent(isLoading: true));
      emit(AddFavoriteSuccessState());
    } else {
      favorites[event.id] = !favorites[event.id]!;
      emit(StartRemoveSuccessState());
      showMessage(message: 'فشل في إضافة المنتج إلى المفضلة');
      emit(AddFavoriteFailedState());
    }
  }


  Future<void> _removeProductFromFavs(RemoveProductsFromFavsEvent event,Emitter<ProductsStates>emit)async{
    favorites[event.id] = !favorites[event.id]!;
    emit(StartRemoveSuccessState());
    final response = await DioHelper()
        .sendData(endPoint: 'client/products/${event.id}/remove_from_favorite');
    if (response.isSuccess && response.message.isNotEmpty) {
      showMessage(message: response.message, type: MessageType.success);
      add(ProductsEvent());
      add(GetFavsProductsEvent(isLoading: true));
      emit(RemoveFavoriteSuccessState());
    } else {
      favorites[event.id] = !favorites[event.id]!;
      emit(StartAddSuccessState());
      showMessage(message: 'فشل في إزالة المنتج من المفضلة');
      emit(RemoveFavoriteFailedState());
    }
  }
}