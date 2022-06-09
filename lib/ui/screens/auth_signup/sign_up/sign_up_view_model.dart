import 'package:antonx_flutter_template/core/enums/view_state.dart';
import 'package:antonx_flutter_template/core/models/body/signup_body.dart';
import 'package:antonx_flutter_template/core/models/reponses/auth_response.dart';
import 'package:antonx_flutter_template/core/others/base_view_model.dart';
import 'package:antonx_flutter_template/core/services/auth_service.dart';
import 'package:antonx_flutter_template/core/services/file_picker_service.dart';
import 'package:antonx_flutter_template/ui/custom_widgets/dailogs/auth_dialog.dart';
import 'package:antonx_flutter_template/ui/screens/root/root_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../locator.dart';

class SignUpViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final FilePickerService _imagePickerServic = locator<FilePickerService>();
  int? selectedGenderIndex;
  SignUpBody signUpBody = SignUpBody();
  late AuthResponse response;

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  bool passwordVisibility = true;

  togglePasswordVisibility() {
    setState(ViewState.busy);
    passwordVisibility = !passwordVisibility;
    setState(ViewState.idle);
  }

  updateIndex(val) {
    selectedGenderIndex = val;
    notifyListeners();
  }

  requestSignUp() async {
    setState(ViewState.busy);
    signUpBody.gender = selectedGenderIndex == 0 ? "Male" : "Female";
    response = await _authService.signupWithEmailAndPassword(signUpBody);
    if (!response.success)
      Get.dialog(AuthDialog(title: 'Title', message: 'Message here...'));
    else
      Get.offAll(RootScreen());
    setState(ViewState.idle);
  }

  pickImage() async {
    signUpBody.image = await _imagePickerServic.pickImage();
    notifyListeners();
  }
}
