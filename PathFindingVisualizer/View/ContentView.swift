//
//  ContentView.swift
//  PathFindingVisualizer
//
//  Created by Tomas Sungaila on 7/26/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = GridViewModel()
    
    var body: some View {
        NavigationView {
            
            SidePanelView(viewModel: viewModel)
            
            MainView(viewModel: viewModel)
        }
        .frame(minWidth: 700, minHeight: 600)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
