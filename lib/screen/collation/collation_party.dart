// ignore_for_file: use_build_context_synchronously

import 'package:another_flushbar/flushbar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:election_app/components/button.dart';
import 'package:election_app/components/collation_row.dart';
import 'package:election_app/config.dart';
import 'package:election_app/main.dart';
import 'package:election_app/repo/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/customDailog.dart';

class CollationParty extends StatefulWidget {
  final int registered, accredited, rejected, type;
  final bool mode;
  final data;
  const CollationParty(
      {Key key,
      this.registered,
      this.accredited,
      this.rejected,
      this.mode,
      this.type,
      this.data})
      : super(key: key);

  @override
  State<CollationParty> createState() => _CollationPartyState();
}

class _CollationPartyState extends State<CollationParty> {
  TextEditingController textAController = TextEditingController();

  TextEditingController textAAController = TextEditingController();

  TextEditingController textADPController = TextEditingController();

  TextEditingController textAPPController = TextEditingController();

  TextEditingController textAACController = TextEditingController();

  TextEditingController textADCController = TextEditingController();

  TextEditingController textAPCController = TextEditingController();

  TextEditingController textAPGAController = TextEditingController();

  TextEditingController textAPMController = TextEditingController();

  TextEditingController textBPController = TextEditingController();

  TextEditingController textLPController = TextEditingController();

  TextEditingController textNRMontroller = TextEditingController();

  TextEditingController textNNPPController = TextEditingController();

  TextEditingController textPDPController = TextEditingController();

  TextEditingController textPRPController = TextEditingController();

  TextEditingController textSDPController = TextEditingController();

  TextEditingController textYPPController = TextEditingController();

  TextEditingController textZLPController = TextEditingController();

  bool isLoading = false;
  String resText = '';

  @override
  void initState() {
    super.initState();
    if (widget.type == 0) fillTextFeilds();
  }

