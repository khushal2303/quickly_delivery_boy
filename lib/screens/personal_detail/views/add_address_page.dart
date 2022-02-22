import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickly_delivery/constants/constants.dart';
import 'package:quickly_delivery/custom_widgets/top_bar.dart';
import 'package:quickly_delivery/data/profile/models/personal_detail_request.dart';
import 'package:quickly_delivery/screens/location_search/place_service.dart';
import 'package:quickly_delivery/screens/personal_detail/bloc/profile_bloc.dart';
import 'package:quickly_delivery/screens/personal_detail/location_bloc/location_bloc.dart';
import 'package:quickly_delivery/styles/colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quickly_delivery/styles/theme.dart';
import 'package:quickly_delivery/utils/helpers.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({
    Key? key,
  }) : super(key: key);

  static const routeName = "/add_address";

  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  GoogleMapController? _controller;
  CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(23.05122945, 72.51197561059564),
    zoom: 14.4746,
  );
  Set<Marker> markers = {};

  FormGroup buildForm() => fb.group(<String, Object>{
        'house': FormControl<String>(
          validators: [Validators.required],
        ),
        'landmark':
            FormControl<String>(value: "", validators: [Validators.required]),
        'how_to_reach': FormControl<String>(),
      });

  final Widget sizeBox = const SizedBox(
    height: 16,
  );

  PlaceApiProvider? apiClient;

  @override
  void initState() {
    final sessionToken = const Uuid().v4();
    apiClient = PlaceApiProvider(sessionToken);
    context.read<LocationBloc>().add(const GetCurrentLocationEvent());
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }

  Future<void> _addMarker(tmpLat, tmpLng) async {
    MarkerId markerId = const MarkerId("currentMarker");
    final Uint8List? markerIcon =
        await getBytesFromAsset(ConstantImages.locationPinIcon, 100);

    // creating a new MARKER
    if (markerIcon != null) {
      final Marker marker = Marker(
        icon: BitmapDescriptor.fromBytes(markerIcon),
        markerId: markerId,
        position: LatLng(tmpLat, tmpLng),
      );

      Set<Marker> _markers = {};
      _markers.add(marker);

      setState(() {
        markers = _markers;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const TopBar(
        title: 'Enter Address',
      ),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2.2,
            child: BlocListener<LocationBloc, LocationState>(
              listener: (context, state) {
                if (state is GetCurrentLocationFailure) {
                  Helpers.showSnackbar(context, state.error, true);
                }
                if (state is GetCurrentLocationSuccess) {
                  _addMarker(state.latitude, state.longitude);
                  _controller!.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                      bearing: 0,
                      target: LatLng(state.latitude, state.longitude),
                      zoom: 50.0,
                    ),
                  ));
                }
              },
              child: BlocBuilder<LocationBloc, LocationState>(
                builder: (context, state) {
                  return Stack(
                    children: [
                      GoogleMap(
                        mapType: MapType.normal,
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: _kGooglePlex,
                        compassEnabled: false,
                        markers: markers,
                        // myLocationEnabled: true,
                        // myLocationButtonEnabled: true,
                        zoomControlsEnabled: false,
                        onCameraMove: (position) {},
                      ),
                      if (state is LocationGettingState)
                        if (state.isBusy == true)
                          Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height / 2.2,
                            child: Helpers.loadingWidget(),
                          ),
                    ],
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height / 2.1,
            right: 14,
            child: InkWell(
              onTap: () {
                context
                    .read<LocationBloc>()
                    .add(const GetCurrentLocationEvent());
              },
              child: Image.asset(
                ConstantImages.locationIcon,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height / 2.2,
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: getBody(),
            ),
          ),
        ],
      ),
    );
  }

  Widget getBody() {
    return ReactiveFormBuilder(
      form: buildForm,
      builder: (formContext, form, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 14, left: 14, right: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter your address",
                style: TextStyles.medium17(AppColors.blackColor),
              ),
              sizeBox,
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    CustomUnderlineTextField<String>(
                      formControlName: 'house',
                      titleText: "House",
                      validationMessages: (control) => {
                        ValidationMessage.required: "House can't be empty",
                      },
                    ),
                    sizeBox,
                    CustomUnderlineTextField<String>(
                      titleText: "Landmark",
                      formControlName: 'landmark',
                      validationMessages: (control) => {
                        ValidationMessage.required: "Landmark can't be empty",
                      },
                    ),
                    sizeBox,
                    CustomUnderlineTextField<String>(
                      titleText: "How to reach (Optional)",
                      formControlName: 'how_to_reach',
                      validationMessages: (control) => {},
                    ),
                    sizeBox,
                  ],
                ),
              ),
              getSaveAddressButton(formContext),
              sizeBox,
            ],
          ),
        );
      },
    );
  }

  Widget getSaveAddressButton(BuildContext formContext) {
    return ReactiveFormConsumer(
      builder: (formContext, form, child) {
        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: (form.valid == true)
                    ? () async {
                        log(form.value.toString());

                        try {
                          Place place = await apiClient!.getPlaceDetailFromId(
                              context.read<ProfileBloc>().state.googlePlaceId ??
                                  "");
                          UserAddress userAddress = UserAddress(
                            addressType: "home",
                            city: place.city,
                            pinCode: place.zipCode,
                            isSetManually: true,
                            landMark:
                                form.controls["landmark"]?.value as String,
                            country: place.country,
                            houseNumberAndBuildingName:
                                form.controls["house"]?.value as String,
                            userId: Constants.userId,
                          );
                          context
                              .read<ProfileBloc>()
                              .add(SetAddressEvent(userAddress));
                        } catch (e) {
                          log("=======Error While getting address=========");
                          log(e.toString());
                        }
                        Navigator.of(context).popUntil((route) {
                          if (route.settings.name == '/personal_detail') {
                            return true;
                          } else {
                            return false;
                          }
                        });
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  textStyle: TextStyles.medium17(AppColors.whiteColor),
                ),
                child: const Text('Save Address'),
              ),
            ),
          ],
        );
      },
    );
  }
}

class CustomUnderlineTextField<T> extends StatelessWidget {
  final String? hint;
  final String formControlName;
  final TextInputType keyboardType;
  final String? errorText;
  final String? titleText;
  final Map<String, String> Function(FormControl<String>)? validationMessages;
  final Function()? onEditingComplete;
  final bool readOnly;
  final Function()? onTap;
  const CustomUnderlineTextField({
    Key? key,
    this.hint,
    required this.formControlName,
    this.keyboardType = TextInputType.text,
    this.errorText,
    this.titleText,
    this.validationMessages,
    this.onEditingComplete,
    this.readOnly = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (titleText != null) ...[
          Text(
            titleText ?? "",
            style: TextStyles.semiBold10(AppColors.lightColor),
          ),
        ],
        ReactiveTextField<String>(
          readOnly: readOnly,
          onTap: onTap,
          onEditingComplete: onEditingComplete,
          formControlName: formControlName,
          validationMessages: validationMessages,
          keyboardType: keyboardType,
          style: TextStyles.semiBold15(AppColors.blackColor),
          cursorColor: Colors.black.withOpacity(0.5),
          decoration: InputDecoration(
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                width: 1,
                color: AppColors.dividerColor,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                width: 1,
                color: AppColors.dividerColor,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                width: 1,
                color: AppColors.dividerColor,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.only(left: 10),
            hintText: hint,
            hintStyle: TextStyles.semiBold10(AppColors.lightColor),
            counterText: "",
          ),
        ),
      ],
    );
  }
}
