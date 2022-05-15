import 'package:flutter/material.dart';
import 'package:salesforce/routes.dart';
import '../../domain/usecases/useCaseForSalesPerson.dart';
import '../../injectable.dart';
import '../../utils/app_colors.dart';

class OutletScreen extends StatefulWidget {
  const OutletScreen({Key? key}) : super(key: key);

  @override
  _OutletScreenState createState() => _OutletScreenState();
}

class _OutletScreenState extends State<OutletScreen> {
  var useCaseForSalesPersonImpl = getIt<UseCaseForSalesPersonImpl>();
  @override
  void initState() {
    // TODO: implement initState
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, 
            children: [
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
                print("this is working");
        
                // UserDetailsModel useDetailModel = UserDetailsModel(
                //     contactNumber2: '33333333',
                //     temporaryAddress: 'kathmandu',
                //     dob: '1990-01-21',
                //     fullName: 'raj chaudhary',
                //     permanentAddress: 'butwal',
                //     gender: 'Male', full_name: '');
        
                // SalesPerson salesPerson = SalesPerson(
                //     userDetails: useDetailModel,
                //     id: 'r1szWT3fuMEWm4xeNQpGTw==',
                //     email: 'test123999@gmail.com',
                //     roleId: 'NGBifEuwYylJoyRt7a8bkA==',
                //     password: 'test123',
                //     phoneNumber: '0978678543');
        
                // print("this is the snfsf");
                // print(salesPerson) ;
        
                // var dd =
                //     await useCaseForSalesPersonImpl.saveSalesPerson(salesPerson);
        
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
          ]),
        )
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