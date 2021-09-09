//import 'package:newsapp/repositories/post/post_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technoshop/models/offre.dart';
import 'package:technoshop/repository/offres_api.dart';

class SearchBloc extends Bloc<SearchEvents, SearchStates> {
  @override
  SearchStates get initialState => SearchLoadingState1();

  OffresAPI repo;
  //AuthorsAPI aurepo ;
  SearchBloc(SearchStates initialState, this.repo) : super(initialState);
  @override
  Stream<SearchStates> mapEventToState(SearchEvents event) async* {
    if (event is FindEvent) {
      yield SearchLoadingState1();
      try {
        var offres = await repo.searchOffres(event.key);
        // var authors= await aurepo.fetchAllAuthors();
        //yield authbloc.mapEventToState(DoFetchEvent);
        yield FindState(offres: offres);
        print(offres);
      } catch (e) {
        yield SearchErrorState1(message: e.toString());
      }
    }
  }
}

//events
class SearchEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class FindEvent extends SearchEvents {
  String key;
  FindEvent({this.key});
}

// states
class SearchStates extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchInitialState1 extends SearchStates {}

class SearchLoadingState1 extends SearchStates {}

class SearchErrorState1 extends SearchStates {
  String message;
  SearchErrorState1({this.message});
}

class FindState extends SearchStates {
  List<Offre> offres;
  FindState({this.offres});
}
