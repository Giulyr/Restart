//
//  CircleGroupView.swift
//  Restart
//
//  Created by Giulls on 27/12/21.
//

import SwiftUI

struct CircleGroupView: View {
    //MARK: - PROPERTY
    @State var ShapeColor: Color
    @State var ShapeOpacity: Double  // qui non vengono dati dei valori iniziali in modo da poter modificare nelle varie schermate la figura
    @State private var isAnimating : Bool = false
    
    
    //MARK: - BODY
    
    var body: some View {
        ZStack {
            Circle ()
                .stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: 40)
                .frame (width: 260, height: 260, alignment: .center)
            Circle ()
                .stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: 80) //qui vengono sostuiti il valore colore e opacità con le var create @State, in modo da poterle cambiare nelle diverse view
                .frame(width: 260, height: 260, alignment: .center)
            
            
        } //ZStack
        .blur(radius: isAnimating ? 0 : 10)
        .opacity(isAnimating ? 1 : 0)
        .scaleEffect(isAnimating ? 1 : 0.5)
        .animation(.easeOut(duration: 1), value: isAnimating)
        .onAppear(perform: {
            isAnimating = true
            
        })
    }
}

struct CircleGroupView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("ColorBlue")
                . ignoresSafeArea (.all, edges: .all) //dato che i cerchi sono bianchi per poterli vedere, viene aggiunto un colore alla PREVIEW!
            CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2) // qui bisogna invece inserire dei valori in quanto altrimenti la preview crash, non sapendo cosa deve displayare
        }
    }
}
// questa view viene fatta in modo da poterla applicare a diverse view senza dover riscrivere il codice, per questo viene aggiunta una property (all'inizio)
