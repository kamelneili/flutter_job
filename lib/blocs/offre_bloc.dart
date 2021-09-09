//import 'package:newsapp/repositories/post/post_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technoshop/blocs/Order_bloc.dart';
import 'package:technoshop/models/offre.dart';

import 'package:technoshop/repository/offres_api.dart';
import 'package:technoshop/repository/products_api.dart';

class OffreBloc extends Bloc<OffreEvents, OffreStates> {
  @override
  OffreStates get initialState => OffreInitialState();

  OffresAPI repo;
  //AuthorsAPI aurepo ;
  OffreBloc(OffreStates initialState, this.repo) : super(initialState);
  @override
  Stream<OffreStates> mapEventToState(OffreEvents event) async* {

    if (event is DoFetchOffresEvent1) {
              

      yield LoadingOffresState1();
      //authbloc.add(DoFetchEvent());
      try {
        var offres = await repo.fetchOffres();
        // var authors= await aurepo.fetchAllAuthors();
        //yield authbloc.mapEventToState(DoFetchEvent);
        yield FetchOffresSuccess1(offres: offres);
      } catch (e) {
        yield ErrorOffresState1(message: e.toString());
      }
    }
     if (event is StartEvent) {
      yield OffreInitialState();
    }
    else if (event is AddOffreEvent)
    {
yield LoadingOffresState1();
      try {
         await repo.addOffre(event.title, event.content,event.category);
        yield AddSuccess();
      } catch (e) {
        yield ErrorOffresState1(message: e.toString());
      }
    }
  }
}
// events
class OffreEvents extends Equatable {
  @override
  List<Object> get props => [];
}
class AddOffreEvent extends OffreEvents {
  String title ;
  String content;
  String category;
  AddOffreEvent({this.title, this.content,this.category});
}
class DoFetchOffresEvent1 extends OffreEvents {}
class StartEvent extends OffreEvents {}



// states
class OffreStates extends Equatable {
  @override
  List<Object> get props => [];
}
class OffreInitialState extends OffreStates {}

class LoadingOffresState1 extends OffreStates {}
class AddSuccess extends OffreStates {}

class FetchOffresSuccess1 extends OffreStates {
  List<Offre> offres;

  FetchOffresSuccess1({this.offres});
}

class ErrorOffresState1 extends OffreStates {
  String message;
  ErrorOffresState1({this.message});
}


