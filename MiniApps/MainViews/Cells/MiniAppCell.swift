
import UIKit

final class MiniAppCell: UICollectionViewCell {
    static let identifier = "MiniAppCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let appImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 20
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        contentView.addSubview(appImage)
        addSubview(descriptionLabel)
        contentView.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.9411764741, blue: 0.9411764741, alpha: 1)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        appImage.image = nil
        descriptionLabel.text = nil
        
    }
    
    func configure(with title: String, image: String, description: String) {
        titleLabel.text = title
        appImage.image = UIImage(named: image)
        descriptionLabel.text = description
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            appImage.widthAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 0.85), 
            appImage.heightAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 0.85),
            appImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            appImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: appImage.trailingAnchor, constant: 20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: appImage.trailingAnchor, constant: 20),
            descriptionLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7)
        ])
    }
}
