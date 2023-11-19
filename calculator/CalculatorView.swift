//
//  ContentView.swift
//  calculator
//
//  Created by Сергей Дарьин on 25.07.2023.
//

import SwiftUI

enum calcButton : String{
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case multiply = "＊"
    case divide = "÷"
    case equal = "="
    case clear = "AC"
    case decimal = ","
    case percent = "%"
    case negative = "+/-"
    
    var buttonColor: Color{
        switch self{
        case .divide, .multiply, .subtract, .add, .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}

enum Operataion {
    case add
    case subtract
    case multiply
    case divide
    case equal
    case none
}

struct CalculatorView: View {
    
    @State var value = "0"
    @State var runningNumber = 0.0
    @State var DoublePressed = false
    @State var currentOperation: Operataion = .none
    @State var DarkMode = true
    
    let buttons : [[calcButton]] = [
        [.clear, .percent, .negative, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    
    
    var body: some View {
        VStack{
            ZStack{
                if DarkMode{
                    Color.black.edgesIgnoringSafeArea(.all)
                }
                else{
                    Color.white.edgesIgnoringSafeArea(.all)
                }
                
                VStack{
                    Spacer()
                    //Text display
                    HStack{
                        Spacer()
                        Text(value)
                            .bold()
                            .font(.system(size: buttonHeight()/2))
                            .foregroundColor(.white)
                    }
                    .padding()
                    
                    //Buttons
                    ForEach(buttons, id: \.self){row in
                        HStack(spacing: 10){
                            ForEach(row, id: \.self){item in
                                Button(action: {
                                    didTap(button: item)
                                }, label: {
                                    Text(item.rawValue)
                                        .font(.system(size: buttonHeight()/3))
                                        .frame(width: self.buttonWidth(item: item),
                                               height: self.buttonHeight())
                                        .background(item.buttonColor)
                                        .foregroundColor(.white)
                                        .cornerRadius(buttonHeight()/2)
                                })
                            }
                        }
                        .padding(.bottom, 3)
                    }
                }
            }
        }
    }
    
    func didTap(button: calcButton){
        switch button{
        case .add, .subtract, .multiply, .divide, .equal:
//                //Ariphmethic operations
                if button == .add{
                    self.currentOperation = .add
                    self.runningNumber = Double(self.value) ?? 0
                }
                else if button == .subtract{
                    self.currentOperation = .subtract
                    self.runningNumber = Double(self.value) ?? 0
                }
                else if button == .multiply{
                    self.currentOperation = .multiply
                    self.runningNumber = Double(self.value) ?? 0
                    self.runningNumber = Double(self.value) ?? 0
                }
                else if button == .divide{
                    self.currentOperation = .divide
                    self.runningNumber = Double(self.value) ?? 0
                }
                else if button == .equal{
                    let runningValue = Double(self.runningNumber)
                    let currentValue = Double(self.value) ?? 0
                    switch self.currentOperation{
                    case .subtract:
                        self.value = "\(runningValue - currentValue)"
                        if (Double(self.value)) == round(Double(self.value) ?? 0.0){
                            self.value = "\(lround(Double(self.value) ?? 0))"
                        }
                    case .multiply:
                        self.value = "\(runningValue * currentValue)"
                        if (Double(self.value)) == round(Double(self.value) ?? 0.0){
                            self.value = "\(lround(Double(self.value) ?? 0))"
                        }
                    case .divide:
                        self.value = "\(runningValue / currentValue)"
                        if (Double(self.value)) == round(Double(self.value) ?? 0.0){
                            self.value = "\(lround(Double(self.value) ?? 0))"
                        }
                    case .add:
                        self.value = "\(runningValue + currentValue)"
                        if (Double(self.value)) == round(Double(self.value) ?? 0.0){
                            self.value = "\(lround(Double(self.value) ?? 0))"
                        }
                    case .equal:
                        self.currentOperation = .equal
                    case .none:
                        break
                    }
                    
                }
            if button != .equal{
                self.value = "0"
            }
        case .clear:
            self.value = "0"
        case .negative:
            self.value = "\((Int(value) ?? 0) * -1)"
        case .percent:
            let currentPercents = Double(self.value) ?? 0
            let currentNumber = self.runningNumber
            
            self.value = "\(currentNumber * (currentPercents / 100.0))"
        case .decimal:
            self.DoublePressed = true
            self.value += "."
        default:
            if currentOperation == .equal{
                self.value = "0"
                currentOperation = .none
            }
            let number = button.rawValue
            if self.value == "0"{
                value = number
            }
            else{
                self.value = "\(self.value)\(number)"
            }
            
        }
    }
    
    func buttonWidth(item: calcButton) -> CGFloat{
        if item == .zero{
            return (UIScreen.main.bounds.width - (5*12)) / 2
        }
        else{
            return (UIScreen.main.bounds.width - (5*12)) / 4
        }
    }
    
    func buttonHeight() -> CGFloat{
        return buttonWidth(item: .one)
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            CalculatorView()
        }
    }

