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
                await fetchCopyright(client: client)
                await fetchScheduleBetweenStations(client: client)
                await fetchStationSchedule(client: client)
                await fetchRouteStations(client: client)
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
    
    private func fetchCopyright(client: Client) async {
        let copyrightService = CopyrightService(client: client)
        
        do {
            let copyright = try await copyrightService.getCopyright()
            
            logger.info("Copyright: \(copyright)")
        } catch {
            logger.error("[ContentView.fetchCopyright] Failed to get copyright info. Error - \(error)")
        }
    }
    
    private func fetchScheduleBetweenStations(client: Client) async {
        let scheduleBetweenStationsService = ScheduleBetweenStationsService(client: client)
        
        do {
            let scheduleBetweenStations = try await scheduleBetweenStationsService.getScheduleBetweenStations(
                from: "s9612913",
                to: "s9613073",
            )
            
            logger.info("Schedule between stations: \(scheduleBetweenStations)")
        } catch {
            logger.error("[ContentView.fetchScheduleBetweenStations] Failed to get schedule between stations. Error - \(error)")
        }
    }
    
    private func fetchStationSchedule(client: Client) async {
        let stationSheduleService = StationScheduleService(client: client)
        
        do {
            let shedule = try await stationSheduleService.getSchedule(for: "s9612913")
            
            logger.info("Station schedule: \(shedule)")
        } catch {
            logger.error("[ContentView.fetchStationSchedule] Failed to get station schedule. Error - \(error)")
        }
    }
    
    private func fetchRouteStations(client: Client) async {
        let routeStationsService = RouteStationsService(client: client)
        
        do {
            let routeStations = try await routeStationsService.getRouteStations(for: "251A_0_2")
            
            logger.info("Route stations: \(routeStations)")
        } catch {
            logger.error("[ContentView.fetchRouteStations] Failed to get route stations. Error - \(error)")
        }
    }
}

#Preview {
    ContentView()
}
