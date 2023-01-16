import SwiftUI

struct AppBarView: View {
    @EnvironmentObject var viewModel: ListViewModel
    @State var showSearchBar = false
    @Binding var inputText: String
    @Binding var seletedCuisine: Food
    @Binding var alpinism: Bool
    @Binding var rafting: Bool
    @Binding var ski: Bool
    @Binding var beach: Bool
    @Binding var wellness: Bool
    @Binding var sightseeing: Bool
    @Binding var gastronomic: Bool
    
    
    var SearchBarView: some View {
        VStack {
            TextField("Поиск...", text: $inputText)
                .padding(5)
                .font(.system(size: 15))
                .textFieldStyle(.roundedBorder)
                .shadow(radius: 3)
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "arrow.left.square")
                Spacer()
                //arrow.left.square
                //ellipsis
                //
                //
                //
                if showSearchBar {
                    SearchBarView
                        .transition(.move(edge: .top))
                } else {
                    Text("Список Туров")
                        .bold()
                }
                 
                Spacer()
                Image(systemName: "magnifyingglass")
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            showSearchBar.toggle()
                            inputText = ""
                        }
                    }
            }
            .font(.system(size: 25))
            .frame(height: 50)

            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    Text(viewModel.nameSort.rawValue)
                        .encapulate(borderColor: .gray)
                        .onTapGesture {
                            if (viewModel.nameSort == .nameASC){
                                viewModel.nameSort = .nameDESC
                            } else {
                                viewModel.nameSort = .nameASC
                            }
                            viewModel.sortList(by: viewModel.nameSort)
                        }
                    Text(viewModel.ratingSort.rawValue)
                        .encapulate(borderColor: .gray)
                        .onTapGesture {
                            if (viewModel.ratingSort == .ratingASC){
                                viewModel.ratingSort = .ratingDESC
                            } else {
                                viewModel.ratingSort = .ratingASC
                            }
                            viewModel.sortList(by: viewModel.ratingSort)
                        }
                    
                    Picker(seletedCuisine.rawValue,
                           selection: $seletedCuisine) {
                        ForEach(Food.allCases, id: \.self) { value in
                            Text(value.rawValue)
                                .tag(value)
                        }
                    }
                    .colorMultiply(.black)
                    .pickerStyle(.menu)
                    .padding(.vertical, -5)
                    .encapulate(borderColor: .gray)
                    
                    if alpinism {
                        Text("Альпинизм")
                            .encapulate(color: .blue.opacity(0.8), foregroundColor: .white)
                            .onTapGesture {
                                alpinism.toggle()
                            }
                    } else {
                        Text("Альпинизм")
                            .encapulate(borderColor: .gray)
                            .onTapGesture {
                                alpinism.toggle()
                            }
                    }
                    
                    if rafting {
                        Text("Рафтинг")
                            .encapulate(color: .blue.opacity(0.8), foregroundColor: .white)
                            .onTapGesture {
                                rafting.toggle()
                            }
                    } else {
                        Text("Рафтинг")
                            .encapulate(borderColor: .gray)
                            .onTapGesture {
                                rafting.toggle()
                            }
                    }
                    if ski {
                        Text("Горнолыжный")
                            .encapulate(color: .blue.opacity(0.8), foregroundColor: .white)
                            .onTapGesture {
                                ski.toggle()
                            }
                    } else {
                        Text("Горнолыжный")
                            .encapulate(borderColor: .gray)
                            .onTapGesture {
                                ski.toggle()
                            }
                    }
                    if beach {
                        Text("Пляжный")
                            .encapulate(color: .blue.opacity(0.8), foregroundColor: .white)
                            .onTapGesture {
                                beach.toggle()
                            }
                    } else {
                        Text("Пляжный")
                            .encapulate(borderColor: .gray)
                            .onTapGesture {
                                beach.toggle()
                            }
                    }
                    if wellness {
                        Text("Оздоровительный")
                            .encapulate(color: .blue.opacity(0.8), foregroundColor: .white)
                            .onTapGesture {
                                wellness.toggle()
                            }
                    } else {
                        Text("Оздоровительный")
                            .encapulate(borderColor: .gray)
                            .onTapGesture {
                                wellness.toggle()
                            }
                    }
                    if sightseeing {
                        Text("Экскурсионный")
                            .encapulate(color: .blue.opacity(0.8), foregroundColor: .white)
                            .onTapGesture {
                                sightseeing.toggle()
                            }
                    } else {
                        Text("Экскурсионный")
                            .encapulate(borderColor: .gray)
                            .onTapGesture {
                                sightseeing.toggle()
                            }
                    }
                    if gastronomic {
                        Text("Гастрономический")
                            .encapulate(color: .blue.opacity(0.8), foregroundColor: .white)
                            .onTapGesture {
                                gastronomic.toggle()
                            }
                    } else {
                        Text("Гастрономический")
                            .encapulate(borderColor: .gray)
                            .onTapGesture {
                                gastronomic.toggle()
                            }
                    }
                }
                .padding(.vertical, 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width-30, height: 100)
    }
}
