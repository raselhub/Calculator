//
//  ContentView.swift
//  Shared
//
//  Created by Mohammad Rasel on 1/25/22.
//  Copyright *2022. All rights reserved.

import SwiftUI

enum CalButton: String {
    case one="1"
    case two="2"
    case three="3"
    case four="4"
    case five="5"
    case six="6"
    case seven="7"
    case eight="8"
    case nine="9"
    case zero="0"
    case add="+"
    case subtract="-"
    case multiply="*"
    case divide="÷"
    case decimal="."
    case percent="%"
    case negative="-/+"
    case root="√"
    case clear="AC"
    case equal="="
    case delete="C"
    case power="Ex"
    case fraction="a/b"
    case doubleZero="00"
    case log="log"
    
     var buttonColor: Color {
         switch self {
         case .add, .subtract, .multiply, .divide,  .power:
             return .brown
         case .clear:
             return Color(.red)
         case .log, .fraction,  .negative, .percent, .root:
             return Color(.lightGray)
        
         case .delete:
             return Color(.yellow)
         default:
             return Color(UIColor(displayP3Red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
    
}
enum Operation {
    case add, substract, multiply, divide, power, root, log, fraction, none
}

struct ContentView: View {
    
    @State var value = "0"
    @State var runningNumber = 0.0
    @State var currentOperation: Operation = .none
    
    let buttons: [[CalButton]] = [
        [.negative, .percent, .root, .clear,  .delete],
        [ .seven,    .eight,  .nine,  .log,   .fraction],
        [  .four,     .five,   .six,  .divide, .multiply],
        [   .one,     .two,   .three, .subtract, .add],
        [  .power, .doubleZero, .zero, .decimal, .equal],
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                //text display
                HStack{
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 100))
                        .foregroundColor(.white)
            }
                .padding()
                 
                
                
                
                //our buttons
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                    ForEach(row, id: \.self) { item in
                        Button(action: {
                            self.didTap(button: item)
                                },
                               label:{
                        
                            Text(item.rawValue)
                                .font(.system(size: 40))
                                .frame(
                                    width: self.buttonWidth(item: item),
                                    height: self.buttonHeight() )
                                .background(Color.blue)//.backround(item.buttonColor)
                                .foregroundColor(.white)
                                .cornerRadius(self.buttonWidth(item: item)/2)
                        })
                    }
                    }  .padding(.bottom, 3)
                    
            }
        }
    }
}
   /* func pow(base: Int, power: UInt) -> Int {
        If; power = 0; do {
            return 1
        };  if base = 2; do {
            return 2 << Int(power-1)
        }; return repeatElement(base, count: <#T##Int#>(power)).reduce(1, *)
    }  */
    func didTap(button: CalButton) {
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            if button == .add {
                self.currentOperation = .add
                self.runningNumber += Double(self.value)  ?? 0.0
                
            }
            else if button == .subtract {
                self.currentOperation = .substract
                self.runningNumber = Double(self.value)  ?? 0.0
            }
            else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNumber = Double(self.value)  ?? 0.0
            }
            else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = Double(self.value)  ?? 0.0
            }
           
            
            else if button == .root {
                self.currentOperation = .root
                self.runningNumber = Double(self.value)  ?? 0.0
            }
            else if button == .power {
                self.currentOperation = .power
                self.runningNumber = Double(self.value)  ?? 0.0
            }
            else if button == .fraction {
                self.currentOperation = .fraction
                self.runningNumber = Double(self.value)  ?? 0.0
            }
            else if button == .log {
                self.currentOperation = .log
                self.runningNumber = Double(self.value)  ?? 0.0
            }
            else if button == .equal {
                let runningValue = self.runningNumber
                let currentValue = Double(self.value)  ?? 0.0
                
                switch self.currentOperation {
                case .add: self.value = "\(runningValue + currentValue)"
                case .substract: self.value = "\(runningValue - currentValue)"
                case .multiply: self.value = "\(runningValue * currentValue)"
                case .divide: self.value = "\(runningValue / currentValue)"
                case .none:
                    break
                case .power:
                    self.value = "\(runningValue - currentValue)"
                case .root:
                    self.value = "\(runningValue - currentValue)"
                case .log:
                    self.value = "\(runningValue - currentValue)"
                case .fraction:
                    self.value = "\(runningValue - currentValue)"
                
                }
            }
            if button != .equal {
                self.value = "0"
            }
        case .clear, .delete:
            self.value = "0"
        
        case .decimal, .negative, .percent, .root, .power:
            break
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            } else {
                self.value = "\(self.value)\(number)"
            }
            
        }
    }
    func buttonWidth(item: CalButton) -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 6
    }
    func buttonHeight() ->CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 6
        // for making zero button bigger
        /* if item == .zero {
         return ((UIScreeen.main.bounds.width - (4*12)) / 4) *2
         */
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
