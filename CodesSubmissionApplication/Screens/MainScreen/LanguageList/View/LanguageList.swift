//
//  ContentView.swift
//  CodesSubmissionApplication
//
//  Created by Дмитрий Цуприков on 02.12.2023.
//

import SwiftUI

struct LanguageList: View {

    @StateObject private var viewModel = MainViewModel()
    @State private var searchBarText = ""
    private var filteredLanguages: [LanguageModel] {
        viewModel.searchLanguages(searchText: searchBarText)
    }

    var body: some View {
        /// Навигация нашего приложения, чтобы мы могли вернуться к экрану
        NavigationStack {
            /// Скролл вью, чтобы могли скролить
            ScrollView(showsIndicators: false) {
                /// То же самое, что и VStack, но он ленивый. Т.е переиспользует ячейки. Используеют, когда данных много.
                LazyVStack {
                    /// Тут перебираем наши треки. Т.к SongModel подписан на `Identifiable` мы можем по нему итерироваться.
                    ForEach(filteredLanguages) { language in
                        /// Это место, куда мы будем переходить при нажатии
                        NavigationLink {
                            /// Экран, который откроем при нажатии
                            LanguageDetails(language: language)
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
            .searchable(text: $searchBarText, prompt: "Поиск")
            /// Наш заголовок
            .navigationBarTitle("Языки программирования")
            .navigationBarTitleDisplayMode(.inline)
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
                //print(error.localizedDescription)
                viewModel.languages = .mockData
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
