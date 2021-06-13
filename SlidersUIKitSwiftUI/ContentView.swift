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
            SliderFromUIKit(value: $sliderValue, target: target)
            ButtonCheck(currentValue: sliderValue, targetValue: target, text: "Проверь меня!")
            Button(action: update, label: { Text("Начать заново") })
            
        }
            .padding()
        
    }
    private func update() {
        target = Int.random(in: 0...100)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ValueSlider: View {
    @Binding var value: Double
    let target: Int
    
    var body: some View {
        Slider(value: $value, in: 0...100, minimumValueLabel: Text("0"), maximumValueLabel: Text("100")) {
            Text("text")
        }
    }
    
}

struct ButtonCheck: View {
    @State private var alertPresented = false
    @State private var score = 0
    let currentValue: Double
    let targetValue: Int
    
    let text: String
    var body: some View {
        Button(action: checkValue, label: { Text(text) })
        .alert(isPresented: $alertPresented, content: {
            Alert(title: Text("Your Score"), message: Text("\(score)"), dismissButton: .default(Text("OK")))
        })
        
    }
    
    private func checkValue() {
        score = computeScore()
        alertPresented = true
    }
    
    private func computeScore() -> Int {
     let difference = abs(targetValue - lround(currentValue))
     return 100 - difference
    }
}

