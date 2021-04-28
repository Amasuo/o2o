import 'package:ecommerce_app_ui_kit/src/Controller/Location_Picker_Controller.dart';
import 'package:ecommerce_app_ui_kit/src/Provider/Location_Picker_Provider.dart';
import 'package:get/get.dart';
import 'package:place_picker/place_picker.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';

class LocationWidget extends StatefulWidget {
  @override
  _LocationWidgetState createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  /*LocationProvider _locationProvider;

  @override
  void initState() {
    super.initState();
    _locationProvider = Provider.of<LocationProvider>(context, listen: false);
    _locationProvider?.getcurrentLocantionAndadrees(context);
  }*/

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Theme.of(context).primaryColor,
        ),
        child: GetBuilder<LocationController>(
          init: LocationController(),
          initState: (_) => LocationController.to.getcurrentLocantionAndadrees(),
          builder: (controller) {
            if (controller.loading){
              return Container(
                child: Center(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    child: ListTile(
                      leading: Icon(Icons.location_on),
                      title: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        width: 150,
                        height: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            }
            else {
              return ListTile(
                  onTap: () async {
                    LocationResult result = await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => PlacePicker(
                                "AIzaSyD6ijb43zMaxEZCfGP_XF7Cc4NgIByAGS0"
                            )
                        )
                    );
                    controller.changecurrentLocantionAndadrees(context, result);
                  },
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
                  title: Row(
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Selected Location :"),
                      Spacer(),
                      Expanded(
                        child: Text(
                          controller.location.loacality +
                              ", " +
                              controller.location.countryName,
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],
                  ),
                  trailing: Icon(Icons.arrow_forward_ios)
              );
            }
          },
        ),
        /*child: Consumer<LocationProvider>(
          builder: (context, provider, widget) {
            if (provider.loading)
              return Container(
                child: Center(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    child: ListTile(
                      leading: Icon(Icons.location_on),
                      title: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        width: 150,
                        height: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            else
              return ListTile(
                  onTap: () async {
                    LocationResult result = await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => PlacePicker(
                                "AIzaSyD6ijb43zMaxEZCfGP_XF7Cc4NgIByAGS0")));
                    provider.changecurrentLocantionAndadrees(context, result);
                  },
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
                  title: Row(
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Selected Location :"),
                      Spacer(),
                      Text(
                        provider.location.loacality +
                            ", " +
                            provider.location.countryName,
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  trailing: Icon(Icons.arrow_forward_ios)
              );
          },
        )*/
    );
  }
}
