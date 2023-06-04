import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CPFMask {
  static MaskTextInputFormatter maskFormatter() {
    return MaskTextInputFormatter(mask: '###.###.###-##');
  }
}
