//
//  ContentView.swift
//  SlidersUIKitSwiftUI
//
//  Created by Артем Соколовский on 11.06.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var sliderValue = Double.random(in: 0...100)
    @State private var target = Int.random(in: 0...100)
    
    var body: some View {
        
        VStack {
            Text("Подвиньте слайдер как можно ближе к \(target)")
            SliderFromUIKit(value: $sliderValue, alpha: computeScore())
            ButtonCheck(score: computeScore(), text: "Проверь меня!")
            Button(action: update, label: { Text("Начать заново") })
            
        }
            .padding()
        
    }
    private func update() {
        target = Int.random(in: 0...100)
    }
    
    private func computeScore() -> Int {
        let difference = abs(target - lround(sliderValue))
        return 100 - difference
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ButtonCheck: View {
    @State private var alertPresented = false
    let score: Int
    
    let text: String
    var body: some View {
        Button(action: checkValue, label: { Text(text) })
        .alert(isPresented: $alertPresented, content: {
            Alert(title: Text("Your Score"), message: Text("\(score)"), dismissButton: .default(Text("OK")))
        })
        
    }
    
    private func checkValue() {
        alertPresented = true
    }

}

