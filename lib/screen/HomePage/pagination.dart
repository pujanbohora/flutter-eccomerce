import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:the_gadget_zone/api_helper/api_url.dart';
import 'package:the_gadget_zone/model/ads_model.dart';

class CarouselWidget extends StatelessWidget {
  final List<AdsModel> adsList;
  CarouselWidget(this.adsList);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          // color: Colors.blackShade,
        ),
        child: Column(
          children: [
            Container(
                // constraints: BoxConstraints(maxWidth: 300),
                height:  MediaQuery.of(context).size.width > 760 ? 200:130,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: adsList.length,
                    itemBuilder: (BuildContext context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width - 100,
                               ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    ApiUrl.baseUrl + '/' + adsList[index].img!),
                              )),
                        ),
                      );
                    })),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
