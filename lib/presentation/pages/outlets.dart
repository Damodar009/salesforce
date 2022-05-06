import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class OutletsScreen extends StatelessWidget {
  const OutletsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue[900],
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Color.fromARGB(255, 74, 92, 148)),
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromARGB(255, 74, 92, 148)),
                          child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 15),
                              child: Text(
                                'Hello Frank',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color:
                                      const Color.fromARGB(255, 74, 92, 148)),
                              borderRadius: BorderRadius.circular(12),
                              color: const Color.fromARGB(255, 74, 92, 148)),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 7, vertical: 10),
                            child: Text(
                              'Topic of the news',
                              style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color:
                                      const Color.fromARGB(255, 142, 124, 34)),
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromARGB(255, 142, 124, 34)),
                          child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 5),
                              child: Text(
                                'Please Check in to entry your',
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color:
                                      const Color.fromARGB(255, 142, 124, 34)),
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromARGB(255, 142, 124, 34)),
                          child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 5),
                              child: Text(
                                'attendance for today. Then',
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color:
                                      const Color.fromARGB(255, 142, 124, 34)),
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromARGB(255, 142, 124, 34)),
                          child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 5),
                              child: Text(
                                'distance will be calculated.',
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 120,
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: const Color.fromARGB(255, 10, 3, 59)),
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromARGB(255, 10, 3, 59)),
                          child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 10),
                              child: Center(
                                  child: Text(
                                'View all',
                                style: TextStyle(color: Colors.white),
                              ))),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 5,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Container(
                            height: 5,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ]),
              ),
            ),
            Positioned(
              top: 110,
              left: 105,
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/frame.png'),)),
                child:
                    const Image(image: AssetImage('assets/images/Vector.png'), fit: BoxFit.contain,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
