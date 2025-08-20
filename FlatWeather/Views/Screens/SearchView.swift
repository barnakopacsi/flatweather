//
//  SearchView.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 07. 10..
//

import SwiftUI

struct SearchView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    
    @FocusState private var isTextFieldFocused: Bool
    
    @State private var viewModel: SearchViewModel
    
    init(container: DIContainer = .shared) {
        _viewModel = State(wrappedValue: container.makeSearchViewModel())
    }
    
    var body: some View {
        VStack {
            TextField("Search for a location...", text: $viewModel.query)
                .focused($isTextFieldFocused)
                .font(.headline)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(.primary, lineWidth: 1)
                        .opacity(0.5)
                )
                .padding()
            
            switch viewModel.connectionStatus {
            case .connected:
                Group {
                    if viewModel.isSearching {
                        ProgressView()
                            .padding()
                    }
                    else if viewModel.query.isEmpty {
                        ContentUnavailableView("Start typing to search", systemImage: "magnifyingglass")
                    }
                    else if viewModel.results.isEmpty {
                        ContentUnavailableView("No results found", systemImage: "magnifyingglass")
                    }
                    else {
                        ScrollView {
                            VStack(spacing: 15) {
                                ForEach(viewModel.results) { result in
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text("\(result.name), \(result.region), \(result.country)")
                                                .lineLimit(1)
                                            
                                            Spacer()
                                            
                                            Button {
                                                viewModel.addLocation(result)
                                            } label: {
                                                if viewModel.savedLocations.contains(where: { $0.id == result.id }) {
                                                    Image(systemName: "checkmark.circle.fill")
                                                        .foregroundStyle(.green)
                                                        .transition(.scale)
                                                } else {
                                                    Image(systemName: "plus.circle")
                                                        .foregroundStyle(colorScheme == .light ? .black : .white)
                                                        .transition(.scale)
                                                }
                                            }
                                            .animation(.easeInOut, value: viewModel.savedLocations)
                                            .sensoryFeedback(.success, trigger: viewModel.savedLocations)
                                        }
                                        
                                        Divider()
                                    }
                                    .font(.headline)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                
                Spacer()
                
            case .disconnected:
                ContentUnavailableView {
                    Label("No internet connection", systemImage: "wifi.slash")
                } description: {
                    Text("Search will be available automatically when the iPhone is connected to the internet.")
                }
                
            case .undetermined:
                ContentUnavailableView {
                    ProgressView()
                }
            }
        }
        .alert("Error", isPresented: $viewModel.showingErrorAlert) {
            Button("OK") {
                viewModel.showingErrorAlert = false
            }
        } message: {
            Text(viewModel.errorMessage ?? "An unknown error occured. Please try again.")
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Add location")
        .task {
            viewModel.checkInternetConnection()
        }
        .onAppear {
            isTextFieldFocused = true
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(colorScheme == .light ? .black : .white)
                        .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
