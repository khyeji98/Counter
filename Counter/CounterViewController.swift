//
//  CounterViewController.swift
//  Counter
//
//  Created by 김혜지 on 1/13/24.
//

import Combine
import UIKit

class CounterViewController: UIViewController {
    // TODO: frame을 .zero로 했을 때와 self.view.frame으로 했을 때 비교
    private lazy var counterView: CounterView = CounterView(frame: self.view.frame)
    
    private let viewModel: CounterViewModel = CounterViewModel()
    
    // TODO: Combine 이해 필요
    private let input: PassthroughSubject<CounterViewModel.Input, Never> = .init()
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubViews()
        self.bind()
        self.setCountLabel()
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
    
    private func bind() {
        let output = viewModel.transform(input: input.eraseToAnyPublisher())
        
        output
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                switch event {
                case let .updateCountLabel(text):
                    self?.counterView.updateLabel(text: text)
                }
            }
            .store(in: &cancellables)
    }
    
    private func setCountLabel() {
        input.send(.getCount)
    }
}

extension CounterViewController: CounterManager {
    func increase() {
        input.send(.increase)
    }
    
    func decrease() {
        input.send(.decrease)
    }
}
