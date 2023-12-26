//
//  ContentView.swift
//  CodesSubmissionApplication
//
//  Created by Дмитрий Цуприков on 02.12.2023.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    var onClear: () -> Void // Замыкание для очистки текста поиска
    var searchAction: (String) -> ()

    var body: some View {
        HStack {
            TextField("Поиск", text: $searchText, onCommit: {
                searchAction(searchText)
            })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
//                .foregroundColor(.white)
            
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                    /**/
                    onClear() // Вызываем замыкание при нажатии кнопки "X" для очистки текста
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                .padding(.trailing)
            }
        }
    }
}

struct LanguageList: View {

    @StateObject private var viewModel = MainViewModel()
    @State private var searchBarText = ""
    private var filteredLanguages: [LanguageModel] {
        viewModel.searchTitles(searchText: searchBarText, fetchData: fetchData, fetchSearch: fetchSearch)
    }

    var body: some View {
        /// Навигация нашего приложения, чтобы мы могли вернуться к экрану
        NavigationStack {
            SearchBar(searchText: $searchBarText, onClear: fetchData, searchAction: fetchSearch)
            /// Скролл вью, чтобы могли скролить
            ScrollView(showsIndicators: false) {
                /// То же самое, что и VStack, но он ленивый. Т.е переиспользует ячейки. Используеют, когда данных много.
                LazyVStack {
                    /// Тут перебираем наши треки. Т.к SongModel подписан на `Identifiable` мы можем по нему итерироваться.
                    ForEach(filteredLanguages) { language in
                        /// Это место, куда мы будем переходить при нажатии
                        NavigationLink {
                            /// Экран, который откроем при нажатии
                            LanguageDetails(LanguageId: language.languageId)
                        } label: {
                            /// наша ячейка
                            CodeCell(language: language)
                        }
                        .padding(.bottom)
                    }
                    .padding(.horizontal, 15)
                }
            }
            /// Фон
            .background(LinearGradient.appBackground)
            /// Наш сёрч бар выше
            /// Наш заголовок
            .navigationBarTitle("Языки программирования")
        }
        /// Не теряем!
        .environmentObject(viewModel)
        /// Задаём тему всегда тёмную
        .colorScheme(.dark)
        /// Перед появлением экрана будем выполнять функцию fetchData
        .onAppear(perform: fetchData)
    }
}

// MARK: - Network

private extension LanguageList {

    func fetchData() {
            viewModel.getLanguages { error in
                        if let error {
                            print(error.localizedDescription)
                            viewModel.languages = .mockData
                        }
                    }
        }
        
        func fetchSearch(searchText: String) {
            viewModel.getSearch(searchStr: searchText) { error in
                if let error {
                    print(error.localizedDescription)
                    viewModel.language = .mockData
                }
            }
        }
}

// MARK: - Preview

#Preview {
    LanguageList()
    /// Не теряем!
        .environmentObject(MainViewModel())
}
