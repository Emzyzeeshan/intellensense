import 'package:animations/animations.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
class Opencontainer extends StatefulWidget {
  Widget openBuilder;
  List<dynamic> closedBuilder;
  int duration;
  SwiperLayout swiperLayout;
  bool axis;
   Opencontainer({Key? key,required this.openBuilder,required this.closedBuilder,required this.duration,required this.swiperLayout,required this.axis}) : super(key: key);

  @override
  State<Opencontainer> createState() => _OpencontainerState();
}

class _OpencontainerState extends State<Opencontainer> {
  @override
  Widget build(BuildContext context) {
    return  OpenContainer(closedColor: Colors.transparent,
                                                  closedElevation: 0.0,
                                                  openElevation: 0.0,
                                                  openShape:
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                  closedShape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.0)),
                                                  ),
                                                  transitionType:
                                                      ContainerTransitionType
                                                          .fade,
                                                  transitionDuration:
                                                      const Duration(
                                                          milliseconds: 700),
                                                  openBuilder:
                                                      (context, action) {
                                                    return widget.openBuilder;
                                                    //  DiscoverPage(
                                                    //     initialPage: 1);
                                                  },
                                                  closedBuilder:
                                                      (context, action) {
                                                    return SizedBox(
                                                      height: 130,
                                                      width: 150,
                                                      child: Swiper(
                                                          itemWidth: 150,
                                                          itemHeight: 130,
                                                          duration: widget.duration,
                                                          layout: widget.swiperLayout,
                                                          scrollDirection:
                                                              widget.axis ==
                                                                      false
                                                                  ? Axis
                                                                      .vertical
                                                                  : Axis
                                                                      .horizontal,
                                                          autoplay: true,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return widget.closedBuilder[index];
                                                            //  NewschannelList[
                                                            //     index];
                                                          },
                                                          itemCount: 4,
                                                          pagination:
                                                              SwiperPagination(
                                                                  builder:
                                                                      DotSwiperPaginationBuilder(
                                                            size: 7,
                                                            color: Colors.grey,
                                                            activeColor: Colors
                                                                .blue.shade200,
                                                          ))),
                                                    );
                                                  },
                                                );
  }
}