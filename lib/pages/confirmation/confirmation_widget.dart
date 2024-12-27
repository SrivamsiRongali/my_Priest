// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'dart:convert';

import 'package:get/get.dart';
import 'package:my_priest/index.dart';
import 'package:my_priest/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../my_bookings/Mybookings.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'confirmation_model.dart';
export 'confirmation_model.dart';

class ConfirmationWidget extends StatefulWidget {
  const ConfirmationWidget({super.key});

  @override
  State<ConfirmationWidget> createState() => _ConfirmationWidgetState();
}

class _ConfirmationWidgetState extends State<ConfirmationWidget> {
  late ConfirmationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  var data = Get.arguments;
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ConfirmationModel());

    _model.datetextController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.timetextController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.address1textController3 ??= TextEditingController();
    _model.textFieldFocusNode3 ??= FocusNode();

    _model.address2textController4 ??= TextEditingController();
    _model.textFieldFocusNode4 ??= FocusNode();

    _model.citytextController5 ??= TextEditingController();
    _model.textFieldFocusNode5 ??= FocusNode();

    _model.statetextController6 ??= TextEditingController();
    _model.textFieldFocusNode6 ??= FocusNode();

    _model.textController7 ??= TextEditingController();
    _model.textFieldFocusNode7 ??= FocusNode();
    print("passed data ${data[0]}");
    print("passed data ${data[1]}");
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool loader = true;
  String selectedTime = "00:00";
  Future userbooking(String date, String time, int priestid, List serviceid,
      String notes) async {
    setState(() {
      loader = false;
    });
    ;
    print(
        " date = ${date}T${time}:00.00Z,priest=$priestid,serviceid=$serviceid");
    var data = json.encode({
      "bookingDate": "${date}T${time}:00",
      "description": notes,
      "priestId": priestid,
      "servicesId": serviceid,
    });

    Map mapresponse;
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("servicetime", "${date},${time}");
    var token = sharedPreferences.getString("token");
    http.Response response = await http.post(
        Uri.parse("https://${AppConstants.ipaddress.ipaddress}/api/bookings"),
        headers: {
          "accept": "*/*",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: data);

    if (response.statusCode == 200) {
      mapresponse = json.decode(response.body);
      setState(() {
        loader = true;
      });
      Get.to(SuccessWidget(),
          );
      print('Booking successfull');

      print(response.body);

      //     razorpay.open({
      // 'key': 'rzp_test_mtBEoRXCieHNgB',
      // 'amount': mapresponse['paymentParams']['amount'], //in paise.
      // 'name': 'first order',
      // 'order_id': '${mapresponse['paymentParams']['id']}', // Generate order_id using Orders API
      // 'description': 'Fine T-Shirt',
      // 'timeout': 600, // in seconds
      // 'prefill': {
      //   'contact': '8919806771',
      //   'email': 'rongalisrivamsi@gmail.com'
      // }});

      ;
    } else {
      setState(() {
        loader = true;
      });

      print(" data =$data");
      print('fail');
      Get.defaultDialog(
        title: "Unable book",
        titleStyle: TextStyle(color: Colors.red),
        content: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Text("Please try after some time",
              style: TextStyle(color: Colors.black)),
        ),
        actions: [
          MaterialButton(
            color: Color.fromARGB(255, 255, 123, 0),
            onPressed: () {
              Get.back();
            },
            child: Text(
              'ok',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
      print(response.statusCode);
      print(response.body);
    }
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: Color(0xFFFFF7EA),
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF1E2022),
              size: 30.0,
            ),
            onPressed: () async {
              Get.back();
            },
          ),
          actions: [
            Align(
              alignment: AlignmentDirectional(-1.0, 0.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                child: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 8.0,
                  buttonSize: 40.0,
                  fillColor: Color(0x00FFFFFF),
                  icon: Icon(
                    Icons.menu,
                    color: Color(0xFF1E2022),
                    size: 30.0,
                  ),
                  onPressed: () {
                    print('IconButton pressed ...');
                  },
                ),
              ),
            ),
          ],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 10.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Image.asset(
                                    'assets/images/Mask_Group.png',
                                    width: 70.0,
                                    height: 70.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15.0, 0.0, 0.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data[1]['priest']['user']['userName'],
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              fontSize: 12.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w300,
                                            ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        data[1]['priest']['user']['address'][0]
                                                ['city']['name'] +
                                            ', ' +
                                            data[1]['priest']['user']['address']
                                                [0]['city']['state']['name'] +
                                            ', ' +
                                            data[1]['priest']['user']['address']
                                                    [0]['city']['state']
                                                ['country']['name'],
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              fontSize: 12.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w300,
                                            ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xFFF2F3F4),
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      15.0, 5.0, 15.0, 5.0),
                                              child: Text(
                                                'Hindi',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          fontSize: 10.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 5.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xFFF2F3F4),
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      15.0, 5.0, 15.0, 5.0),
                                              child: Text(
                                                'telugu',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          fontSize: 10.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 20.0, 0.0, 10.0),
                        child: ListView.builder(
                          itemCount: data[0].length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) =>
                              Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFFF2F3F4),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 10.0, 10.0, 10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Icon(
                                          Icons.check_circle,
                                          color: FlutterFlowTheme.of(context)
                                              .success,
                                          size: 24.0,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5.0, 0.0, 0.0, 0.0),
                                          child: Container(
                                            width: screensize.width * 0.62,
                                            child: Text(
                                              data[0][index]['name'],
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15.0, 5.0, 15.0, 5.0),
                                        child: Text(
                                          '${NumberFormat.simpleCurrency(locale: "hi-IN", decimalDigits: 2).format(data[0][index]['defaultPrice'])}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                fontSize: 10.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w300,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding:
                      //       EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                      //   child: Container(
                      //     width: double.infinity,
                      //     decoration: BoxDecoration(
                      //       color: Color(0xFFF2F3F4),
                      //     ),
                      //     child: Padding(
                      //       padding: EdgeInsetsDirectional.fromSTEB(
                      //           10.0, 10.0, 10.0, 10.0),
                      //       child: Row(
                      //         mainAxisSize: MainAxisSize.max,
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Row(
                      //             mainAxisSize: MainAxisSize.max,
                      //             children: [
                      //               Icon(
                      //                 Icons.check_circle,
                      //                 color: FlutterFlowTheme.of(context).success,
                      //                 size: 24.0,
                      //               ),
                      //               Padding(
                      //                 padding: EdgeInsetsDirectional.fromSTEB(
                      //                     5.0, 0.0, 0.0, 0.0),
                      //                 child: Text(
                      //                   'Chandi Homam',
                      //                   style: FlutterFlowTheme.of(context)
                      //                       .bodyMedium
                      //                       .override(
                      //                         fontFamily: 'Inter',
                      //                         fontSize: 16.0,
                      //                         letterSpacing: 0.0,
                      //                         fontWeight: FontWeight.normal,
                      //                       ),
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //           Container(
                      //             decoration: BoxDecoration(
                      //               color: FlutterFlowTheme.of(context)
                      //                   .secondaryBackground,
                      //               borderRadius: BorderRadius.circular(24.0),
                      //             ),
                      //             child: Padding(
                      //               padding: EdgeInsetsDirectional.fromSTEB(
                      //                   15.0, 5.0, 15.0, 5.0),
                      //               child: Text(
                      //                 '800',
                      //                 style: FlutterFlowTheme.of(context)
                      //                     .bodyMedium
                      //                     .override(
                      //                       fontFamily: 'Inter',
                      //                       fontSize: 10.0,
                      //                       letterSpacing: 0.0,
                      //                       fontWeight: FontWeight.w300,
                      //                     ),
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Text(
                        'Date/Time',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              color: Color(0xFFFD642A),
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 10.0, 0.0, 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Container(
                                width: 200.0,
                                child: TextFormField(
                                  controller: _model.datetextController1,
                                  focusNode: _model.textFieldFocusNode1,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelText: 'Select Date',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w300,
                                        ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w300,
                                        ),
                                    filled: true,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    suffixIcon: Icon(
                                      Icons.calendar_today_outlined,
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                  cursorColor: Colors.black,
                                  onTap: () async {
                                    DateTime? pickeddate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2050),
                                      builder: (context, child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme: ColorScheme.light(
                                              primary: Color.fromARGB(255, 214,
                                                  98, 35), // <-- SEE HERE
                                              onPrimary:
                                                  Colors.white, // <-- SEE HERE
                                              onSurface:
                                                  Colors.black, // <-- SEE HERE
                                            ),
                                            textButtonTheme:
                                                TextButtonThemeData(
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors
                                                    .orange, // button text color
                                              ),
                                            ),
                                          ),
                                          child: child!,
                                        );
                                      },
                                    );
                                    if (pickeddate != null) {
                                      setState(() {
                                        _model.datetextController1.text =
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickeddate);
                                      });
                                    }
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Required";
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.none,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                width: 200.0,
                                child: TextFormField(
                                  controller: _model.timetextController2,
                                  focusNode: _model.textFieldFocusNode2,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelText: 'Select Time',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w300,
                                        ),
                                    filled: true,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    suffixIcon: Icon(
                                      Icons.access_time,
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                  cursorColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  onTap: () async {
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                      builder: (BuildContext context,
                                          Widget? child) {
                                        return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                              alwaysUse24HourFormat: false),
                                          child: Theme(
                                            data: ThemeData.light().copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary: Color.fromARGB(
                                                    255, 214, 98, 35),
                                                onSurface: Color.fromARGB(
                                                    255, 214, 98, 35),
                                                onSecondaryContainer:
                                                    Color.fromARGB(
                                                        255, 214, 98, 35),
                                              ),
                                              buttonTheme: ButtonThemeData(
                                                colorScheme: ColorScheme.light(
                                                  primary: Color.fromARGB(
                                                      255, 214, 98, 35),
                                                ),
                                              ),
                                            ),
                                            child: child!,
                                          ),
                                        );
                                      },
                                    );

                                    if (pickedTime != null) {
                                      DateTime currentDate = DateTime.now();
                                      DateTime selectedDateTime = DateTime(
                                        currentDate.year,
                                        currentDate.month,
                                        currentDate.day,
                                        pickedTime.hour,
                                        pickedTime.minute,
                                        1,
                                        currentDate.millisecond,
                                      );

                                      selectedTime = DateFormat('HH:mm')
                                          .format(selectedDateTime);
                                      print("object: $selectedTime");

                                      _model.timetextController2.text =
                                          "${pickedTime.hourOfPeriod.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')} ${pickedTime.period.index == 0 ? 'AM' : 'PM'}";
                                    }
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Required";
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Enter Address',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              color: Color(0xFFFD642A),
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                        child: Container(
                          width: double.infinity,
                          child: TextFormField(
                            controller: _model.address1textController3,
                            focusNode: _model.textFieldFocusNode3,
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: true,
                              labelText: 'Address Line 1',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                              filled: true,
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                ),
                            cursorColor:
                                FlutterFlowTheme.of(context).primaryText,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Required";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                        child: Container(
                          width: double.infinity,
                          child: TextFormField(
                            controller: _model.address2textController4,
                            focusNode: _model.textFieldFocusNode4,
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: true,
                              labelText: 'Address Line 2',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                              filled: true,
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                ),
                            cursorColor:
                                FlutterFlowTheme.of(context).primaryText,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Required";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                        child: Container(
                          width: double.infinity,
                          child: TextFormField(
                            controller: _model.citytextController5,
                            focusNode: _model.textFieldFocusNode5,
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: true,
                              labelText: 'City',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                              filled: true,
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                ),
                            cursorColor:
                                FlutterFlowTheme.of(context).primaryText,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Required";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: TextFormField(
                          controller: _model.statetextController6,
                          focusNode: _model.textFieldFocusNode6,
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            labelText: 'State',
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w300,
                                ),
                            filled: true,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                          cursorColor: FlutterFlowTheme.of(context).primaryText,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      FlutterFlowDropDown<String>(
                        controller: _model.dropDownValueController ??=
                            FormFieldController<String>(null),
                        options: ['India', 'USA', 'Australia'],
                        onChanged: (val) =>
                            safeSetState(() => _model.dropDownValue = val),
                        width: double.infinity,
                        height: 40.0,
                        textStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w300,
                                ),
                        hintText: 'Select Country',
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 24.0,
                        ),
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        elevation: 2.0,
                        borderColor: Colors.transparent,
                        borderWidth: 0.0,
                        borderRadius: 8.0,
                        margin: EdgeInsetsDirectional.fromSTEB(
                            12.0, 0.0, 12.0, 0.0),
                        hidesUnderline: true,
                        isOverButton: false,
                        isSearchable: false,
                        isMultiSelect: false,
                      ),
                      Text(
                        'Add notes',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              color: Color(0xFFFD642A),
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      Container(
                        width: double.infinity,
                        child: TextFormField(
                          controller: _model.textController7,
                          focusNode: _model.textFieldFocusNode7,
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            labelText: 'Add notes',
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w300,
                                ),
                            filled: true,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                          cursorColor: FlutterFlowTheme.of(context).primaryText,
                          validator: _model.textController7Validator
                              .asValidator(context),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            if (_model.dropDownValue == null) {
                              Get.defaultDialog(
                                title: "",
                                titleStyle: TextStyle(color: Colors.red),
                                content: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Text("Please select country",
                                      style: TextStyle(color: Colors.black)),
                                ),
                                actions: [
                                  MaterialButton(
                                    color: Color.fromARGB(255, 255, 123, 0),
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      'ok',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              if (loader = true) {
                                List service_id = [];
                                for (int n = 0; n < data[0].length; n++) {
                                  service_id.add(data[0][n]['id']);
                                }
                                print("Service ids = $service_id");
                                if (service_id.length > 0) {
                                  userbooking(
                                      _model.datetextController1.text,
                                      selectedTime,
                                      data[1]['priestId'],
                                      service_id,
                                      _model.address1textController3.text +
                                          _model.address2textController4.text +
                                          _model.citytextController5.text +
                                          _model.statetextController6.text +
                                          _model.dropDownValue.toString() +
                                          '__' +
                                          _model.textController7.text);
                                }
                              }
                            }
                          }

                          //     Navigator.push(context,
                          // MaterialPageRoute(builder: (context) => SuccessWidget()));
                        },
                        text: 'Continue',
                        options: FFButtonOptions(
                          width: double.infinity,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 25.0, 16.0, 25.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: Color(0xFFFFF6EA),
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Inter Tight',
                                    color: Color(0xFFD66223),
                                    letterSpacing: 0.0,
                                  ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: Color(0xFFD66223),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
