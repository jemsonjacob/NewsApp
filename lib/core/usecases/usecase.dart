//"Every use case must implement a call() method, take some parameters (Params), and return a result (Type)."
//this will act as a common usecase structure for every features usecases

// ignore: avoid_types_as_parameter_names
abstract class Usecase<Type, Params> {
  //generic types
  Future<Type> call({
    required Params params,
  }); //Every use case has a call() method.

  //It takes some Params.It returns a Future<Type>
}
