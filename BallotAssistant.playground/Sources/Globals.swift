import Foundation
import UIKit

extension UIColor {
  convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
    self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
  }
}

public struct Colors {
  public static let blue = UIColor(r: 0, g: 168, b: 255)
  public static let red = UIColor(r: 232, g: 65, b: 24)
  public static let purple = UIColor(r: 140, g: 122, b: 230)
  public static let green = UIColor(r: 68, g: 189, b: 50)
  public static let backgroundGrey = UIColor(r: 245, g: 246, b: 250)
  public static let darkGrey = UIColor(r: 47, g: 54, b: 64)
}

public struct Icons {
  public static let liberal = UIImage(named: "democrat-solid-01")
  public static let conservative = UIImage(named: "republican-solid-01")
}

extension StringProtocol {
  var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
  var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}
