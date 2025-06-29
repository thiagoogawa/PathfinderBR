//
//  Finder.swift
//  PathfinderBR
//
//  Created by Thiago Ogawa on 24/06/25.
//

import Foundation

class Finder {
    var allPathfinders: [Pathfinder] = []
    var pathFinder: [Pathfinder] = []
    
    init() {
        decodePathFinderData()
    }
    
    func decodePathFinderData() {
        if let url = Bundle.main.url(forResource: "pathfinderbr", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allPathfinders = try decoder.decode([Pathfinder].self, from: data)
                pathFinder = allPathfinders
            } catch {
                print("Error decoding JSON data: \(error)")
            }
        }
    }
    
    func search(for searchTerm: String) -> [Pathfinder] {
        if searchTerm.isEmpty {
            return pathFinder
        } else {
            return pathFinder.filter {
                finde in
                finde.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    func sort(by alphabetical: Bool) {
        pathFinder.sort {finder1, finder2 in
            if alphabetical {
                finder1.name < finder2.name
            } else {
                finder1.id < finder2.id
            }
        }
    }
    
    func filter(by type: pathFinderType) {
        if type == .all {
            pathFinder = allPathfinders
        } else {
            pathFinder = allPathfinders.filter {finde in
                finde.type == type
            }
        }
    }
}
