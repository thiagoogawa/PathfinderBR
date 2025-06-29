//
//  FinderDetail.swift
//  PathfinderBR
//
//  Created by Thiago Ogawa on 27/06/25.
//

import SwiftUI
import MapKit

struct FinderDetail: View {
    let finder: Pathfinder
    
    @State var position: MapCameraPosition
    @Namespace var namespace
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack(spacing: 0) {
                    Image(finder.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height * 0.35)
                        .clipped()
                        .overlay {
                            LinearGradient(stops:
                                            [Gradient.Stop(color: .clear, location: 0.9),
                                 Gradient.Stop(color: .black, location: 1)
                            ], startPoint: .top, endPoint: .bottom)
                        }
                    
                    VStack(alignment: .leading) {
                        // Name
                        Text(finder.name)
                            .font(.largeTitle)
                        
                        // Current location
                        NavigationLink {
                            FinderMap(position: .camera(MapCamera(
                                centerCoordinate: finder.location,
                                distance: 1000,
                                heading: 250,
                                pitch: 80))
                            )
                            .navigationTransition(.zoom(sourceID: 1, in: namespace))
                        } label: {
                            Map(position: $position) {
                                Annotation(finder.name, coordinate: finder.location) {
                                    Image(systemName: "mappin.and.ellipse")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .symbolEffect(.pulse)
                                }
                                .annotationTitles(.hidden)
                            }
                            .frame(height: 125)
                            .overlay(alignment: .trailing) {
                                Image(systemName: "greaterthan")
                                    .imageScale(.large)
                                    .font(.title3)
                                    .padding(.trailing, 5)
                            }
                            .overlay(alignment: .topLeading) {
                                Text("Current Location")
                                    .padding([.leading, .bottom], 5)
                                    .padding(.trailing, 8)
                                    .background(.black.opacity(0.33))
                                    .clipShape(.rect (bottomTrailingRadius: 15))
                            }
                            .clipShape(.rect(cornerRadius: 15))
                        }
                        .matchedTransitionSource(id: 1, in: namespace)
                        
                        // Appears in
                        Text("Curiosities: ")
                            .font(.title3)
                            .padding(.top)
                        
                        ForEach(finder.topics, id: \.self) { topic in
                            Text("∙" + topic)
                                .font(.subheadline)
                        }
                        
                        // Movie moments
                        Text("About:")
                            .font(.title)
                            .padding(.top, 13)
                        
                        ForEach(finder.description) {scene in
                            
                            Text(scene.sceneDescription)
                                .padding(.bottom, 15)
                        }
                        
                        //Link to webpage
                        Text("Read More: ")
                            .font(.caption)
                        Link(finder.link, destination: URL(string: finder.link)!)
                            .font(.caption)
                            .foregroundStyle(.blue)
                        
                    }
                    .padding()
                    .padding(.bottom)
                    .frame(width: geo.size.width, alignment: .leading)
                }
            }
        }
        .ignoresSafeArea(edges: .top)
        .toolbarBackground(.automatic)
    }
}

#Preview {
    let finder = Finder().pathFinder[5]
    
    NavigationStack {
        
        FinderDetail(finder: finder, position: .camera(
            MapCamera(
                centerCoordinate: finder.location,
                distance: 30000
            )))
        .preferredColorScheme(.dark)
    }
}

