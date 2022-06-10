import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:latlong2/latlong.dart';
import 'package:salesforce/utils/validators.dart';
import '../../../../data/models/RetailerModel.dart';
import '../../../../domain/usecases/hiveUseCases/hiveUseCases.dart';
import '../../../../injectable.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/geolocation.dart';
import '../../../../utils/hiveConstant.dart';
import '../../../blocs/newOrdrBloc/new_order_cubit.dart';
import '../../../widgets/buttonWidget.dart';
import '../../../widgets/radioBotton.dart';
import '../../../widgets/textformfeild.dart';

class NewOutletsScreenOrder extends StatefulWidget {
  const NewOutletsScreenOrder({Key? key}) : super(key: key);

  @override
  _NewOutletsScreenOrderState createState() => _NewOutletsScreenOrderState();
}

class _NewOutletsScreenOrderState extends State<NewOutletsScreenOrder> {
  bool visiblity = false;
  bool loading = false;
  bool loadingMap = false;
  Position? position;
  List<String> retailerTypes = [];
  List<String> retailerTypesId = [];
  List<String> regionName = [];
  List<String> regionId = [];
  String selectedValue = "";
  String typesOfOutLets = "";
  String region = " ";
  final useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
  final geoLocation = getIt<GeoLocationData>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _outLetName = TextEditingController();
  final TextEditingController _contactPerson = TextEditingController();
  final TextEditingController _contactNumber = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _location = TextEditingController();

  void selectValueRadioButton(String selectValue) {
    setState(() {
      selectedValue = selectValue;
    });
  }

  String? validator(String? string) {
    if (string == null || string.isEmpty) {
      return 'this cannot be empty';
    }
    return null;
  }

  String? phoneValidator(String? string) {
    if (string!.length < 10) {
      return 'must be at least 10 digit';
    }
    return null;
  }

