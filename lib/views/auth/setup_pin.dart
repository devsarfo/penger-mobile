import 'package:flutter/material.dart';
import 'package:penger/controllers/auth.dart';
import 'package:penger/resources/app_colours.dart';
import 'package:penger/resources/app_spacing.dart';
import 'package:penger/resources/app_strings.dart';
import 'package:penger/resources/app_styles.dart';
import 'package:penger/utils/helper.dart';

class SetupPinScreen extends StatefulWidget {
  const SetupPinScreen({super.key});

  @override
  State<SetupPinScreen> createState() => _SetupPinScreenState();
}

class _SetupPinScreenState extends State<SetupPinScreen> {
  final _pinLength = 4;

  String _pin = "";
  String _pinConfirmation = "";
  int step = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.primaryColour,
      body: SafeArea(
        child: Column(
          children: [
            AppSpacing.vertical(size: 48),
            Text(
                step == 1 ? AppStrings.retypeYourPinAgain : AppStrings.letSetupYourPin,
                style: AppStyles.semibold(color: Colors.white)
            ),
            AppSpacing.vertical(size: 48),
            _inputIndicators(),
            const Spacer(),
            _inputNumbers()
          ],
        ),
      ),
    );
  }

  Widget _inputIndicators(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  List.generate(_pinLength, (index){
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              border: Border.all(color: AppColours.primaryColourLight.withOpacity(0.5),width: 4),
                color: ((step == 1 ? _pinConfirmation.length : _pin.length ) >= index + 1) ? Colors.white : Colors.transparent,
                shape: BoxShape.circle
            ),
          ),
        );
      }),
    );
  }

  Widget _inputNumbers(){
    return Column(
      children: [
        ...List.generate(3, (rowIndex){
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:  List.generate(3, (index){
              final number = (rowIndex * 3) + (index + 1);

              return Padding(
                padding: const EdgeInsets.all(8),
                child: TextButton(
                  onPressed: () => _selectNumber(number),
                  child: Text(number.toString(), style: AppStyles.medium(size: 48, color: Colors.white)),
                ),
              );
            }),
          );
        }),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(onPressed: _handleBackspace, icon: const Icon(Icons.backspace_outlined, color: Colors.white, size: 48,)),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextButton(
                onPressed: () => _selectNumber(0),
                child: Text("0", style: AppStyles.medium(size: 48, color: Colors.white)),
              )
            ),
            IconButton(onPressed: _handleSubmit, icon: const Icon(Icons.arrow_forward_outlined, color: Colors.white, size: 48,))
          ],
        )
      ],
    );
  }

  void _selectNumber(int number){
    if(step == 0) {
      if(_pin.length >= _pinLength) return;
      _pin = _pin + number.toString();
    } else if(step == 1) {
      if(_pinConfirmation.length >= _pinLength) return;
      _pinConfirmation = _pinConfirmation + number.toString();
    }

    setState(() {});
  }

  void _handleBackspace(){
    if(step == 0){
      if(_pin.isEmpty) return;
      _pin = _pin.substring(0, _pin.length - 1);
    } else if(step == 1){
      if(_pinConfirmation.isEmpty) return;
      _pinConfirmation = _pinConfirmation.substring(0, _pinConfirmation.length - 1);
    }

    setState(() {});

  }

  Future<void> _handleSubmit() async {
    if(step == 0) {
      if(_pin.length < _pinLength) return;

      setState(() => step = 1);
    } else if(step == 1) {
      if(_pinConfirmation.length < _pinLength) return;

      if(_pin != _pinConfirmation){
        Helper.snackBar(context, message: AppStrings.pinsDoNotMatch, isSuccess: false);
        setState((){
          step = 0;
          _pin = "";
          _pinConfirmation = "";
        });
        return;
      }

      // Submit
      var result = await AuthController.setPin(_pin);
      if(!result.isSuccess){
        Helper.snackBar(context, message: AppStrings.pinsDoNotMatch, isSuccess: false);
        return;
      }

      final route = await Helper.initialRoute();
      Navigator.of(context).pushNamedAndRemoveUntil(route, (Route<dynamic> route) => false);
    }
  }
}
