//
//  OnboardingView.swift
//  Restart
//
//  Created by Giulls on 27/12/21.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage ("onboarding") var isOnboardingViewActive: Bool = true
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80 //il bottone sarà della lunghezza dello schermo (qualsiasi device) - 80 pixels
    @State private var buttonOffset: CGFloat = 0 // questa proprietà rappresenta il valore dell'asset del bottone nella direzione orizziontale
    // ci sono due proprietà la 1 è una proprietà del bottone quando è in movimento, l'altra è una proprietà del bottone quando è statico, per questo è inizializzato a 0, ma cambierà continuamente quando viene trascinato
    @State private var isAnimating: Bool = false //proprietà per controllare l'animazione, come se fosse uno switcher
    @State private var imageOffset: CGSize = .zero
    
    
    var body: some View {
        
        ZStack {
            
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack (spacing: 20){
                
                //MARK: - HEADER
                
                Spacer()
                
                VStack (spacing: 0){
                    Text ("Share.")
                        .font(.system(size:60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                    Text ("""
                          It's not how much we give,
                          but how much love we put into giving.
                          """) //per testi che vanno a capo
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                } //Header
                
                .opacity(isAnimating ? 1 : 0) // TERNARY OPERATOR
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating) //da questo dipende la durata dell'animazione, value sta per il parametro, ovvero, swift vuole sapere da quale valore è causato il cambiamento, in questo caso dalla var isAnimating che può essere either vera o falsa
                
                
                //MARK: - CENTER
                
                ZStack {
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .gesture (
                            DragGesture()
                                .onChanged{ gesture in
                                    imageOffset = gesture.translation  
                                }
                        )//: Gesture 
                } //Center
                
                Spacer ()
                
                //MARK: - FOOTER
                
                ZStack {
                    // PARTS OF THE CUSTOM BUTTON
                    
                    // 1. BACKGROUND (STATIC)
                    
                    Capsule ()
                        .fill(Color.white.opacity(0.2))
                    
                    Capsule ()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    // 2. CALL-TO-ACTION (STATIC)
                    
                    Text ("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                    // 3. CAPSULE (DINAMIC WIDTH)
                    
                    HStack{
                        Capsule ()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 80) //così facendo indichiamo la dimensione x del bottone + 80, in quanto il punto di partenza è 0 (considerando che ci sono due cerchi sovrapposti, e questa proprietà viene applicata al cerchio sotto
                        
                        Spacer ()
                        
                    }
                    
                    // 4. CIRCLE (DRAGGABLE)
                    
                    HStack {
                        ZStack {
                            Circle ()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                            
                        } //ZStack
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffset) // questo valore è l'offset property
                        .gesture(
                            DragGesture()
                                .onChanged {  gesture in
                                    if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                                        // questo determina la direzione del movimento, in quanto in questo modo inizialmente il bottone può essere trascinato solo da sx verso dx (essendo maggiore di 0 il punto di inizio)
                                        
                                        buttonOffset = gesture.translation.width
                                        // qui viene dato un nuovo valore all'offset property rispetto a quanto viene mosso il dito sullo schermo
                                    }
                                    
                                }
                                .onEnded {  _ in
                                    withAnimation(Animation.easeOut(duration: 0.4)) { //questa è una propr di swiftui che dice al programma cosa fare quando switcha da una pag all'altra, ovvero durante la transazione, in questo caso fa --> easeOut
                                        if buttonOffset > buttonWidth / 2 {
                                            buttonOffset = buttonWidth - 80// se il bottone viene trascinato a più della metà dello slider, allora resterà sul lato destro
                                            isOnboardingViewActive = false //settandolo su falso, andrà nella pagina consecutiva grazie agli @State settati precedentemente
                                            
                                        } else {
                                            buttonOffset = 0 // se invece il bottone viene trascinato a meno della metà dello slider, il bottone tornerà alla sua posizione di default (0)
                                        }
                                    }
                                }
                        ) // Gesture
                        
                        Spacer ()
                        
                    } //HStack
                    
                } //Footer
                
                .frame (width: buttonWidth,  height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                
            } //VStack
        } //ZStack
        .onAppear(perform: {
            isAnimating = true //grazie alla proprietà @State, basta cambiare la condizione in true, affinchè l'animazione inizi, in questo caso, quando appare (quando viene avviata l'app) viene applicato alla fine dello ZStack, in modo che sia applicato a tutti gli elementi e determinare l'animazione nelle signole parti successivamente (quindi ora scriveremo le animazioni nel dettaglio all'interno del codice che ci interessa, ovvero la parte che bisogna animare)
        })
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
