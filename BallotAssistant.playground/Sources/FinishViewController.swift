import Foundation
import UIKit

public final class FinishViewController: UIViewController, UITextViewDelegate {
  
  let titleLabel = UILabel()
  let bodyText = UITextView()
  let imageCreditLabel = UILabel()
  let button = UIButton(type: .roundedRect)
  
  public override func loadView() {
    super.loadView()
    let view = UIView()
    
    let backgroundImage = UIImageView(image: UIImage(named: "welcomeBackground.jpg"))
    backgroundImage.contentMode = .scaleAspectFill
    view.insertSubview(backgroundImage, at: 0)
    
    backgroundImage.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
      backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
    
    view.addSubview(titleLabel)
    titleLabel.text = "Finished"
    titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
    titleLabel.textColor = .darkGray
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32)
    ])
    
    
    imageCreditLabel.text = "Photo by tom coe on Unsplash"
    imageCreditLabel.textColor = .darkGray
    imageCreditLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
    view.addSubview(imageCreditLabel)
    
    imageCreditLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      imageCreditLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
      imageCreditLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
    ])
    
    
    button.setTitle("NEW BALLOT", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    button.backgroundColor = Colors.purple
    button.layer.cornerRadius = 24
    button.addTarget(self, action: #selector(nextPage(_:)), for: .touchUpInside)
    view.addSubview(button)
    
    // Configure constraints
    button.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -48),
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.667),
      button.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.075)
    ])
    
    bodyText.attributedText = NSAttributedString(string: "You're all set, thanks for voting!\n\nIf you would like to try again,\ntap the button below.")
    bodyText.textColor = Colors.darkGrey
    bodyText.backgroundColor = .clear
    bodyText.delegate = self
    bodyText.isEditable = false
    bodyText.isScrollEnabled = false
    bodyText.font = UIFont.systemFont(ofSize: 15)
    view.addSubview(bodyText)
    
    bodyText.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      bodyText.topAnchor.constraint(equalTo: button.topAnchor, constant: -128),
      bodyText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
      bodyText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
    ])
    
    self.view = view
  }
  
  @objc func nextPage(_ sender: UIButton) {
    let nextViewController = WelcomeViewController()
    nextViewController.modalPresentationStyle = .fullScreen
    self.show(nextViewController, sender: self)
  }
}
