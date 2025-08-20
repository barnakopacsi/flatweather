//
//  ContentView.swift
//  FlatWeather
//
//  Created by Barna Kopácsi on 2025. 07. 05..
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) private var colorScheme

    @State private var viewModel: ContentViewModel
    
    init(container: DIContainer = .shared) {
        _viewModel = State(wrappedValue: container.makeContentViewModel())
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                switch viewModel.connectionStatus {
                case .connected:
                    if viewModel.existingResponses.isEmpty {
                        LoadingView()
                    } else {
                            WeatherTabView(
                                selection: $viewModel.selectedLocationID,
                                responses: viewModel.existingResponses,
                                measurementSetting: viewModel.measurementSetting,
                                tempSetting: viewModel.temperatureSetting
                            )
                    }
                    
                case .disconnected:
                    if viewModel.existingResponses.isEmpty {
                        NoInternetView()
                    } else {
                        WeatherTabView(
                            selection: $viewModel.selectedLocationID,
                            responses: viewModel.existingResponses,
                            measurementSetting: viewModel.measurementSetting,
                            tempSetting: viewModel.temperatureSetting
                        )
                    }
                    
                case .undetermined:
                    LoadingView()
                }
                
                TabPageIndicator(
                    numberOfLocations: viewModel.existingResponses.count,
                    selectedLocationIndex: viewModel.selectedLocationIndex,
                    userLocationIndex: viewModel.existingResponses.firstIndex { $0.isUserLocation }
                )
            }
            .alert("Are you sure you want to delete this location?", isPresented: $viewModel.showingDeleteAlert) {
                Button("Delete", role: .destructive) {
                        viewModel.removeLocation(at: viewModel.selectedLocationIndex)
                }
                
                Button("Cancel", role: .cancel) {
                    viewModel.showingDeleteAlert = false
                }
            }
            .alert("Error", isPresented: $viewModel.showingErrorAlert) {
                Button("Retry") {
                    Task {
                        await viewModel.refreshWeatherData()
                    }
                }
            } message: {
                Text(viewModel.errorMessage ?? "An unknown error occured. Please try again.")
            }
            .navigationDestination(isPresented: $viewModel.showingSearchView) {
                SearchView()
            }
            .onChange(of: viewModel.savedLocations) {
               Task {
                  await viewModel.refreshWeatherData()
              }
            }
            .task {
                viewModel.checkInternetConnection()
                
                await viewModel.refreshWeatherData()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    AddLocationButton {
                        viewModel.showingSearchView = true
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        DeleteLocationButton {
                            viewModel.showingDeleteAlert = true
                        }
                        .disabled(viewModel.existingResponses.count <= 1 || viewModel.existingResponses[viewModel.selectedLocationIndex].isUserLocation)
                        
                        Section("Appearance Setting") {
                            AppearanceSettingButtons(appearanceSetting: viewModel.appearanceSetting) {
                                viewModel.appearanceSetting = $0
                            }
                        }
                        
                        Section("Temperature Unit Setting") {
                            TemperatureSettingButtons(temperatureSetting: viewModel.temperatureSetting) {
                                viewModel.temperatureSetting = $0
                            }
                        }
                        
                        Section("Measurement Unit Setting") {
                            MeasurementSettingButtons(measurementSetting: viewModel.measurementSetting) {
                                viewModel.measurementSetting = $0
                            }
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                    .foregroundStyle(colorScheme == .light ? .black : .white)
                    .fontWeight(.medium)
                }
            }
        }
        .preferredColorScheme(viewModel.appearanceSetting.colorScheme)
    }
}

#Preview {
    ContentView()
}
