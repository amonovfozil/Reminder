import 'package:fpdart/fpdart.dart';

// ignore: avoid_types_as_parameter_names
abstract interface class UseCase<Type, Parms> {
  Future<Either> call(Parms params);
}

class Parms {}

class StringParms {
  final String val;
  StringParms({required this.val});
}
