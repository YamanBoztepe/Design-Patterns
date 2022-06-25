import SwiftUI

// MARK: - External Usage
protocol CustomTextFieldProperties {
    var labelText: String? { get }
    var labelBackgroundColor: Color? { get }
    var labelForegroundColor: Color? { get }
}

final class CustomTextFieldBuilder: CustomTextFieldProperties {
    var labelText: String?
    var labelBackgroundColor: Color?
    var labelForegroundColor: Color?
    
    init(build: (CustomTextFieldBuilder) -> Void) {
        build(self)
    }
}

struct CustomTextFieldView: CustomTextFieldProperties, CustomStringConvertible {
    var labelText: String?
    var labelBackgroundColor: Color?
    var labelForegroundColor: Color?
    
    init?(builder: CustomTextFieldBuilder) {
        if let labelText = builder.labelText,
           let labelBackgroundColor = builder.labelBackgroundColor,
           let labelForegroundColor = builder.labelForegroundColor
        {
            self.labelText = labelText
            self.labelBackgroundColor = labelBackgroundColor
            self.labelForegroundColor = labelForegroundColor
            
        } else {
            return nil
        }
    }
    
    var description: String {
        return "Text: \(labelText), background: \(labelBackgroundColor), foreground: \(labelForegroundColor)"
    }
}

let textfieldProperties = CustomTextFieldBuilder { builder in
    builder.labelText = "Name"
    builder.labelBackgroundColor = .blue
    builder.labelForegroundColor = .white
}

if let customTextField = CustomTextFieldView(builder: textfieldProperties) {
    print(customTextField.description)
}

// MARK: - Internal Usage
struct Person: CustomStringConvertible {
    let name: String
    let hairColor: Color
    let eyeColor: Color
    let height: Double
    let weight: Double
    
    var description: String {
        return "I am \(name), my hair color is \(hairColor) and eye color is \(eyeColor). My weight is \(weight) and height is \(height)"
    }
}

class CandidateBuilder {
    private(set) var name: String?
    private(set) var hairColor: Color?
    private(set) var eyeColor: Color?
    private(set) var height: Double?
    private(set) var weight: Double?
    
    func set(name: String) {
        self.name = name
    }
    
    func set(hairColor: Color) {
        self.hairColor = hairColor
    }
    
    func set(eyeColor: Color) {
        self.eyeColor = eyeColor
    }
    
    func set(height: Double) {
        self.height = height
    }
    
    func set(weight: Double) {
        self.weight = weight
    }
    
    func build() -> Person? {
        guard let name = name,
              let hairColor = hairColor,
              let eyeColor = eyeColor,
              let height = height,
              let weight = weight else { return nil }
        
        return Person(name: name, hairColor: hairColor, eyeColor: eyeColor, height: height, weight: weight)
    }
}

class ScientificResearch {
    var firstCandidateType: Person? {
        let builder = CandidateBuilder()
        builder.set(name: "Yaman")
        builder.set(hairColor: .black)
        builder.set(eyeColor: .black)
        builder.set(height: 185)
        builder.set(weight: 80)
        return builder.build()
    }
    
    var secondCandidateType: Person? {
        let builder = CandidateBuilder()
        builder.set(name: "Mehmet")
        builder.set(hairColor: .yellow)
        builder.set(eyeColor: .green)
        builder.set(height: 175)
        builder.set(weight: 70)
        return builder.build()
    }
}

let research = ScientificResearch()

if let firstOne = research.firstCandidateType {
    print(firstOne.description)
}

if let secondOne = research.secondCandidateType {
    print(secondOne.description)
}
