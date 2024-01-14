//
//  CounterView.swift
//  Counter
//
//  Created by 김혜지 on 1/13/24.
//

import UIKit

protocol CounterManager: AnyObject {
    func increase()
    func decrease()
}

final class CounterView: UIView {
    private let countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let minusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        return button
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 30
        return stackView
    }()
    
    // TODO: weak를 사용해야 하는 이유?
    weak var delegate: CounterManager?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubViews()
        self.addTargetAction()
    }
    
    // TODO: 이 이니셜라이저의 역할은?
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addSubViews()
        self.addTargetAction()
    }
    
    private func setCountLabelText(_ text: String) {
        self.countLabel.text = text
    }
    
    private func addSubViews() {
        let subViews = [minusButton, countLabel, plusButton]
        subViews.forEach { self.stackView.addArrangedSubview($0) }
        self.addSubview(self.stackView)
        
        NSLayoutConstraint.activate([
            self.stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    private func addTargetAction() {
        self.plusButton.addTarget(self, action: #selector(tapPlusButton), for: .touchUpInside)
        self.minusButton.addTarget(self, action: #selector(tapMinusButton), for: .touchUpInside)
    }
    
    @objc private func tapPlusButton() {
        self.delegate?.increase()
    }
    
    @objc private func tapMinusButton() {
        self.delegate?.decrease()
    }
    
    func updateLabel(text: String) {
        self.countLabel.text = text
    }
}
