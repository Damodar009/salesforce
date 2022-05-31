import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:latlong2/latlong.dart';
import 'package:salesforce/domain/entities/retailer.dart';
import 'package:salesforce/presentation/widgets/appBarWidget.dart';
import '../../domain/usecases/hiveUseCases/hiveUseCases.dart';
import '../../injectable.dart';
import '../../utils/app_colors.dart';
import '../../utils/geolocation.dart';
import '../../utils/hiveConstant.dart';
import '../widgets/buttonWidget.dart';
import '../widgets/radioBotton.dart';
import '../widgets/textformfeild.dart';

class NewOutletsScreen extends StatefulWidget {
  const NewOutletsScreen({Key? key}) : super(key: key);

  @override
  _NewOutletsScreenState createState() => _NewOutletsScreenState();
}

class _NewOutletsScreenState extends State<NewOutletsScreen> {
  bool outletsCreated = true;
  bool visiblity = false;
  bool loading = false;
  Position? position;
  List<String> retailerTypes = [];
  List<String> regionName = [];
  List<String> regionId = [];
  String region = " ";
  String selectedValue = "";
  String initialValue = "";
  final useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
  final geoLocation = getIt<GeoLocationData>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _outLetName = TextEditingController();
  final TextEditingController _contactPerson = TextEditingController();
  final TextEditingController _contactNumber = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _typesOfOutlet = TextEditingController();
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

  bool formValidation() {
    if (_formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  getRetailerType() async {
    Box box = await Hive.openBox(HiveConstants.depotProductRetailers);
    var sucessOrNot = useCaseForHiveImpl.getValuesByKey(
      box,
      HiveConstants.retailerTypeKey,
    );
    sucessOrNot.fold(
        (l) => {print("no success")},
        (r) => {
              for (var i = 0; i < r.length; i++)
                {
                  print(" success"),
                  retailerTypes.add(r[i].name),
                },
              print(retailerTypes)
            });
  }

  getRegion() async {
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
    return Scaffold(
      appBar: appBar(
          // icon: Icons.arrow_back_ios_new_outlined,
          navTitle: 'NEW OUTLETS',
          context: context
          // backNavigate: () {
          //   Navigator.pop(context);
          // },
          ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'Outlets already created',
                          style: TextStyle(color: Color(0xFF003049)),
                        ),
                        StatefulBuilder(builder: (context, setStat) {
                          return Checkbox(
                              value: outletsCreated,
                              activeColor: AppColors.buttonColor,
                              checkColor: Colors.white,
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => AppColors.buttonColor),
                              onChanged: (newValue) {
                                //todo write code for outletsCreated
                                setStat(() {
                                  outletsCreated = newValue!;
                                });
                              });
                        }),
                      ],
                    ),
                    title("Name of Outlet"),
                    const SizedBox(
                      height: 12,
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
                      height: 12,
                    ),

                    //todo

                    textFormField(
                        controller: _contactPerson,
                        validator: (string) {
                          return validator(string);
                        },
                        obsecureText1: () {},
                        hintText: ''),
                    const SizedBox(
                      height: 12,
                    ),

                    title("Contact Number"),
                    const SizedBox(
                      height: 12,
                    ),

                    textFormField(
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
                      height: 12,
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
                          InkWell(
                            onTap: () async {
                              position = await geoLocation.getCurrentLocation();
                              setState(() {
                                visiblity = !visiblity;
                                _location.text =
                                    position!.longitude.toString() +
                                        " , " +
                                        position!.longitude.toString();
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
                                  ? LatLng(
                                      position!.latitude, position!.longitude)
                                  : LatLng(51.5, -0.09),
                              zoom: 50.0,
                            ),
                            layers: [
                              TileLayerOptions(
                                urlTemplate:
                                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                subdomains: ['a', 'b', 'c'],
                                attributionBuilder: (_) {
                                  return const Text(
                                      "© OpenStreetMap contributors");
                                },
                              ),
                              MarkerLayerOptions(
                                markers: [
                                  Marker(
                                    point: position != null
                                        ? LatLng(position!.latitude,
                                            position!.longitude)
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
                      height: 20,
                    ),

                    textFormField(
                        controller: _location,
                        validator: (string) {},
                        obsecureText1: () {},
                        hintText: ' Longitude and latitude (map Location)'),
                    const SizedBox(
                      height: 12,
                    ),
                    title("Types of Outlets"),

                    const SizedBox(
                      height: 12,
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
                      height: 12,
                    ),
                    textFeildWithDropDownFor(
                        item: retailerTypes,
                        validator: (string) {},
                        onselect: (string) {
                          setState(() {
                            initialValue = string;
                          });
                        },
                        initialText: initialValue),

                    const SizedBox(
                      height: 20,
                    ),
                    title("Select Region"),
                    const SizedBox(
                      height: 7,
                    ),

                    textFeildWithDropDownFor(
                        item: regionName,
                        validator: (string) {},
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
                      if (formValidation()) {
                        setState(() {
                          loading = true;
                        });
                        //todo get region
                        int index = regionName.indexOf(region);
                        String regions = regionId[index];
                        Retailer retailer = Retailer(
                            name: _outLetName.toString(),
                            latitude: position!.latitude,
                            longitude: position!.longitude,
                            address: _address.toString(),
                            contactPerson: _contactPerson.toString(),
                            contactNumber: _contactNumber.toString(),
                            retailerClass: selectedValue,
                            retailerType: _typesOfOutlet.toString(),
                            region: regions);
                        print(retailer);

                        Box box = await Hive.openBox(HiveConstants.newRetailer);
                        var retailers = useCaseForHiveImpl.saveValuestoHiveBox(
                            box, retailer);

                        Future.delayed(const Duration(seconds: 3), () {});

                        retailers.fold(
                            (l) => {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('saving data is failed')))
                                },
                            (r) => {
                                  //todo emit hive success full and send to next page
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'data is saved to local database')))
                                });
                        setState(() {
                          loading = false;
                        });
                      } else {}
                    }, loading, AppColors.buttonColor),
                  ],
                ),
              ),
            ),
          );
        }),
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
