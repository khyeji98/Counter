//
//  CounterViewController.swift
//  Counter
//
//  Created by 김혜지 on 1/13/24.
//

import UIKit

class CounterViewController: UIViewController {
    // TODO: frame을 .zero로 했을 때와 self.view.frame으로 했을 때 비교
    private lazy var counterView: CounterView = CounterView(frame: self.view.frame, labelText: self.counter.count.description)
    
    private let counter: Counter = Counter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubViews()
    }
    
    private func addSubViews() {
        self.view.backgroundColor = .white
        
        self.counterView.delegate = self
        self.view.addSubview(counterView)
        
        NSLayoutConstraint.activate([
            counterView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            counterView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}

extension CounterViewController: CounterManager {
    func increase() {
        self.counter.increase()
        self.counterView.updateLabel(text: self.counter.count.description)
    }
    
    func decrease() {
        self.counter.decrease()
        self.counterView.updateLabel(text: self.counter.count.description)
    }
}
