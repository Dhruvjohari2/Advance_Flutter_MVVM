import 'dart:io';

import 'package:advance_mvvm/app/app_prefs.dart';
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
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  ImagePicker picker = instance<ImagePicker>();
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

    _viewModel.isUserLoggedInSuccessfullyStreamController.stream.listen((iSuccessLoggedIn) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _appPreferences.setIsUserLoggedIn();
        Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
      });
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
            }));
  }

  Widget _getContentWidget() {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p30),
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
                        decoration: InputDecoration(hintText: AppStrings.username, labelText: AppStrings.username, errorText: snapshot.data),
                      );
                    })),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: AppPadding.p12, left: AppPadding.p12, right: AppPadding.p28, bottom: AppPadding.p12),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: CountryCodePicker(
                          onChanged: (country) {
                            _viewModel.setMobileCode(country.dialCode ?? EMPTY);
                          },
                          initialSelection: "+91",
                          showCountryOnly: true,
                          hideMainText: true,
                          showOnlyCountryWhenClosed: true,
                          favorite: const ["+966", "+02", "+39", "+91"],
                        )),
                    Expanded(
                        flex: 3,
                        child: StreamBuilder<String>(
                            stream: _viewModel.outputErrorMobileNumber,
                            builder: (context, snapshot) {
                              return TextFormField(
                                keyboardType: TextInputType.phone,
                                controller: _mobileNumberTextEditingController,
                                decoration:
                                    InputDecoration(hintText: AppStrings.mobileNumber, labelText: AppStrings.mobileNumber, errorText: snapshot.data),
                              );
                            })),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSize.s18),
            Padding(
                padding: const EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<String>(
                    stream: _viewModel.outputErrorEmail,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailTextEditingController,
                        decoration: InputDecoration(hintText: AppStrings.email, labelText: AppStrings.email, errorText: snapshot.data),
                      );
                    })),
            const SizedBox(height: AppSize.s18),
            Padding(
                padding: const EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<String>(
                    stream: _viewModel.outputErrorPassword,
                    builder: (context, snapshot) {
                      return TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordTextEditingController,
                        decoration: InputDecoration(hintText: AppStrings.password, labelText: AppStrings.password, errorText: snapshot.data),
                      );
                    })),
            const SizedBox(height: AppSize.s18),
            Padding(
                padding: const EdgeInsets.only(top: AppPadding.p12, left: AppPadding.p28, right: AppPadding.p28),
                child: Container(
                    height: AppSize.s40,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorManager.lightGrey),
                    ),
                    child: GestureDetector(
                      child: _getMediaWidget(),
                      onTap: () {
                        _showPicker(context);
                      },
                    ))),
            const SizedBox(height: AppSize.s18),
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
                          child: const Text(AppStrings.register)));
                },
              ),
            ),
            Center(
              // padding: const EdgeInsets.only(top: AppPadding.p8, left: AppPadding.p28, right: AppPadding.p28),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  AppStrings.haveAccount,
                  // style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget _getMediaWidget() {
    return Padding(
        padding: const EdgeInsets.only(left: AppPadding.p8, right: AppPadding.p8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Flexible(child: Text(AppStrings.profilePicture)),
            Flexible(
                child: StreamBuilder<File>(
                    stream: _viewModel.outputProfilePicture,
                    builder: (context, snapshot) {
                      return _imagePickedByUser(snapshot.data);
                    })),
            const Flexible(child: Icon(Icons.camera_alt))
          ],
        ));
  }

  Widget _imagePickedByUser(File? image) {
    if (image != null && image.path.isNotEmpty) {
      return Image.file(image);
    } else {
      return Container();
    }
  }

  _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
              child: Wrap(
            children: [
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.photo),
                title: const Text(AppStrings.photoGallery),
                onTap: () {
                  imageFormGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.camera),
                title: const Text(AppStrings.photoCamera),
                onTap: () {
                  imageFormCamera();
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
        });
  }

  imageFormGallery() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  imageFormCamera() async {
    final image = await picker.pickImage(source: ImageSource.camera);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
