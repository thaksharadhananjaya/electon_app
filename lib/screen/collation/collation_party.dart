import 'package:another_flushbar/flushbar.dart';
import 'package:election_app/components/button.dart';
import 'package:election_app/components/collation_row.dart';
import 'package:election_app/repo/repo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CollationParty extends StatefulWidget {
  final String registered, accredited, rejected;
  CollationParty({Key key, this.registered, this.accredited, this.rejected})
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

  bool isLoading = false, isSubmit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          toolbarHeight: 40),
      body: SafeArea(
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.78,
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                          bottom: 32, left: 80, right: 80, top: 24),
                      child: isSubmit
                          ? CustomButton(
                              isLoading: isLoading,
                              label: 'Cancel',
                              backgroundColor: Colors.red,
                              onPress: cancelSubmit)
                          : CustomButton(
                            backgroundColor: Colors.green,
                              isLoading: isLoading,
                              label: 'Submit',
                              onPress: submit),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void submit() async {
    String textA = textAController.text;
    String textAA = textAACController.text;
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

      isSubmit = await Repo.addCollation(
          reg: widget.registered,
          accredited: widget.accredited,
          rejected: widget.rejected,
          textA: textA,
          textAA: textAA,
          textADP: textADP,
          textAPP: textAPP,
          textAAC: textAAC,
          textADC: textADC,
          textAPC: textAPC,
          textAPGA: textAPGA,
          textAPM: textAPM,
          textBP: textBP,
          textLP: textLP,
          textNRM: textNRM,
          textNNPP: textNNPP,
          textPDP: textPDP,
          textPRP: textPRP,
          textSDP: textSDP,
          textYPP: textYPP,
          textZLP: textZLP);
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

  void cancelSubmit() async {
    setState(() {
      isLoading = true;
    });

    String textA = textAController.text;
    String textAA = textAACController.text;
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

    isSubmit = await Repo.cancelCollation(
        reg: widget.registered,
        accredited: widget.accredited,
        rejected: widget.rejected,
        textA: textA,
        textAA: textAA,
        textADP: textADP,
        textAPP: textAPP,
        textAAC: textAAC,
        textADC: textADC,
        textAPC: textAPC,
        textAPGA: textAPGA,
        textAPM: textAPM,
        textBP: textBP,
        textLP: textLP,
        textNRM: textNRM,
        textNNPP: textNNPP,
        textPDP: textPDP,
        textPRP: textPRP,
        textSDP: textSDP,
        textYPP: textYPP,
        textZLP: textZLP);
    setState(() {
      isLoading = false;
    });
  }
}
