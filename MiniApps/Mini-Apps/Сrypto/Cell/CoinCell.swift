
import UIKit
import SDWebImage

final class CoinCell: UITableViewCell {
    static let identifire = "CoinCell"
    
    private(set) var coin: Coin!
    
    private let coinLogo: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "questionmark")
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let coinName: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22,weight: .semibold)
        label.text = "Error"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let coinPrice: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "$0.00"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with coin: Coin) {
        self.coin = coin
        coinName.text = coin.name
        coinPrice.text = String(format: "$%.2f", coin.pricingData.USD.price)
        self.coinLogo.sd_setImage(with: coin.logoURL)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coinName.text = nil
        coinLogo.image = nil
        coinPrice.text = nil
    }
    
    private func setupViews() {
        contentView.addSubview(coinLogo)
        contentView.addSubview(coinName)
        contentView.addSubview(coinPrice)
        
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            coinLogo.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            coinLogo.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            coinLogo.widthAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 0.75), //
            coinLogo.heightAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 0.75),
            
            coinName.leadingAnchor.constraint(equalTo: coinLogo.trailingAnchor,constant: 16),
            coinName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            coinName.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            
            coinPrice.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            coinPrice.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)

        ])
    }
}
