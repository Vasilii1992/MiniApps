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
    
    // Контейнер для мини-приложения
    var appContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Конструктор ячейки
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
        // Удаляем все под-VC из контейнера
        for subview in appContainerView.subviews {
            subview.removeFromSuperview()
        }
    }
    
    // Метод конфигурации для установки данных ячейки
    func configure(with appViewController: UIViewController, parentViewController: UIViewController) {

        // Удаляем предыдущие контроллеры из родителя, если они были
        for childVC in parentViewController.children {
            if childVC.view.isDescendant(of: appContainerView) {
                childVC.willMove(toParent: nil)
                childVC.view.removeFromSuperview()
                childVC.removeFromParent()
            }
        }
        
        // Добавляем mini-app контроллер в контейнер
        parentViewController.addChild(appViewController)
        appViewController.view.frame = appContainerView.bounds
        appContainerView.addSubview(appViewController.view)
        appViewController.didMove(toParent: parentViewController)
        
    }

    // Настройка автолейаутов
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
