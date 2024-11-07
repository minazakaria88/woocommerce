import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khoyout/core/helpers/cache_helper.dart';
import 'package:khoyout/feature/more/data/models/create_customer_model.dart';
import 'package:khoyout/feature/more/data/repositories/more_repo.dart';
import 'create_customer_state.dart';

class CreateCustomerCubit extends Cubit<CreateCustomerState> {

  CreateCustomerCubit({required this.moreRepo}) : super(InitCustomerState());

  final MoreRepo moreRepo;

  void createCustomer(CreateCustomerModel model) async {
    emit(CreateCustomerLoadingState());
    var result = await moreRepo.createCustomer(model);
    result.fold((l) => emit(CreateCustomerErrorState(l.message)), (r) {
      CacheHelper.saveData(key: CacheHelperKeys.createCustomer, value: r);
      emit(CreateCustomerSuccessState());
    });
  }


  void login(String email)async
  {
    emit(LoginCustomerLoadingState());
    var result=await moreRepo.login(email);
    result.fold((l) => emit(LoginCustomerErrorState(l.message)), (r) {
      if(r.isNotEmpty)
        {
          CacheHelper.saveData(key: CacheHelperKeys.createCustomer, value: r[0].id);
          emit(LoginCustomerSuccessState());
        }
      else
        {
          emit(LoginCustomerSuccessEmptyState());
        }
    });
  }



}