  void fillTextFeilds() {
    textAController.text = widget.data['A'].toString();
    textAACController.text = widget.data['AAC'].toString();
    textADCController.text = widget.data['ADC'].toString();
    textADPController.text = widget.data['ADP'].toString();
    textAPCController.text = widget.data['APC'].toString();
    textAPGAController.text = widget.data['APGA'].toString();
    textAPMController.text = widget.data['APM'].toString();
    textAPPController.text = widget.data['APP'].toString();
    textBPController.text = widget.data['BP'].toString();
    textLPController.text = widget.data['LP'].toString();
    textNNPPController.text = widget.data['NNPP'].toString();
    textPDPController.text = widget.data['PDP'].toString();
    textPRPController.text = widget.data['PRP'].toString();
    textSDPController.text = widget.data['SDP'].toString();
    textYPPController.text = widget.data['YPP'].toString();
    textAAController.text = widget.data['AA'].toString();
    textZLPController.text = widget.data['ZLP'].toString();
    textNRMontroller.text = widget.data['NRM'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
          title: Text(widget.mode
              ? (widget.type == 0
                  ? 'Presidential Collation'
                  : (widget.type == 1 ? 'Senate Collation' : 'Rep Collation'))
              : (widget.type == 0
                  ? 'Presidential Cancel'
                  : (widget.type == 1 ? 'Senate Cancel' : 'Rep Cancel'))),
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          toolbarHeight: 40),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.87,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Party',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: Text('Score',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20),
                          )),
                    )
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                CollationRow(
                  label: 'A',
                  textController: textAController,
                ),
                CollationRow(
                  label: 'AA',
                  textController: textAAController,
                ),
                CollationRow(
                  label: 'ADP',
                  textController: textADPController,
                ),
                CollationRow(
                  label: 'APP',
                  textController: textAPPController,
                ),
                CollationRow(
                  label: 'AAC',
                  textController: textAACController,
                ),
                CollationRow(
                  label: 'ADC',
                  textController: textADCController,
                ),
                CollationRow(
                  label: 'APC',
                  textController: textAPCController,
                ),
                CollationRow(
                  label: 'APGA',
                  textController: textAPGAController,
                ),
                CollationRow(
                  label: 'APM',
                  textController: textAPMController,
                ),
                CollationRow(
                  label: 'BP',
                  textController: textBPController,
                ),
                CollationRow(
                  label: 'LP',
                  textController: textLPController,
                ),
                CollationRow(
                  label: 'NRM',
                  textController: textNRMontroller,
                ),
                CollationRow(
                  label: 'NNPP',
                  textController: textNNPPController,
                ),
                CollationRow(
                  label: 'PDP',
                  textController: textPDPController,
                ),
                CollationRow(
                  label: 'PRP',
                  textController: textPRPController,
                ),
                CollationRow(
                  label: 'SDP',
                  textController: textSDPController,
                ),
                CollationRow(
                  label: 'YPP',
                  textController: textYPPController,
                ),
                CollationRow(
                  label: 'ZLP',
                  textController: textZLPController,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10, left: 80, right: 80, top: 24),
                  child:CustomButton(
                          backgroundColor: Colors.green,
                          isLoading: isLoading,
                          label: 'Submit',
                          onPress: submit)
                     ,
                ),
                Text(
                  resText,
                  style: TextStyle(
                      color: widget.mode ? Colors.green : kPrimeryColor),
                ),
                const SizedBox(
                  height: 32,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submit() async {
    String textA = textAController.text;
    String textAA = textAAController.text;
    String textADP = textADPController.text;
    String textAPP = textAPPController.text;
    String textAAC = textAACController.text;
    String textADC = textADCController.text;
    String textAPC = textAPCController.text;
    String textAPGA = textAPGAController.text;
    String textAPM = textAPMController.text;
    String textBP = textBPController.text;
    String textLP = textLPController.text;
    String textNRM = textNNPPController.text;
    String textNNPP = textNNPPController.text;
    String textPDP = textPDPController.text;
    String textPRP = textPRPController.text;
    String textSDP = textSDPController.text;
    String textYPP = textYPPController.text;
    String textZLP = textZLPController.text;

    if (textA.isNotEmpty &&
        textAA.isNotEmpty &&
        textADP.isNotEmpty &&
        textAPP.isNotEmpty &&
        textAAC.isNotEmpty &&
        textADC.isNotEmpty &&
        textAPC.isNotEmpty &&
        textAPGA.isNotEmpty &&
        textAPM.isNotEmpty &&
        textBP.isNotEmpty &&
        textLP.isNotEmpty &&
        textNRM.isNotEmpty &&
        textNNPP.isNotEmpty &&
        textPDP.isNotEmpty &&
        textPRP.isNotEmpty &&
        textSDP.isNotEmpty &&
        textYPP.isNotEmpty &&
        textZLP.isNotEmpty) {
      setState(() {
        isLoading = true;
      });

      var data = await Repo.addCollation(
          type: widget.type,
          reg: widget.registered,
          accredited: widget.accredited,
          rejected: widget.rejected,
          textA: int.parse(textA),
          textAA: int.parse(textAA),
          textADP: int.parse(textADP),
          textAPP: int.parse(textAPP),
          textAAC: int.parse(textAAC),
          textADC: int.parse(textADC),
          textAPC: int.parse(textAPC),
          textAPGA: int.parse(textAPGA),
          textAPM: int.parse(textAPM),
          textBP: int.parse(textBP),
          textLP: int.parse(textLP),
          textNRM: int.parse(textNRM),
          textNNPP: int.parse(textNNPP),
          textPDP: int.parse(textPDP),
          textPRP: int.parse(textPRP),
          textSDP: int.parse(textSDP),
          textYPP: int.parse(textYPP),
          textZLP: int.parse(textZLP));
      if (data['success']) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          headerAnimationLoop: false,
          animType: AnimType.rightSlide,
          title: 'Submitted',
          desc: "Submited by\n${data['person']} at\n${data['time']}",
          btnOkOnPress: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: ((context) => Main(
                          index: 2,
                        ))));
          },
        ).show();

        const storage = FlutterSecureStorage();
        if (widget.type == 0) {
          await storage.write(key: 'presidential', value: '1');
        } else if (widget.type == 1) {
          await storage.write(key: 'senate', value: '1');
        } else {
          await storage.write(key: 'rep', value: '1');
        }
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          title: 'Unauthenticated',
          desc: "You are not Authorized !",
          btnOkOnPress: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: ((context) => Main(
                          index: 2,
                        ))));
            // nav.pop();
          },
        ).show();
      }
      /* if (widget.mode) {
        resText = "Submited by\n${data['person']} at\n${data['time']}";
      } else {
        resText = '';
        Flushbar(
          messageText: const Text(
            'Some thing went wrong!',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
          ),
          //backgroundColor: kPrimeryColor,
          duration: const Duration(seconds: 3),
          icon: const Icon(
            Icons.warning_rounded,
            color: Colors.red,
          ),
        ).show(context);
      } */
      setState(() {
        isLoading = false;
      });
    } else {
      Flushbar(
        messageText: const Text(
          'All feilds are requied!',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
        ),
        //backgroundColor: kPrimeryColor,
        duration: const Duration(seconds: 3),
        icon: const Icon(
          Icons.warning_rounded,
          color: Colors.red,
        ),
      ).show(context);
    }
  }



  
}