  bool formValidaation() {
    if (_formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  // todo put somewhere else

  getRetailerType() async {
    Box box = await Hive.openBox(HiveConstants.depotProductRetailers);
    var successOrNot = useCaseForHiveImpl.getValuesByKey(
      box,
      HiveConstants.retailerTypeKey,
    );
    successOrNot.fold(
        (l) => {print("no success")},
        (r) => {
              for (var i = 0; i < r.length; i++)
                {
                  print("success"),
                  retailerTypes.add(r[i].name),
                },
              print(retailerTypes)
            });
  }

  getRegion() async {
    print("getting region from hive box");
    Box box = await Hive.openBox(HiveConstants.depotProductRetailers);
    var successOrFailed =
        useCaseForHiveImpl.getValuesByKey(box, HiveConstants.regionKey);
    successOrFailed.fold(
        (l) => {print("getting depot from hive is failed ")},
        (r) => {
              for (var i = 0; i < r.length; i++)
                {
                  regionName.add(r[i].name),
                  regionId.add(r[i].id),
                }
            });
  }

  @override
  void initState() {
    getRetailerType();
    getRegion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var newOrderCubit = BlocProvider.of<NewOrderCubit>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            title("Name of Outlet"),
            const SizedBox(
              height: 7,
            ),
            textFormField(
                controller: _outLetName,
                validator: (string) {
                  return validator(string);
                },
                obsecureText1: () {},
                hintText: ''),

            const SizedBox(
              height: 12,
            ),
            title("Email"),
            const SizedBox(
              height: 7,
            ),

            textFormField(
                controller: _contactPerson,
                validator: (string) {
                  bool isValid = Validators.isValidEmail(string!);

                  if (isValid) {
                    return null;
                  } else {
                    return "enter valid email";
                  }
                },
                obsecureText1: () {},
                hintText: ''),
            const SizedBox(
              height: 12,
            ),

            title("Contact Number"),
            const SizedBox(
              height: 7,
            ),

            textFormField(
                textInputType: TextInputType.phone,
                controller: _contactNumber,
                validator: (string) {
                  return phoneValidator(string);
                },
                obsecureText1: () {},
                hintText: ''),
            const SizedBox(
              height: 12,
            ),

            //todo
            title("Address of the Outlets"),
            const SizedBox(
              height: 7,
            ),
            textFormField(
                controller: _address,
                validator: (string) {
                  return validator(string);
                },
                obsecureText1: () {},
                hintText: ''),

            const SizedBox(
              height: 12,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  title("Map"),
                  loadingMap
                      ? const CircularProgressIndicator(
                          strokeWidth: 1.5,
                        )
                      : InkWell(
                          onTap: () async {
                            setState(() {
                              loadingMap = true;
                            });
                            position = await geoLocation.getCurrentLocation();
                            setState(() {
                              visiblity = !visiblity;
                              _location.text = position!.longitude.toString() +
                                  " , " +
                                  position!.longitude.toString();
                              loadingMap = false;
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: AppColors.attendenceCard,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(
                              Icons.location_on_outlined,
                              size: 35,
                              color: AppColors.buttonColor,
                            ),
                          ),
                        ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Visibility(
                visible: visiblity,
                child: SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width * 0.88,
                  child: FlutterMap(
                    options: MapOptions(
                      center: position != null
                          ? LatLng(position!.latitude, position!.longitude)
                          : LatLng(51.5, -0.09),
                      zoom: 50.0,
                    ),
                    layers: [
                      TileLayerOptions(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c'],
                        attributionBuilder: (_) {
                          return const Text("© OpenStreetMap contributors");
                        },
                      ),
                      MarkerLayerOptions(
                        markers: [
                          Marker(
                            point: position != null
                                ? LatLng(
                                    position!.latitude, position!.longitude)
                                : LatLng(51.5, -0.09),
                            builder: (ctx) => Container(
                              height: 5,
                              width: 5,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),

            const SizedBox(
              height: 15,
            ),

            textFormField(
                controller: _location,
                validator: (string) {
                  return validator(string);
                },
                obsecureText1: () {},
                hintText: ' Longitude and latitude (map Location)'),
            const SizedBox(
              height: 12,
            ),
            title("Outlet class"),

            const SizedBox(
              height: 7,
            ),
            Row(
              children: [
                buildIndividualRadio(
                    "A class", selectedValue, selectValueRadioButton),
                buildIndividualRadio(
                    "B class", selectedValue, selectValueRadioButton),
                buildIndividualRadio(
                    "C class", selectedValue, selectValueRadioButton),
              ],
            ),
            //todo
            title("Types of Outlets"),
            const SizedBox(
              height: 7,
            ),
            textFeildWithDropDownFor(
                item: retailerTypes,
                validator: (string) {
                  if (typesOfOutLets != "") {
                    return null;
                  } else {
                    return "this cannot be empty";
                  }
                },
                onselect: (string) {
                  setState(() {
                    typesOfOutLets = string;
                  });
                },
                initialText: typesOfOutLets),

            const SizedBox(
              height: 12,
            ),

            title("Select Region"),
            const SizedBox(
              height: 7,
            ),

            textFeildWithDropDownFor(
                item: regionName,
                validator: (string) {
                  if (region != " ") {
                    return null;
                  } else {
                    return "this cannot be empty";
                  }
                },
                onselect: (string) {
                  setState(() {
                    region = string;
                  });
                },
                initialText: region),

            const SizedBox(
              height: 20,
            ),
            button("Add new Outlet", () async {
              if (formValidaation()) {
                setState(() {
                  loading = true;
                });
                int index = regionName.indexOf(region);
                String regions = regionId[index];
                int retailerIndex = retailerTypes.indexOf(typesOfOutLets);
                String retailerid = retailerTypesId[retailerIndex];
                RetailerModel retailer = RetailerModel(
                    name: _outLetName.text,
                    latitude: position!.latitude,
                    longitude: position!.longitude,
                    address: _address.text,
                    contactPerson: _contactPerson.text,
                    contactNumber: _contactNumber.text,
                    retailerClass: selectedValue.split(" ")[0],
                    retailerType: retailerid,
                    region: regions);

                newOrderCubit.getRetailers(retailer);
                print(newOrderCubit.state);

                setState(() {
                  loading = false;
                });
              } else {}
            }, loading, AppColors.buttonColor),
          ],
        ),
      ),
    );
  }

  Widget title(String title) {
    return Text(title);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
