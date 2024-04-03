// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:new_utibu_health_app/common/widgets/custom_button.dart';
import 'package:new_utibu_health_app/common/widgets/custom_form.dart';


class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              child: TabBar(
                controller: _tabController,
                isScrollable: false, // Disable horizontal scrolling
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                          value: 0,
                          groupValue: _tabController.index,
                          onChanged: (value) {
                            setState(() {
                              _tabController.index = value as int;
                            });
                          },
                        ),
                        Text("Delivery"),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                          value: 1,
                          groupValue: _tabController.index,
                          onChanged: (value) {
                            setState(() {
                              _tabController.index = value as int;
                            });
                          },
                        ),
                        Text('Pickup'),
                      ],
                    ),
                  ),
                ],
                onTap: (index) {
                  setState(() {
                    _tabController.index = index;
                  });
                },
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // View 1
                     ListView(
                    children: [
                      SizedBox(height: 20,),
                      CustomFormField(
              text1: 'Enter Location',
              text2: '(*),',
            ),
            SizedBox(
              height: 8,
            ),
            CustomFormField(
              text1: 'Building Name',
              text2: '(*)',
            ),
            SizedBox(
              height: 8,
            ),
            CustomFormField(
              text1: 'House/Apt No',
              text2: '(*)',
            ),
            SizedBox(
              height: 8,
            ),
            CustomFormField(
              text1: 'Email Address',
              text2: '(*)',
            ),
            SizedBox(
              height: 8,
            ),
            // CustomFormField(
            //   text1: 'Delivery Instructions',
            //   text2: '(*)',
            // ),
            // SizedBox(
            //   height: 8,
            // ),
            // CustomFormField(
            //   text1:
            //       'Size of Land leased out to others for farming  activities',
            //   text2: '(*)',
            // ),
            // SizedBox(
            //   height: 8,
            // ),
            // CustomFormField(
            //   text1: 'Size of Land lying completely idle',
            //   text2: '(*)',
            // ),
            // SizedBox(
            //   height: 8,
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12),
            //   child: Text("Accuracy"),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            Row(
              children: [
                Expanded(
                  child: CustomFormField(
                    text1: 'Name',
                    text2: '(*)',
                  ),
                ),
                Expanded(
                  child: CustomFormField(
                    text1: 'Surname',
                    text2: '(*)',
                  ),
                ),

                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.greenAccent),
                    animationDuration: Duration(milliseconds: 400),
                    surfaceTintColor: MaterialStatePropertyAll(Colors.greenAccent),
                  ),
                  onPressed: () {
                  
                }, child: Text("Pick Location"))
              ],
            ),
            SizedBox(height: 10,),
            CustomFormField(
              text1: 'Phone Number',
              text2: '(+254)',
            ),
            SizedBox(
              height: 8,
            ),
            CustomFormField(
              text1: 'Delivery Number(if any)',
              text2: '(+254)',
            ),
            const SizedBox(
              height: 8,
            ),
            CustomFormField(
              text1: 'Delivery Instructions',
              text2: '(*) ?',
            ),
            SizedBox(
              height: 30,
            ),
            CustomButton(
              text: 'Add Address', 
              ontap: () {
                
              },)
                      // Other widgets for Tab 1 content
                    ],
                  ),
                  // View 2
                  Center(
                    child: Text('View 2 Content'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
