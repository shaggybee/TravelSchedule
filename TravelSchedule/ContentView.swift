//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Kislov Vadim on 01.07.2026.
//

import SwiftUI
import OpenAPIRuntime
import OpenAPIURLSession

struct ContentView: View {
    // MARK: - Public properties
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            testServices()
        }
    }
    
    // MARK: - Private properties
    private var logger = AppLogger.shared
    
    // MARK: - Private Methods
    private func testServices() {
        Task {
            do {
                let serverUrl = try Servers.Server1.url()
                
                let client = Client(
                    serverURL: serverUrl,
                    transport: URLSessionTransport(),
                    middlewares: [AuthenticationMiddleware(apiKey: NetworkingConstants.apiKey)])
                
                await fetchNearestStations(client: client)
            }
            catch {
                logger.error("[ContentView.testServices] Failed to get server URL. Error - \(error)")
            }
        }
    }
    
    private func fetchNearestStations(client: Client) async {
        let nearestStationsService = NearestStationsService(client: client)
        
        do {
            let stations = try await nearestStationsService.getNearestStations(
                lat: 55.442400,
                lng: 37.363600,
                distance: 50
            )
            
            logger.info("List of nearest stations: \(stations)")
        } catch {
            logger.error("[ContentView.fetchNearestStations] Failed to get list of nearest stations. Error - \(error)")
        }
    }
}

#Preview {
    ContentView()
}
