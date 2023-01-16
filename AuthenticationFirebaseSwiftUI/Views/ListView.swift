import SwiftUI

struct ListView: View {
    @ObservedObject var viewModel = ListViewModel()
    
    @State var inputText = ""
    @State var seletedCuisine = Food.all
    @State var alpinism = false
    @State var rafting = false
    @State var ski = false
    @State var beach = false
    @State var wellness = false
    @State var sightseeing = false
    @State var gastronomic = false
    
    var body: some View {
        VStack {
            AppBarView(inputText: $inputText, seletedCuisine: $seletedCuisine, alpinism: $alpinism, rafting : $rafting, ski : $ski, beach : $beach, wellness : $wellness, sightseeing : $sightseeing, gastronomic : $gastronomic)
                .environmentObject(viewModel)
                .padding(.bottom, 5)
                .overlay(Divider()
                            .frame(width: UIScreen.main.bounds.width)
                            .background(Color.black), alignment: .bottom)
                .padding(.bottom, 5)
                
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(viewModel.stores.filter({ store in
                        filterSearchText(store)
                    }).filter({ store in
                        filterCuisine(store)
                    }).filter({ store in
                        filteralpinism(store)
                    }).filter({ store in
                        filterrafting(store)
                    }).filter({ store in
                        filterski(store)
                    }).filter({ store in
                        filterbeach(store)
                    }).filter({ store in
                        filterwellness(store)
                    }).filter({ store in
                        filtersightseeing(store)
                    }).filter({ store in
                        filtergastronomic(store)
                    }), id: \.self) { store in
                        StoreView(store: store)
                    }
                }
            }
        }
    }
    
    private func filterSearchText(_ store: Store) -> Bool {
        if inputText == "" || store.name.localizedCaseInsensitiveContains(inputText) {
            return true
        } else {
            return false
        }
    }
    
    private func filterCuisine(_ store: Store) -> Bool {
        if seletedCuisine == .all || seletedCuisine == store.type
        {
            return true
        } else {
            return false
        }
    }
    
    private func filteralpinism(_ store: Store) -> Bool {
        if !alpinism || store.tags.firstIndex(of: "Альпинизм") != nil {
            return true
        } else {
            return false
        }
    }
    
    private func filterrafting(_ store: Store) -> Bool {
        if !rafting || store.tags.firstIndex(of: "Рафтинг") != nil {
            return true
        } else {
            return false
        }
    }
    private func filterski(_ store: Store) -> Bool {
        if !ski || store.tags.firstIndex(of: "Горнолыжный") != nil {
            return true
        } else {
            return false
        }
    }
    private func filterbeach(_ store: Store) -> Bool {
        if !beach || store.tags.firstIndex(of: "Пляжный") != nil {
            return true
        } else {
            return false
        }
    }
    private func filterwellness(_ store: Store) -> Bool {
        if !wellness || store.tags.firstIndex(of: "Оздоровительный") != nil {
            return true
        } else {
            return false
        }
    }
    private func filtersightseeing(_ store: Store) -> Bool {
        if !sightseeing || store.tags.firstIndex(of: "Экскурсионный") != nil {
            return true
        } else {
            return false
        }
    }
    private func filtergastronomic(_ store: Store) -> Bool {
        if !gastronomic || store.tags.firstIndex(of: "Гастрономический") != nil {
            return true
        } else {
            return false
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
