//
//  NodeView.swift
//  PathFindingVisualizer
//
//  Created by Tomas Sungaila on 7/26/23.
//

import SwiftUI

struct NodeView: View {
    
    @ObservedObject var viewModel: GridViewModel
    
    var node: Node
    
    var body: some View {
        Rectangle()
//            .foregroundColor(node.isStart ? .blue : node.isEnd ? .red : node.isWall ? .brown : node.isOnShortestPath ? .yellow : node.isVisited ? .green : .gray)
            .foregroundColor(node.color)
            .animation(.easeIn, value: node.color)
            .frame(maxWidth: .infinity)
            .onTapGesture {
                withAnimation {
                    if viewModel.startToggle {
                        startNodeDrawing()
                        
                    }
                    if viewModel.endToggle {
                        endNodeDrawing()
                    }
                    if viewModel.wallToggle {
                        wallNodeDrawing()
                    }
                }
                
            }
    }
    func startNodeDrawing() {
        var newNode = Node(row: node.row, col: node.col, isStart: !node.isStart)
        if let (i, j) = viewModel.startNode as? (Int, Int) {
            if i != node.row || j != node.col {
                let oldNode = Node(row: i, col: j, isStart: !viewModel.nodeGrid[i][j].isStart)
                viewModel.nodeGrid[i][j] = oldNode
            }

                
        }
        
        if newNode.isStart {
            viewModel.startNode = (node.row, node.col)
            newNode.distance = 0
        } else if !newNode.isStart {
            viewModel.startNode = (nil, nil)
        }
        viewModel.nodeGrid[node.row][node.col] = newNode

        
    }
    
    
    func endNodeDrawing(){
        let newNode = Node(row: node.row, col: node.col, isEnd: !node.isEnd)
        if let (i, j) = viewModel.endNode as? (Int, Int) {

            if i != node.row || j != node.col {
                let oldNode = Node(row: i, col: j, isEnd: !viewModel.nodeGrid[i][j].isEnd)
                viewModel.nodeGrid[i][j] = oldNode

            }

                
        }
        
        if newNode.isEnd {
            viewModel.endNode = (node.row, node.col)
        } else if !newNode.isEnd {
            viewModel.endNode = (nil, nil)
        }
        viewModel.nodeGrid[node.row][node.col] = newNode

        
    }
    
    func wallNodeDrawing() {

        let newNode = Node(row: node.row, col: node.col, isWall: !node.isWall)
        let unwrappedNodes: [(Int, Int)] = viewModel.wallNodes.compactMap({ ($0, $1) as? (Int, Int) })
        if unwrappedNodes.contains(where: {$0 == (node.row, node.col)}) {
            viewModel.wallNodes = unwrappedNodes.filter { $0 != (node.row, node.col) }
        } else {
            viewModel.wallNodes.append((node.row, node.col))
        }
        viewModel.nodeGrid[node.row][node.col] = newNode

    }
}

struct NodeView_Previews: PreviewProvider {
    static var previews: some View {
        NodeView(viewModel: GridViewModel(), node: Node(row: 0, col: 0))
    }
}
