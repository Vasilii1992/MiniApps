
import UIKit

extension UILabel {
    func setLabelFont(_ size: CGFloat = 20) {
        self.font = UIFont(name: "Minecraft", size: size)
        self.numberOfLines = 0
    }
}
