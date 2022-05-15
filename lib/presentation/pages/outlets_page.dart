import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:salesforce/data/datasource/remoteSource/salesDataRemoteSource.dart';
import 'package:salesforce/data/models/RetailerModel.dart';
import 'package:salesforce/domain/entities/SalesData.dart';
import 'package:salesforce/routes.dart';
import 'package:uuid/uuid.dart';
import '../../data/models/AvailabilityModel.dart';
import '../../data/models/SalesModel.dart';
import '../../data/models/returnModel.dart';
import '../../utils/app_colors.dart';

class OutletScreen extends StatefulWidget {
  const OutletScreen({Key? key}) : super(key: key);

  @override
  _OutletScreenState createState() => _OutletScreenState();
}

class _OutletScreenState extends State<OutletScreen> {
  // var useCaseForSalesPersonImpl = getIt<UseCaseForSalesPersonImpl>();
  SalesDataRemoteSourceImpl _salesDataRemoteSourceImpl =
      SalesDataRemoteSourceImpl();
  @override
  void initState() {
    // TODO: implement initState
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(
            height: 75,
          ),
          const Text(
            "Outlets",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          outletsCard(
              "Create new orders",
              "To create new Orders and \n send or save the data ",
              " Add now",
              Routes.newOrderRoute),
          outletsCard(
              "Create new Outlets",
              "To Create New Outlets and \nSave Outlets",
              "Add now",
              Routes.newOutletsRoute),
          outletsCard("Sales Data Collection", "From\n 2022/1/1/ to 2022/1/1",
              "Check In", Routes.salesDataCollection),
          InkWell(
            onTap: () async {
              List<SalesModel> sales = [];
              List<AvailabilityModel> availability = [];
              List<ReturnsModel> returns = [];
              for (var i = 0; i < 3; i++) {}

              /// sales
              SalesModel sale1 =
                  SalesModel(sales: 120, product: "Nh5PXNgMPBdS1gqJOz7PoQ==");
              sales.add(sale1);
              SalesModel sale2 =
                  SalesModel(sales: 12, product: "Nh5PXNgMPBdS1gqJOz7PoQ==");
              sales.add(sale2);

              ///  avaiolability
              AvailabilityModel availability1 = AvailabilityModel(
                  stock: 25,
                  availability: true,
                  product: "Nh5PXNgMPBdS1gqJOz7PoQ==");
              AvailabilityModel availability2 = AvailabilityModel(
                  stock: 234,
                  availability: true,
                  product: "Nh5PXNgMPBdS1gqJOz7PoQ==");

              availability.addAll([availability1, availability2]);

              /// returns
              ReturnsModel returns1 = ReturnsModel(
                  returned: 21, product: 'Nh5PXNgMPBdS1gqJOz7PoQ==');
              ReturnsModel returns2 = ReturnsModel(
                  returned: 25, product: 'Nh5PXNgMPBdS1gqJOz7PoQ==');

              /// retailer
              RetailerModel retailer1 = RetailerModel(
                  name: "saurav stor",
                  latitude: 21.21,
                  longitude: 21.21,
                  address: "kathmandu",
                  contactPerson: "sauravs",
                  contactNumber: "1234567890",
                  retailerClass: "A",
                  retailerType: "506buVWacVShn32ccOHCTw==",
                  region: "NGBifEuwYylJoyRt7a8bkA==");

              RetailerModel retailer2 = RetailerModel(
                  name: "saurav chor",
                  latitude: 21.21,
                  longitude: 21.21,
                  address: "kathmandu",
                  contactPerson: "sauravs",
                  contactNumber: "1234567890",
                  retailerClass: "A",
                  retailerType: "506buVWacVShn32ccOHCTw==",
                  region: "NGBifEuwYylJoyRt7a8bkA==");

              returns.addAll([returns1, returns2]);

              SalesData salesData = SalesData(
                  sales: sales,
                  availability: availability,
                  returns: returns,
                  salesDescription: "test",
                  returnedDescription: "test",
                  stockDescription: "test",
                  availabilityDescription: "all damage",
                  assignedDepot: "ZRlecVfxmjPY1xs!@sHCIgXP2Q==",
                  collectionDate: "2021-01-01",
                  latitude: 20.21,
                  longitude: 20.21,
                  paymentType: "CREDIT",
                  paymentdocument: "abcdsadsa",
                  userId: "KdNUBc6r+5WeVj1uUOLKnw==",
                  retiler: retailer1);

              SalesData salesDat2a = SalesData(
                  sales: sales,
                  availability: availability,
                  returns: returns,
                  salesDescription: "test",
                  returnedDescription: "test",
                  stockDescription: "test",
                  availabilityDescription: "all damage",
                  assignedDepot: "ZRlecVfxmjPY1xs!@sHCIgXP2Q==",
                  collectionDate: "2021-01-01",
                  latitude: 20.21,
                  longitude: 20.21,
                  paymentType: "CREDIT",
                  paymentdocument: "abcdsadsa",
                  userId: "KdNUBc6r+5WeVj1uUOLKnw==",
                  retiler: retailer2);

              List<SalesData> listSalesData = [salesData, salesDat2a];

              Uuid uuid = Uuid();
              String v4 = uuid.v4();
              String v5 = uuid.v4();

              await _salesDataRemoteSourceImpl
                  .saveSalesData(listSalesData, [v4, v5]);
              if (kDebugMode) {
                print("this is success ");
              }

              // var dd =
              //  //   await useCaseForSalesPersonImpl.saveSalesPerson(salesPerson);
              //
              // dd.fold(
              //     (l) => {
              //           if (l is ServerFailure)
              //             {print("this is failure")}
              //           else if (l is CacheFailure)
              //             {print("this is failure")}
              //         },
              //     (r) => print(r));
            },
            child: outletsCardOutline(Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image(
                        height: 50,
                        width: 50,
                        color: AppColors.buttonColor,
                        image: AssetImage("assets/icons/outletsicon.png")),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Request for Correction",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Please enter your Queries or Issues ")
                      ],
                    ),
                  )
                ],
              ),
            )),
          )
        ])
      ],
    );
  }

  Widget outletsCard(
      String title, String subtitle, String text, String navigateTo) {
    return outletsCardOutline(
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(title, style: const TextStyle(fontSize: 18)),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(subtitle, style: const TextStyle(fontSize: 12)),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  text,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(navigateTo);
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                          color: const Color(0xffF29F05),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.arrow_forward,
                      size: 35,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget outletsCardOutline(Widget widget) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
          decoration: BoxDecoration(
              color: const Color(0xffB5E8FC),
              borderRadius: BorderRadius.circular(15)),
          child: widget),
    );
  }
}
