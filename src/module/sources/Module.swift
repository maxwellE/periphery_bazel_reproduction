enum MySpecialEnum: String {
    case caseOne
    case caseTwo
}

public protocol MySpecialProtocol {
    func mySpecialFunction()
}

public extension MySpecialProtocol {
    func myExtensionFunction() {
        print("Hello from my protocol extension")
    }
}

public class MySpecialClass: MySpecialProtocol {
    public func mySpecialFunction() {
        print("Hello, world!")
        print(MySpecialEnum.caseOne)
    }

    public init() {}
}
