//
//  GridViewModel.swift
//  PathFindingVisualizer
//
//  Created by Tomas Sungaila on 7/26/23.
//

import Foundation

class GridViewModel: ObservableObject {
    
    let rows = 20
    let columns = 20
    
    @Published var nodeGrid = [[Node]]()
    @Published var visitedNodes: [Node] = [Node]()
    
    var grid: [[Node]] {
        var items: [[Node]] = []
                for row in 0 ..< rows {
                    var rowItems: [Node] = []
                    for column in 0 ..< columns {
                        let item = Node(row: row, col: column)
                        rowItems.append(item)
                    }
                    items.append(rowItems)
                }
                return items
    }
    

    
    init() {
        nodeGrid = grid
    }
    
    @Published var startNode: (Int?, Int?) = (nil, nil)
    @Published var endNode: (Int?, Int?) = (nil, nil)
    @Published var wallNodes: [(Int?, Int?)] = []

    
    @Published var startToggle = false {
        didSet {
            if startToggle {
                endToggle = false
                wallToggle = false
            }
        }
    }
    
    @Published var endToggle = false {
        didSet {
            if endToggle {
                startToggle = false
                wallToggle = false
            }
        }
    }
    @Published var wallToggle = false {
        didSet {
            if wallToggle {
                startToggle = false
                endToggle = false
            }
        }
    }
    
    func resetGrid() {
        nodeGrid = grid
        startNode = (nil, nil)
        endNode = (nil, nil)
        wallNodes = []
    }
    
    func start() {
        let end = nodeGrid[endNode.0!][endNode.1!]
        
        let visitedNodes = dijkstraAlgorithm()
//        var count = 0
//        for item in visitedNodes {
//            DispatchQueue.main.asyncAfter(deadline: .now() + Double(count + 1) * 0.05) {
//                item.visitedNode()
//            }
//            count += 1
//        }
        let shortestPath = getShortestPath(endNode: end)
        
        for item in 0 ..< shortestPath.count {
            print("Node \(item), row: \(shortestPath[item].row), col: \(shortestPath[item].col)")
        }
    }
    
    
    func dijkstraAlgorithm() -> [Node] {
        let end = nodeGrid[endNode.0!][endNode.1!]
        
        var unvisitedNodes: [Node] = nodeGrid.flatMap { $0 }
        
        while(unvisitedNodes.count > 0) {
            unvisitedNodes = sortNodes(nodes: unvisitedNodes)
            
            let currentNode: Node = unvisitedNodes.removeFirst()
            
            if !currentNode.isWall {
                if currentNode.distance == Int.max {
                    return visitedNodes
                }
                currentNode.isVisited = true
                visitedNodes.append(currentNode)
                
                if currentNode == end {
                    return visitedNodes
                }
                
                let unvisitedNeighbors: [Node] = getUnvisitedNeighbors(node: currentNode)
                
                for neighbor in unvisitedNeighbors {
                    neighbor.distance = currentNode.distance + 1
                    neighbor.previous = currentNode
                }
                
            }
        }
        return visitedNodes
    }
    
    
    func sortNodes(nodes: [Node]) -> [Node] {
        return (nodes.sorted(by: {(nodeA:Node, nodeB:Node)-> Bool in return nodeA.distance < nodeB.distance}))
    }
    
    func getUnvisitedNeighbors(node: Node) -> [Node] {
        var neighbors:[Node] = []
        
        if node.row > 0 {
            neighbors.append(nodeGrid[node.row - 1][node.col])
        }
        if node.row < rows - 1 {
            neighbors.append(nodeGrid[node.row + 1][node.col])
        }
        if node.col > 0 {
            neighbors.append(nodeGrid[node.row][node.col - 1])
        }
        if node.col < columns - 1 {
            neighbors.append(nodeGrid[node.row][node.col + 1])
        }
        
        var temp: [Node] = []
        
        for item in neighbors {
            if !item.isVisited {
                temp.append(item)
            }
        }
        
        return temp
    }
    func getShortestPath(endNode: Node) -> [Node] {
        var shortestPath: [Node] = []
        var current = endNode
        
        while current.previous !== nil {
            current.isOnShortestPath = true
            shortestPath.insert(current, at: 0)
            current = current.previous!
        }
        
        return shortestPath
    }
}
