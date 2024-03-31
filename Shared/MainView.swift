//
//  MainView.swift
//  ChatGPTApp
//
//  Created by Nate Schaffner on 3/26/24.
//

import SwiftUI
import OpenAISwift

struct MainView: View {
    
    @State private var chatText: String = ""
    @State private var maxTokensAllowed: Int = 200
    
    let openai = OpenAISwift(config: OpenAISwift.Config.makeDefaultOpenAI(apiKey: "INSERT_YOUR_OPENAI_API_KEY_HERE"))
    
    @State private var isSearching: Bool = false
    
    //@State private var answers: [String] = []
    
    @EnvironmentObject private var model: Model
    
    private var isFormValid: Bool {
        !chatText.isEmptyOrWhiteSpace
    }
    
    private func performSearch() async {
        do {
            let results = try await openai.sendChat(with: [ChatMessage(role: .user, content: chatText)], model: .gpt4, maxTokens: maxTokensAllowed)
            isSearching = false
            let answer = results.choices?.first?.message.content ?? "error"
            print("answer: \(answer)")
            let query = Query(question: chatText, answer: answer)
            DispatchQueue.main.async {
                model.queries.append(query)
            }
            do {
                try model.saveQuery(query)
            } catch {
                print(error.localizedDescription)
            }
            //answers.append(answer)
            //with: [ChatMessage(role: .user, content: chatText)], model: .gpt4, maxTokens: 200
        } catch {
            print(error)
            isSearching = false
        }
        
    }



//        openai.sendCompletion(with: chatText, maxTokens: 500, completionHandler: {
//            result in
//            switch result {
//            case .success(let success):
//                let answer = success.choices?.first?.text.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
//                print(answer)
//                answers.append(answer)
//            case .failure(let failure):
//                print(failure)
//            }
//        })
    //}
    
    var body: some View {
        VStack {
            ScrollView {
                ScrollViewReader { proxy in
                    ForEach(model.queries, id: \.self) { query in
                        VStack (alignment: .leading){
                            Text(query.question).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            Text(query.answer)
                        }.frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.bottom], 10)
                            .id(query.id)
                            .listRowSeparator(.hidden)
                    }.listStyle(.plain)
                        .onChange(of: model.queries) { query in
                            if !model.queries.isEmpty{
                                let lastQuery = model.queries[model.queries.endIndex - 1]
                                withAnimation {
                                    proxy.scrollTo(lastQuery.id)
                                }
                            }
                        }
                }
            }.padding()
            Spacer()
            HStack{
                Text("Max Tokens (default 200):")
                TextField("Max Tokens...", value: $maxTokensAllowed, format: .number)
            }
            HStack {
                TextField("Search...", text: $chatText).textFieldStyle(.roundedBorder)
                Button{
                    Task {
                        isSearching = true
                        await performSearch()
                    }
                } label: {
                    Image(systemName: "paperplane.circle.fill").font(.title).rotationEffect(Angle(degrees: 45))
                }.buttonStyle(.borderless).tint(.blue).disabled(!isFormValid)
            }
        }.padding()
            .onChange(of: model.query) { query in
                model.queries.append(query)
            }
            .overlay(alignment: .center) {
                if isSearching {
                    ProgressView("Searching")
                }
            }
    }
}

#Preview {
    MainView()
        .environmentObject(Model())
}
