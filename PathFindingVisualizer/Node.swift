//
//  Node.swift
//  PathFindingVisualizer
//
//  Created by Tomas Sungaila on 7/26/23.
//

import Foundation
import SwiftUI

class Node: Identifiable, Hashable {
    
    var id = UUID()
    
    let row: Int
    let col: Int
    
    init(row: Int, col: Int, isStart: Bool = false, isEnd: Bool = false, isWall: Bool = false, distance: Int = Int.max, isVisited: Bool = false, isOnShortestPath: Bool = false, neighbors: [Node] = [], previous: Node? = nil) {
        self.row = row
        self.col = col
        self.isEnd = isEnd
        self.isStart = isStart
        self.isWall = isWall
        self.distance = distance
        self.isVisited = isVisited
        self.neighbors = neighbors
        self.previous = previous
    }
    
    var isStart: Bool = false
    var isEnd: Bool = false
    var isWall: Bool = false
    var distance: Int = Int.max
    var isVisited: Bool = false
    var isOnShortestPath: Bool = false
    var neighbors: [Node] = []
    var previous: Node?
    var isGreen = false
    
    var color: Color {
        if isEnd {return Color.red}
        if isStart {return Color.blue}
        if isWall {return Color.brown}
        if isOnShortestPath {return Color.yellow}
        if isVisited {return Color.green}
        
        else {return Color.gray}
    }
    func visitedNode() {
        isGreen = true
    }
}
extension Node {
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(self.id)
    }
    
    public static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.id == rhs.id
    }
}

