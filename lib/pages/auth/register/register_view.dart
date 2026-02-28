import 'package:flutter/material.dart';
import 'package:xchange/widgets/Buttons/customBackButton.dart';
import 'package:xchange/widgets/Buttons/confirmationButton.dart';
import 'package:xchange/widgets/loginTextBox.dart';
import 'package:xchange/widgets/Structure/spacedColumn.dart';

const double spacing = 20;

class RegisterView extends StatefulWidget{
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController ageCtrl = TextEditingController();
  final TextEditingController nationalityCtrl = TextEditingController();

  final TextEditingController uniCtrl = TextEditingController();
  final TextEditingController destinationCtrl = TextEditingController();

  final ProfileCreationStage creationStage = ProfileCreationStage();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            Row(
              children: [
                Text("Complete your profile"),
                Spacer(),
                ProfileCreationIcons(stage: creationStage.stage),
              ],
            ),

            creationStage.stage == Stage.user ? SpacedColumn(
              mainAxisAlignment: MainAxisAlignment.center,
                spacing: spacing,
                children: [

                  LoginTextBox(
                    title: "Name",
                    controller: nameCtrl,
                    hint: "Your name",
                  ),

                  LoginTextBox(
                    title: "Age",
                    controller: ageCtrl,
                    hint: "e.g. 21",
                  ),

                  LoginTextBox(
                    title: "Nationality",
                    controller: nationalityCtrl,
                    hint: "e.g. Italy, France, Netherlands...",
                  ),
                ],
            ) : creationStage.stage == Stage.education ? SpacedColumn(
              mainAxisAlignment: MainAxisAlignment.center,
                spacing: spacing,
                children: [
                  LoginTextBox(
                    title: "Home university",
                    controller: uniCtrl,
                    hint: "e.g. Sorbonne, Sapienza, TU Delft...",
                  ),

                  LoginTextBox(
                    title: "Where are you going in Erasmus?",
                    controller: destinationCtrl,
                    hint: "E.g. Barcelona, Milano, Berlin...",
                  ),
                ]
            ) : SpacedColumn(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: spacing,
              children: [
                Text("To be filled"),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  creationStage.stage != Stage.user ? CustomBackButton(
                    onPressed: (){setState(() {
                      creationStage.previousStage();
                    });},
                    icon: Icons.arrow_back,
                    text: "Back",
                  ) : SizedBox.shrink(),

                  ConfirmationButton(
                      onPressed: (){setState(() {
                        creationStage.nextStage();
                      });},
                      text: "Next",
                      icon: Icons.arrow_forward,
                  )
                ],
            ),
          ],
        ),
      ),
    );
  }
}




class ProfileCreationIcons extends StatelessWidget {
  final Stage stage;
  const ProfileCreationIcons({super.key, required this.stage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          stage == Stage.user ? Icon(Icons.person_outline_outlined, color: Colors.orange,) : Icon(Icons.check, color: Colors.orange,),
          Icon(Icons.remove, color: stage == Stage.user ? Colors.black : Colors.orange,),
          stage != Stage.interests ? Icon(Icons.school_outlined, color: stage == Stage.education ? Colors.orange : Colors.black) : Icon(Icons.check, color: Colors.orange,),
          Icon(Icons.remove, color: stage == Stage.interests ? Colors.orange : Colors.black),
          Icon(Icons.favorite_outline, color: stage == Stage.interests ? Colors.orange : Colors.black,),
        ],
      ),
    );
  }
}

class ProfileCreationStage {
  Stage stage = Stage.user;

  void nextStage (){
    if(stage == Stage.user){
      stage = Stage.education;
    } else if(stage == Stage.education){
      stage = Stage.interests;
    } else { return;}
  }

  void previousStage (){
    if(stage == Stage.interests){
      stage = Stage.education;
    } else if(stage == Stage.education){
      stage = Stage.user;
    } else { return;}
  }
}

enum Stage {
  user,
  education,
  interests,
}