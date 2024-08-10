import 'package:advance_mvvm/app/di.dart';
import 'package:advance_mvvm/data/mapper/mapper.dart';
import 'package:advance_mvvm/presentation/common/state_renderer/state_render_impl.dart';
import 'package:advance_mvvm/presentation/register/register_viewmodel.dart';
import 'package:advance_mvvm/presentation/resources/assets_manager.dart';
import 'package:advance_mvvm/presentation/resources/color_manager.dart';
import 'package:advance_mvvm/presentation/resources/routes_manager.dart';
import 'package:advance_mvvm/presentation/resources/strings_manager.dart';
import 'package:advance_mvvm/presentation/resources/values_manager.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameTextEditingController = TextEditingController();
  final TextEditingController _mobileNumberTextEditingController = TextEditingController();
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _viewModel.start();
    _userNameTextEditingController.addListener(() {
      _viewModel.setUserName(_userNameTextEditingController.text);
    });

    _mobileNumberTextEditingController.addListener(() {
      _viewModel.setMobileNumber(_mobileNumberTextEditingController.text);
    });

    _emailTextEditingController.addListener(() {
      _viewModel.setEmail(_emailTextEditingController.text);
    });

    _passwordTextEditingController.addListener(() {
      _viewModel.setPassword(_passwordTextEditingController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        elevation: AppSize.s0,
        iconTheme: IconThemeData(color: ColorManager.primary),
        backgroundColor: ColorManager.white,
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return Center(
            child: snapshot.data?.getScreenWidget(context, _getContentWidget(), () {
                  _viewModel.register();
                }) ??
                _getContentWidget(),
          );
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p60),
      child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Image(image: AssetImage(ImageAssets.splashLogo)),
                const SizedBox(height: AppSize.s2),
                Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<String>(
                    stream: _viewModel.outputErrorUserName,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _userNameTextEditingController,
                        decoration: InputDecoration(
                          hintText: AppStrings.username,
                          labelText: AppStrings.username,
                          errorText: snapshot.data),
                      );
                    },
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: AppPadding.p28,
                    right: AppPadding.p28,bottom: AppPadding.p28),
                    child: Row(
                      children: [
                        Expanded(flex:1,child: CountryCodePicker(
                          onChanged: (country){
                            _viewModel.setMobileNumber(country.dialCode ?? EMPTY);
                          },
                          initialSelection: "+91",
                          showCountryOnly: true,
                          showOnlyCountryWhenClosed: true,
                          favorite: ["+966","+02","+39"],
                        ),),
                        Expanded(flex:3,child: StreamBuilder<String>(
                          stream: _viewModel.outputErrorMobileNumber,
                          builder: (context, snapshot) {
                            return TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: _userNameTextEditingController,
                              decoration: InputDecoration(
                                  hintText: AppStrings.mobileNumber,
                                  labelText: AppStrings.mobileNumber,
                                  errorText: snapshot.data),
                            );
                          },
                        ),),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.s28),
                Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<String>(
                    stream: _viewModel.outputErrorEmail,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailTextEditingController,
                        decoration: InputDecoration(
                            hintText: AppStrings.email,
                            labelText: AppStrings.email,
                            errorText: snapshot.data),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSize.s28),
                Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<String>(
                    stream: _viewModel.outputErrorPassword,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordTextEditingController,
                        decoration: InputDecoration(
                          hintText: AppStrings.password,
                          labelText: AppStrings.password,
                          errorText: snapshot.data,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSize.s28),
                Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsAllInputsValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(
                            onPressed: (snapshot.data ?? false)
                                ? () {
                              _viewModel.register();
                            }
                                : null,
                            child: const Text(AppStrings.login)),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppPadding.p8,
                    left: AppPadding.p28,
                    right: AppPadding.p28,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, Routes.forgetPasswordRoute);
                        },
                        child: const Text(
                          AppStrings.forgetPassword,
                          // style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, Routes.registerRoute);
                        },
                        child: const Text(
                          AppStrings.registerText,
                          // style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
