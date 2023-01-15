import XCTest
@testable import PseudoRandom

final class PseudoRandomTests: XCTestCase {
  func testIntegerGeneration() throws {
    
    var samples: [Int] = []
    let rng = PseudoRandom()
    
    for _ in 0..<10 {
      samples.append(rng.randomInt(max: 10))
    }
    
    XCTAssertEqual(samples, [9, 8, 1, 5, 1, 4, 5, 3, 7, 9])
    
    
    var samples2: [Int] = []
    for _ in 0..<1000 {
      samples2.append(rng.randomInt(min: 1, max: 10))
    }
    
    XCTAssertEqual(Double(samples2.reduce(0, +)) / 1000.0, 5.0, accuracy: 0.1)
  }
}
