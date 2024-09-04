//
//  InteractiveAppCell.swift
//  MiniApps
//
//  Created by Василий Тихонов on 04.09.2024.
//

import UIKit

class InteractiveAppCell: UICollectionViewCell {
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
    
    private let appTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Открыть на весь экран", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Конструктор ячейки
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(containerView)
        containerView.addSubview(appTitleLabel)
        containerView.addSubview(actionButton)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        appTitleLabel.text = nil
    }
    
    // Метод конфигурации для установки данных ячейки
    func configure(with title: String) {
        appTitleLabel.text = title
    }
    
    // Настройка автолейаутов
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            appTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            appTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            appTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            actionButton.topAnchor.constraint(equalTo: appTitleLabel.bottomAnchor, constant: 20),
            actionButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            actionButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.7),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
