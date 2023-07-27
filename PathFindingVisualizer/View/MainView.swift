//
//  MainView.swift
//  PathFindingVisualizer
//
//  Created by Tomas Sungaila on 7/26/23.
//

import SwiftUI

struct MainView: View {
    
    let rows = 20
    let columns = 20
    
//    @StateObject var viewModel = GridViewModel()
    
    @ObservedObject var viewModel: GridViewModel
    
    var body: some View {
        VStack {
            Grid(horizontalSpacing: 3, verticalSpacing: 3) {
                ForEach(viewModel.nodeGrid, id: \.self) { row in
                    GridRow {
                        ForEach(row, id: \.self) { node in
                            NodeView(viewModel: viewModel, node: node)
                        }
                    }
                }
            }
        }
        .padding()
        .background(.white)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: GridViewModel())
    }
}
