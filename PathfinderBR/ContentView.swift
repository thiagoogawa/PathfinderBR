//
//  ContentView.swift
//  PathfinderBR
//
//  Created by Thiago Ogawa on 24/06/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let finder = Finder()
    
    @State var searchText = ""
    @State var alphabetical = false
    @State var currentSelection = pathFinderType.all
    
    var filteredPlaces: [Pathfinder] {
        finder.filter(by: currentSelection)
        
        finder.sort(by: alphabetical)
        
        return finder.search(for: searchText)
    }
    
    var body: some View {
        NavigationStack {
            List(filteredPlaces) { finde in
                NavigationLink {
                    FinderDetail(finder: finde, position: .camera(
                        MapCamera(
                            centerCoordinate: finde.location,
                            distance: 30000
                        )))
                } label: {
                    HStack {
                        // Image
                        Image(finde.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white, radius: 1)
                        
                        VStack(alignment: .leading) {
                            // Name
                            Text(finde.name)
                                .fontWeight(.bold)
                            
                            // Type
                            Text(finde.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(finde.type.background)
                                .clipShape(.capsule)
                        }
                    }
                }
            }
            .navigationTitle("PathfinderBR")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            alphabetical.toggle()
                        }
                    } label: {
                        Image(systemName: alphabetical ? "map" : "textformat")
                            .symbolEffect(.bounce, value: alphabetical)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $currentSelection.animation()) {
                            ForEach(pathFinderType.allCases) {
                                type in
                                Label(type.rawValue.capitalized,
                                      systemImage: type.icon)
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
