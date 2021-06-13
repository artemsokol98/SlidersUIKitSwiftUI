//
//  SliderFromUIKit.swift
//  SlidersUIKitSwiftUI
//
//  Created by Артем Соколовский on 11.06.2021.
//

import SwiftUI
import Foundation

struct SliderFromUIKit: UIViewRepresentable {
    final class Coordinator: NSObject {
        
        var value: Binding<Double>
        init(value: Binding<Double>) {
            self.value = value
        }

        @objc func valueChanged(_ sender: UISlider) {
          self.value.wrappedValue = Double(sender.value)
        }
      }

      @Binding var value: Double
      var target: Int

      func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)
        slider.thumbTintColor = UIColor(displayP3Red: 1.0, green: 0.0, blue: 0.0, alpha: calculateOpacity())
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.minimumTrackTintColor = .blue
        slider.value = Float(value)

        slider.addTarget(
          context.coordinator,
          action: #selector(Coordinator.valueChanged(_:)),
          for: .valueChanged
        )

        return slider
      }

      func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(self.value)
        uiView.thumbTintColor = UIColor(displayP3Red: 1.0, green: 0.0, blue: 0.0, alpha: calculateOpacity())
      }

      func makeCoordinator() -> SliderFromUIKit.Coordinator {
        Coordinator(value: $value)
      }
    
     func calculateOpacity() -> CGFloat {
        let difference = abs(target - lround(value))
        return CGFloat((100.0 - Double(difference))/100.0)
    }
}

struct SliderFromUIKit_Previews: PreviewProvider {
    static var previews: some View {
        SliderFromUIKit(value: .constant(0.5), target: 50)
    }
}
