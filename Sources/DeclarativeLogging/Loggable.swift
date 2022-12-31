import Foundation

@propertyWrapper
public struct Loggable<T> {
    public typealias Condition = (T) -> Bool
    
    private var value: T
    private let condition: Condition
    private var loggingCount: NSNumber?
    private let isContinuous: Bool
    
    public var wrappedValue: T {
        get {
            value
        } set {
            value = newValue
            
            switch (isContinuous, condition(newValue)) {
                case (false, false):
                    return
                case (true, _):
                    print("New value is '\(newValue)'. \(#file): \(#line)")
                case (_, true):
                    print("New value '\(newValue)' doesn't satisfy the condition. \(#file): \(#line)")
            }
            
            if let loggingCount = loggingCount {
                self.loggingCount = NSNumber(integerLiteral: loggingCount.intValue + 1)
            }
        }
    }
    
    public init(wrappedValue: T) {
        self.value = wrappedValue
        self.condition = { _ in true }
        self.isContinuous = true
    }
    
    public init(wrappedValue: T, when condition: @escaping Condition) {
        self.value = wrappedValue
        self.condition = condition
        self.isContinuous = false
    }
    
    public init(wrappedValue: T, when condition: @escaping Condition, loggingCount: inout NSNumber) {
        self.init(wrappedValue: wrappedValue, when: condition)
        self.loggingCount = loggingCount
    }
}
