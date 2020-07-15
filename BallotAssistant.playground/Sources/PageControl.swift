import Foundation
import UIKit
import PlaygroundSupport

public func showWelcomeScreen() {
  PlaygroundPage.current.liveView = WelcomeViewController()
  PlaygroundPage.current.needsIndefiniteExecution = true
}
