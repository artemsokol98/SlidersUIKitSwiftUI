//
//  SliderFromUIKit.swift
//  SlidersUIKitSwiftUI
//
//  Created by Артем Соколовский on 11.06.2021.
//

import SwiftUI
import Foundation

struct SliderFromUIKit: UIViewRepresentable {
    
      @Binding var value: Double
      let alpha: Int
    
      func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.minimumTrackTintColor = .blue

        slider.addTarget(
          context.coordinator,
          action: #selector(Coordinator.valueChanged(_:)),
          for: .valueChanged
        )

        return slider
      }

      func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(value)
        uiView.thumbTintColor = .red.withAlphaComponent(CGFloat(alpha) / 100)
      }

      func makeCoordinator() -> Coordinator {
        Coordinator(value: $value)
      }
    
}

extension SliderFromUIKit {
    class Coordinator: NSObject {
        
        @Binding var value: Double
        
        init(value: Binding<Double>) {
            self._value = value
        }

        @objc func valueChanged(_ sender: UISlider) {
          value = Double(sender.value)
        }
      }
}

struct SliderFromUIKit_Previews: PreviewProvider {
    static var previews: some View {
        SliderFromUIKit(value: .constant(0.5), alpha: 50)
    }
}
