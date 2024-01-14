//
//  CounterModel.swift
//  Counter
//
//  Created by 김혜지 on 1/13/24.
//

// TODO: class로 정의한 이유? - struct의 mutating 함수 정의와 class 정의 차이
final class Counter {
    private(set) var count: Int
    
    init(count: Int = 0) {
        self.count = count
    }
    
    func increase() {
        self.count += 1
    }
    
    func decrease() {
        self.count -= 1
    }
}
