//
//  MapView.swift
//  LHPPWallet
//
//  Created by sopheakneath on 9/3/26.
//

import SwiftUI
import MapKit
import CoreData

struct IdentifiableLocation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    
    
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 11.5564,
            longitude: 104.9282
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.05,
            longitudeDelta: 0.05
        )
    )
    
    let location = IdentifiableLocation(
        coordinate: CLLocationCoordinate2D(
            latitude: 11.5564,
            longitude: 104.9282
        )
    )
    
    var body: some View {
        Map(
            coordinateRegion: $region,
            annotationItems: [location]
        ) { item in
            MapMarker(coordinate: item.coordinate)
            
        }
    }
}

#Preview {
    MapView()
}
