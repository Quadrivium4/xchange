import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xchange/controllers/auth.dart';
import 'package:xchange/controllers/universities.dart';
import 'package:xchange/providers/auth.dart';


class OnboardingViewModel extends ChangeNotifier {
    final TextEditingController nameCtrl = TextEditingController();
    final TextEditingController ageCtrl = TextEditingController();
    final TextEditingController nationalityCtrl = TextEditingController();

    final TextEditingController uniCtrl = TextEditingController();
    final TextEditingController destinationCtrl = TextEditingController();

    List<UniversityModel> homeUniversities = [];
    List<UniversityModel> destinationUniversities = [];
    final UniversitiesController universitiesController = UniversitiesController();
    initState() {
        print("hellow init state onboarding view model");
        destinationCtrl.addListener(() {
          print("destination ctrl changed: ${destinationCtrl.text}");
            final country = destinationCtrl.text;
            if (country.isNotEmpty) {
                getDestinationUniversities(country);
            }
        });
        nationalityCtrl.addListener(() {
            print("nationality ctrl changed: ${nationalityCtrl.text}");
            final country = nationalityCtrl.text;
            if (country.isNotEmpty) {
                getHomeUniversities(country);
            }
        },);
    }
    Future<void> getHomeUniversities(String country) async {
        try {
            print("Searching universities for country: $country");
            final results = await universitiesController.searchUniversity(country);
          
            homeUniversities = results;
            notifyListeners();
        } catch (err) {
            print("Error searching universities: $err");
        }
    }
    Future<void> getDestinationUniversities(String country) async {
        try {
            print("Searching universities for country: $country");
            final results = await universitiesController.searchUniversity(country);
          
            destinationUniversities = results;
            notifyListeners();
        } catch (err) {
            print("Error searching universities: $err");
        }
    }

    OnboardingViewModel() {
        initState();
    }


}
