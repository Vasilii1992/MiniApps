
import UIKit

final class WeatherLabel: UILabel {
    
    var labelText: String
    var color: UIColor
    var fontSize: CGFloat
    var weight: UIFont.Weight
    var labelIsHidden: Bool

    
    init(labelText: String = "", color: UIColor = .black, fontSize: CGFloat, weight: UIFont.Weight,labelIsHidden: Bool = false ) {
        self.labelText = labelText
        self.color = color
        self.fontSize = fontSize
        self.weight = weight
        self.labelIsHidden = labelIsHidden
        
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        setupLabel()
    }
    
    private func setupLabel() {
        self.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        self.textColor = color
        self.text = labelText
        self.numberOfLines = 2
        self.textAlignment = .center
        self.isHidden = labelIsHidden
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

