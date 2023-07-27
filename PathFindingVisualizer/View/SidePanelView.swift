//
//  SidePanelView.swift
//  PathFindingVisualizer
//
//  Created by Tomas Sungaila on 7/26/23.
//

import SwiftUI

struct SidePanelView: View {
    
    @ObservedObject var viewModel: GridViewModel
    
    var isRunEnabled: Bool {
        if viewModel.startNode is (Int, Int) {
            if viewModel.endNode is (Int, Int) {
                return false
            }
        }
        return true
    }
    
    var body: some View {
        VStack {
            
            Button {
                // start path finding
                viewModel.start()
            } label: {
                Text("Run")
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemBlue))
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .foregroundColor(.primary)
                    .font(.largeTitle)
            }
            .buttonStyle(PlainButtonStyle())
            .disabled(isRunEnabled)
            
            VStack {
                Text("Dijkstra Algorithm")
                    .font(.title2)
                    .fontWeight(.semibold)
                Text("A* Algortihm")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .padding()
            
            Toggle(isOn: $viewModel.startToggle) {
                Text("Select Start Node")
            }
            .toggleStyle(.switch)
            .foregroundColor(.blue)
            .fontWeight(.semibold)
            
            Toggle(isOn: $viewModel.endToggle) {
                Text("Select End Node")
            }
            .toggleStyle(.switch)
            .foregroundColor(.red)
            .fontWeight(.semibold)
            
            Toggle(isOn: $viewModel.wallToggle) {
                Text("Select Wall Nodes")
            }
            .toggleStyle(.switch)
            .foregroundColor(.brown)
            .fontWeight(.semibold)
            
            Spacer()
            
            Button {
                viewModel.resetGrid()
            } label: {
                Text("Reset")
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .foregroundColor(.primary)
                    .font(.largeTitle)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
        .frame(minWidth: 180, idealWidth: 200)
    }
}

struct SidePanelView_Previews: PreviewProvider {
    static var previews: some View {
        SidePanelView(viewModel: GridViewModel())
    }
}
