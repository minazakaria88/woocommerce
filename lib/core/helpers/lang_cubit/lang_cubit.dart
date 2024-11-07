import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khoyout/core/helpers/lang_cubit/lang_state.dart';

class LangCubit extends Cubit<LangState>
{
  LangCubit():super(LangInitState());

  String defaultLanguage='en';

  void changeLanguage()
  {
    if(defaultLanguage=='ar')
      {
        defaultLanguage='en';
      }
    else
      {
        defaultLanguage='ar';
      }
    emit(LangChangeState());
  }

}