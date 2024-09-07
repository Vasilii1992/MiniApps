import UIKit

final class InteractiveAppCell: UICollectionViewCell {
    static let identifier = "InteractiveAppCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var appContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(containerView)
        containerView.addSubview(appContainerView)
        setupConstraints()
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        for subview in appContainerView.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func configure(with appViewController: UIViewController, parentViewController: UIViewController) {

        for childVC in parentViewController.children {
            if childVC.view.isDescendant(of: appContainerView) {
                childVC.willMove(toParent: nil)
                childVC.view.removeFromSuperview()
                childVC.removeFromParent()
            }
        }
        
        parentViewController.addChild(appViewController)
        appViewController.view.frame = appContainerView.bounds
        appContainerView.addSubview(appViewController.view)
        appViewController.didMove(toParent: parentViewController)
        
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            appContainerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            appContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            appContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            appContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ])
            containerView.layoutIfNeeded()
    }
}
