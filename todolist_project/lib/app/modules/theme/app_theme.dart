import 'package:todolist_project/app/modules/theme/app_images.dart';

import 'app_text_styles.dart';

class AppTheme {
  static final instance = AppTheme();

  final _textStyles = AppTextStyleImp();
  static AppTextStyle get textStyles => instance._textStyles;

  final _appImages = AppImagesImp();
  static AppImages get appImages => instance._appImages;
}
