//
//  LoadingView.swift
//  PGame
//
//  Created by IGOR on 27/09/2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {

        ZStack {
            
            Color("bgn")
                .ignoresSafeArea()
            
            VStack {
                
                Image("bgu")
                    .resizable()
            }
            .ignoresSafeArea()
            
            VStack {
                
                Image("l2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                    .padding(.top, 140)
                
                Spacer()
                
                VStack {
                    
                    ProgressView()
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 120)
                .background(RoundedRectangle(cornerRadius: 25.0).fill(Color("bgn")))
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    LoadingView()
}
