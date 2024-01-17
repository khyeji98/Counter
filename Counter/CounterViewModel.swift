//
//  CounterViewModel.swift
//  Counter
//
//  Created by 김혜지 on 1/14/24.
//

import Combine

final class CounterViewModel {
    enum Input {
        case getCount
        case increase
        case decrease
    }
    
    enum Output {
        case updateCountLabel(String)
    }
    
    private let counter: Counter = Counter()
    
    // TODO: Combine 이해 필요
    private let output: PassthroughSubject<Output,Never> = .init()
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init() {}
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            switch event {
            case .getCount:
                self?.getCount()
            case .increase:
                self?.increase()
            case .decrease:
                self?.decrease()
            }
        }
        .store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    private func getCount() {
        output.send(.updateCountLabel(self.counter.count.description))
    }
    
    private func increase() {
        self.counter.increase()
        output.send(.updateCountLabel(self.counter.count.description))
    }
    
    private func decrease() {
        self.counter.decrease()
        output.send(.updateCountLabel(self.counter.count.description))
    }
}
