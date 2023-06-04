import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneMask {
  static MaskTextInputFormatter maskFormatter() {
    return MaskTextInputFormatter(mask: '(##) #####-####');
  }
}
