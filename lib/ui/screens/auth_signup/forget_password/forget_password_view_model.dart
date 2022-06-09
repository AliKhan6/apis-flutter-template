import 'package:antonx_flutter_template/core/enums/view_state.dart';
import 'package:antonx_flutter_template/core/models/body/reset_password_body.dart';
import 'package:antonx_flutter_template/core/models/reponses/reset_password_response.dart';
import 'package:antonx_flutter_template/core/others/base_view_model.dart';
import 'package:antonx_flutter_template/core/services/auth_service.dart';
import 'package:antonx_flutter_template/ui/custom_widgets/dailogs/auth_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../locator.dart';

class ForgetPasswordScreenViewModel extends BaseViewModel {
  AuthService authService = locator<AuthService>();
  ResetPasswordBody resetPasswordBody = ResetPasswordBody();
  TextEditingController emailController = TextEditingController();
  late ResetPasswordResponse response;

  resetPassword() async {
    setState(ViewState.busy);
    response = await authService.resetPassword(resetPasswordBody);
    if (!response.success)
      Get.dialog(AuthDialog(title: 'Title', message: '${response.error}'));
    setState(ViewState.idle);
    Get.back();
  }
}
