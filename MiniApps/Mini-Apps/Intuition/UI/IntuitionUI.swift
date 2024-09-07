
import UIKit

final class IntuitionUI {

    lazy var backgroundSprite: UIImageView = {
        let image = UIImageView()
        image.image = .backImg
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    

    lazy var leftDoor: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 1
        button.setBackgroundImage(.door1Close, for: .normal)
        button.setBackgroundImage(.door1Open, for: .highlighted)
        return button
    }()

    lazy var rightDoor: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 2
        button.setBackgroundImage(.door2Close, for: .normal)
        button.setBackgroundImage(.door2Open, for: .highlighted)
        return button
    }()

    lazy var buttonsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var selectedLabel = createTextLabel(labelText: .selected, labelFontSize: 20)
    lazy var recordLabel = createTextLabel(labelText: .record, color: .black, labelFontSize: 30)
    lazy var recordValue = createTextLabel(labelText: .zero, color: .black, labelFontSize: 30)
    lazy var correctLabel = createTextLabel(labelText: .correct,color: .appGreen, labelFontSize: 20)
    lazy var inCorrectLabel = createTextLabel(labelText: .inCorrect,color: .appRed, labelFontSize: 20)

    lazy var scoreLabel = createTextLabel(labelText: .score, labelFontSize: 40)
    lazy var scoreValue = createTextLabel(labelText: .zero, labelFontSize: 40)
    lazy var scoreDescription = getScoreDescriptionLabel(score: 0)
    
    private func getScoreDescriptionLabel(score: Int) -> UILabel {
        let description = createTextLabel(labelText: .zero, labelFontSize: 20)
        description.text = LabelStrings.getCurrentResultText(score: score)
        return description
    }

//MARK: Stack
    private lazy var scoreResultStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.addArrangedSubview(UIView())
        stack.addArrangedSubview(scoreLabel)
        stack.addArrangedSubview(scoreValue)
        stack.addArrangedSubview(UIView())
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var scoreStack: UIStackView = {
           let stack = UIStackView()
           stack.axis = .vertical
           stack.spacing = 10
           stack.alignment = .center
           stack.addArrangedSubview(selectedLabel)
           stack.addArrangedSubview(scoreResultStack)
           stack.translatesAutoresizingMaskIntoConstraints = false
           return stack
       }()

       lazy var mainLabelStack: UIStackView = {
           let stack = UIStackView()
           stack.axis = .vertical
           stack.spacing = 40
           stack.alignment = .center
           stack.addArrangedSubview(scoreStack)
           stack.addArrangedSubview(scoreDescription)
           stack.translatesAutoresizingMaskIntoConstraints = false
           return stack
       }()
    
    private func createTextLabel(labelText: LabelStrings,color: UIColor = .white,labelFontSize: CGFloat) -> UILabel {
        let label = UILabel()
        label.setLabelFont(labelFontSize)
        label.text = labelText.rawValue
        label.textColor = color
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }
}

enum LabelStrings: String {
    case empty = ""
    case zero = "0"
    case selected = "Выберете дверь"
    case record = "Рекорд:"
    case correct = "Верно!"
    case inCorrect = "Неверно!"
    case score = "Счет:"
    
    
    static func getCurrentResultText(score: Int) -> String {
        switch score {
        case 0:
            return ""
        case 1:
            return "Начало положено!"
        case 2:
            return "Это только разогрев!"
        case 3:
            return "Повезло!"
        case 4:
            return "Поймал волну!"
        case 5:
            return "Идешь на рекорд!"
        case 6:
            return "Ощущаешь силу!"
        case 7:
            return "Это невозможно!"
        case 8:
            return "Ты уже почти легенда!"
        case 9:
            return "Это почти мировой рекорд!"
        default:
            return ""
        }
    }
}

