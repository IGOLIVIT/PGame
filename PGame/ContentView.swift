//
//  ContentView.swift
//  PGame
//
//  Created by IGOR on 27/09/2024.
//

import SwiftUI

struct ContentView: View {
        
    @State var isFetched: Bool = false
    
    @State var isBlock: Bool = true
    @State var isDead: Bool = false
    
    @AppStorage("status") var status: Bool = false
    
    init() {
        
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            if isFetched == false {
                
                LoadingView()
                
            } else if isFetched == true {
                
                if isBlock == true {
                    
                    if status {
                        
                        ProjectsView()

                        
                    } else {
                        
                        R1()
                    }
                    
                } else if isBlock == false {
                    
                    if status {
                        
                        WebSystem()
                        
                    } else {
                        
                        U1()
                    }
                }
            }
        }
        .onAppear {
            
            check_data()
        }
    }
    
    private func check_data() {
        
        self.isDead = DataManager().isDead
        
        let networkService = NetworkService()
        let deviceData = DeviceInfo.collectData()
        
        networkService.sendRequest(endpoint: deviceData) { result in
            
            print(result)
            
            switch result {
                
            case .success(let success):
                
                self.isBlock = success
                self.isFetched = true
                
            case .failure(_):
                
                self.isBlock = self.isDead
                self.isFetched = true
            }
        }
    }
}

#Preview {
    ContentView()
}
