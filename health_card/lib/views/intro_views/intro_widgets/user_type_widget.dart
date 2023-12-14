import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_card/bloc/auth/auth_bloc.dart';
import 'package:health_card/bloc/auth/auth_event.dart';
import 'package:health_card/bloc/auth/auth_statee.dart';
import 'package:health_card/consts/colors.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';

class UserType extends StatelessWidget {
  const UserType({
    super.key,
    required this.isPatient,
  });
  final bool isPatient;

  @override
  Widget build(BuildContext context) {
    bool? stateVal;
    return InkWell(
      onTap: () {
        context
            .read<AuthBloc>()
            .add(UserTypeSelectionEvent(selectPatient: isPatient));
      },
      child: BlocBuilder<AuthBloc, AuthStatee>(
        builder: (context, state) {
          if (state is UserTypeSelectionUpdateState) {
            stateVal = state.selectPatient;
          }
          return Container(
              width: context.getHeight(divide: 5),
              height: context.getHeight(divide: 5),
              decoration: BoxDecoration(
                boxShadow: kElevationToShadow[4],
                border: Border.all(
                  color: (stateVal != null && isPatient && stateVal!) ||
                          (stateVal != null &&
                              isPatient == false &&
                              stateVal! == false)
                      ? blue
                      : const Color.fromARGB(255, 201, 200, 200),
                  width: 5,
                ),
              ),
              child: Image.asset(
                  isPatient
                      ? 'assets/images/user_avatar.png'
                      : 'assets/images/red_cerecent.png',
                  width: 250,
                  height: 250));
        },
      ),
    );
  }
}
