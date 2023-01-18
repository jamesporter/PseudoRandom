import GameplayKit

public class PseudoRandom {
  private let source: GKMersenneTwisterRandomSource
  
  public init(seed: UInt64 = 0) {
    source = GKMersenneTwisterRandomSource(seed: seed)
  }
  
  public var seed: UInt64 {
    get {
      source.seed
    }
    set {
      source.seed = newValue
    }
  }
  
  public func random() -> Double {
    Double(source.nextUniform())
  }
  
  public func randomInt() -> Int {
    source.nextInt()
  }
  
  public func randomInt(max: Int) -> Int {
    source.nextInt(upperBound: max)
  }
  
  public func randomInt(min: Int, max: Int) -> Int {
    min + randomInt(max: max - min)
  }
  
  public func randomBool() -> Bool {
    source.nextBool()
  }
  
  public func uniformGridPoint(minX: Int, maxX: Int, minY: Int, maxY: Int) -> (Int, Int) {
    return (
      randomInt(min: minX, max: maxX),
      randomInt(min: minY, max: maxY)
    )
  }
  
  /**
   +/- 1
   */
  public func randomPolarity() -> Int {
    random() > 0.5 ? 1 : -1
  }
  
  // TODO consider making below 2 safe in some way
  public func sample<T>(_ from: Array<T>) -> T {
    from[randomInt(max: from.count - 1)]
  }

  public func samples<T>(n: Int, from: Array<T>) -> Array<T> {
    var res: [T] = []
    //    TODO this maybe not expected, consider how to make safe
    if n < 1 {
      return res
    }
    
    for _ in 0..<n {
      res.append(sample(from))
    }
    return res
  }
  
  public func shuffled<T>(items: Array<T>) -> Array<T> {
    var array = items
    var currentIndex = items.count
    var temporaryValue: T
    var randomIndex = 0
    
    while 0 != currentIndex {
      randomIndex = randomInt(max: currentIndex)
      currentIndex -= 1
      
      temporaryValue = array[currentIndex]
      array[currentIndex] = array[randomIndex]
      array[randomIndex] = temporaryValue
    }
    
    return array
  }
  
  public func gaussian(mean: Double = 0, sd: Double = 1) -> Double {
    let a = random()
    let b = random()
    let n = sqrt(-2.0 * log(a)) * cos(2.0 * Double.pi * b)
    return mean + n * sd
  }
  
  public func poisson(lambda: Int) -> Int {
    let limit = exp(-Double(lambda))
    var prod = random()
    var n = 0
    while (prod >= limit) {
      n += 1
      prod *= random()
    }
    return n
  }
}
