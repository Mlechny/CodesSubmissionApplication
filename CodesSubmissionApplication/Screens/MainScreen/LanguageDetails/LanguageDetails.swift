//
//  LanguageDetails.swift
//  CodesSubmissionApplication
//
//  Created by Дмитрий Цуприков on 02.12.2023.
//

import SwiftUI

struct LanguageDetails: View {
    @EnvironmentObject var viewModel: MainViewModel
    var LanguageId: String?

    var body: some View {
        GeometryReader {
            let size = $0.size
            ScrollView {
                VStack {
                    ImageView(size)

                    LanguageTextInfo
                        .padding()
                }
            }
        }
        .padding(.horizontal)
        .environmentObject(viewModel)
        .navigationBarTitle("", displayMode: .inline)
        .colorScheme(.dark)
        .background(LinearGradient.appBackgroundDetails)
        .onAppear(perform: fetchDetails)
    }
}

// MARK: - LanguageDetails

private extension LanguageDetails {
    
    /// Вьюха картинки
    /// - Parameter size: размер фото
    /// - Returns: кастомную фотку
    func ImageView(_ size: CGSize) -> some View {
        AsyncImage(url: viewModel.language.imageURL) { img in
            img
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.width)
                .clipShape(RoundedRectangle(cornerRadius: 20))

        } placeholder: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.shimmerColor)
                ProgressView()
            }
            .frame(width: size.width, height: size.width)
        }
    }
    
    /// Наше тело со всей текстой информацией
    var LanguageTextInfo: some View {
        VStack {
            if let task = viewModel.language.task {
                Text(task)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom)
                    .foregroundStyle(Color.appForeground)
            }

            Text(viewModel.language.name ?? "Название не указано")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundStyle(Color.appForeground)

            Text(viewModel.language.subject ?? "Предмет не задан")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundStyle(Color.appForeground.opacity(0.7))
                .foregroundStyle(.secondary)

            VStack {
                Text("Описание задания:")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.appForeground)
                Spacer()
                if let description = viewModel.language.description {
                    Text(description)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.appForeground)
                        .opacity(0.7)
                        .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    Text("Выложено на гитхабе")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.appForeground)
                        .opacity(0.7)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(.top, 20)
        }
    }
}

// MARK: - Network

private extension LanguageDetails {

    func fetchDetails() {
        viewModel.getDetails(LanguageId: LanguageId ?? "") { error in
            if let error {
                print(error.localizedDescription)
                viewModel.languages = .mockData
            }
        }
        
    }
}


