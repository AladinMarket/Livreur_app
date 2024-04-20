import 'package:flutter/material.dart';
import 'package:sixam_mart_delivery/interface/repository_interface.dart';

abstract class LanguageRepositoryInterface extends RepositoryInterface {
  void updateHeader(Locale locale);
  Locale getLocaleFromSharedPref();
  void saveLanguage(Locale locale);
}