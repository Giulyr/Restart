//
//  HomeView.swift
//  Restart
//
//  Created by Giulls on 27/12/21.
//

import SwiftUI

struct HomeView: View {
    @AppStorage ("onboarding") var isOnboardingViewActive: Bool = false
    @State private var isAnimating : Bool = false
    
    var body: some View {
        VStack (spacing: 20){
            
            // MARK: - HEADER
            
            Spacer ()
            
            ZStack {
                CircleGroupView(ShapeColor: .gray, ShapeOpacity: 0.1)

                Image ("character-2")
                    .resizable()
                    .scaledToFit()
                .padding()
                .offset(y: isAnimating ? 35 : -35)
                .animation(
                Animation
                    .easeInOut(duration: 4)
                    .repeatForever(),
                value: isAnimating
                )
               
            } //ZStack
            
            
            
            // MARK: - CENTER
            
            Text ("The time that leads to mastery is dependent on the intensity of our focus.")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()

            // MARK: - FOOTER
            
            Spacer ()
            
            
            
            Button(action:{
                withAnimation{
                    isOnboardingViewActive = true
                    
                }
            }) { // in questo caso non c'è bisogno di un HStack per sistemare gli elementi, in quanto, quando si una Button, swift sistema automaticamente gli elementi inseriti
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                
                Text ("Restart")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
                
            } //Button
            //I seguenti sono modificatori del design del bottone per questo vengono inseriti alla fine delle parentesi
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        } //VStack
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                isAnimating = true
            })
        })
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
