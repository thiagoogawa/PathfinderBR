//
//  FinderMap.swift
//  PathfinderBR
//
//  Created by Thiago Ogawa on 29/06/25.
//

import SwiftUI
import MapKit

struct FinderMap: View {
    let finder = Finder()
    
    @State var position: MapCameraPosition
    @State var satellite = false
    
    var body: some View {
        Map(position: $position) {
            ForEach(finder.pathFinder) {finder in
                Annotation(finder.name, coordinate: finder.location) {
                    Image(finder.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .shadow(color: .white, radius: 3)
                }
            }
        }
        .mapStyle(satellite ? .imagery(elevation: .realistic): .standard(elevation: .realistic))
        .overlay(alignment: .bottomTrailing) {
            Button {
                satellite.toggle()
            } label: {
                Image(systemName: satellite ? "globe.americas.fill" : "globe.americas")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .padding(3)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 7))
                    .shadow(radius: 3)
                    .padding()
            }
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    FinderMap(position: .camera(MapCamera(
        centerCoordinate: Finder().pathFinder[5].location,
        distance: 1000,
        heading: 250,
        pitch: 80))
    )
    .preferredColorScheme(.dark)
}
