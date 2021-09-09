//import 'package:newsapp/repositories/post/post_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technoshop/blocs/offre_bloc.dart';
import 'package:technoshop/models/category.dart';
import 'package:technoshop/models/offre.dart';
import 'package:technoshop/models/product.dart';

import 'package:technoshop/repository/categories_api.dart';

class CategoryBloc extends Bloc<CategoryEvents, CategoryStates> {
  @override
  CategoryStates get initialState => CatLoadingState1();

  CategoriesAPI repo;
  //AuthorsAPI aurepo ;
  CategoryBloc(CategoryStates initialState, this.repo) : super(initialState);
  @override
  Stream<CategoryStates> mapEventToState(CategoryEvents event) async* {
    if (event is CatDoFetchEvent1) {
      yield CatLoadingState1();
      //authbloc.add(DoFetchEvent());

      var categories = await repo.fetchCategories();
      // var authors= await aurepo.fetchAllAuthors();
      //yield authbloc.mapEventToState(DoFetchEvent);
      yield CatFetchSuccess1(categories: categories);
    } else if (event is CatDoFetchOffresEvent1) {
      yield CatLoadingState1();
      //authbloc.add(DoFetchEvent());
      try {
        Category category;
        print("here's the data : ${event.category}");

        CatDoFetchOffresEvent1(category: category);

        // print(category);
        var offres = await repo.fetchPostsCategory(event.category);
        print(OffreStates());
        // var authors= await aurepo.fetchAllAuthors();
        //yield authbloc.mapEventToState(DoFetchEvent);
        yield CatOffresFetchSuccess1(offres: offres);
      } catch (e) {
        yield CatErrorState1(message: e.toString());
      }
    }
  }
}

// events
class CategoryEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class CatDoFetchEvent1 extends CategoryEvents {}

class CatDoFetchOffresEvent1 extends CategoryEvents {
  Category category;

  CatDoFetchOffresEvent1({this.category});
}

// states
class CategoryStates extends Equatable {
  @override
  List<Object> get props => [];
}

class CatInitialState1 extends CategoryStates {}

class CatProductsInitialState1 extends CategoryStates {}

class CatLoadingState1 extends CategoryStates {}

class CatProductsLoadingState1 extends CategoryStates {}

class CatFetchSuccess1 extends CategoryStates {
  List<Category> categories;
  //List<Category> authors;

  CatFetchSuccess1({this.categories});
}

class CatOffresFetchSuccess1 extends CategoryStates {
  List<Offre> offres;
  //List<Category> authors;

  CatOffresFetchSuccess1({this.offres});
}

class CatErrorState1 extends CategoryStates {
  String message;
  CatErrorState1({this.message});
}
