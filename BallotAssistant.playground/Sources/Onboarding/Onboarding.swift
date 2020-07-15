import Foundation
import UIKit

public class OnboardingViewController: UIViewController {
  
  let headerView = UIView()
  public let headerLabel = UILabel()
  public let contentView = UIView()
  let footerView = UIView()
  public let footerLabel = UILabel()
  public let nextButton = UIButton(type: .roundedRect)
  public var userProfile = [[Any]]()
  
  public override func loadView() {
    super.loadView()
    let superView = UIView()
    superView.backgroundColor = Colors.backgroundGrey
    
    contentView.backgroundColor = .white
    contentView.layer.masksToBounds = true
    contentView.layer.cornerRadius = 12
    
    footerView.backgroundColor = Colors.purple
    footerView.layer.masksToBounds = true
    footerView.layer.cornerRadius = 12
    
    superView.addSubview(headerView)
    superView.addSubview(contentView)
    superView.addSubview(footerView)
    
    headerView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: superView.topAnchor, constant: 8),
      headerView.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 8),
      headerView.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -8),
      headerView.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: -8),
      headerView.heightAnchor.constraint(equalTo: superView.heightAnchor, multiplier: 0.10)
    ])
    
    contentView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
      contentView.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 8),
      contentView.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -8),
      contentView.bottomAnchor.constraint(equalTo: footerView.topAnchor, constant: -8)
    ])
    
    footerView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      footerView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8),
      footerView.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 8),
      footerView.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -8),
      footerView.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -8),
      footerView.heightAnchor.constraint(equalTo: superView.heightAnchor, multiplier: 0.15)
    ])
    
    headerLabel.text = "Title"
    headerLabel.numberOfLines = 2
    headerLabel.font = UIFont.boldSystemFont(ofSize: 24)
    headerView.addSubview(headerLabel)
    
    headerLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 12),
      headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
      headerLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -12)
    ])
    
    
    footerLabel.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
    footerLabel.textColor = .white
    footerLabel.numberOfLines = 2
    footerView.addSubview(footerLabel)
    
    footerLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      footerLabel.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 12),
      footerLabel.centerYAnchor.constraint(equalTo: footerView.centerYAnchor)
    ])
    
    
    nextButton.frame = CGRect(x: 150, y: 300, width: 200, height: 20)
    nextButton.setTitle("Continue", for: .normal)
    nextButton.setTitleColor(.darkGray, for: .normal)
    nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    nextButton.backgroundColor = .white
    nextButton.layer.cornerRadius = 8
    nextButton.isHidden = true
    footerView.addSubview(nextButton)
    
    nextButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      footerLabel.trailingAnchor.constraint(equalTo: nextButton.leadingAnchor, constant: 12),
      nextButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -12),
      nextButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
      nextButton.widthAnchor.constraint(equalTo: footerView.widthAnchor, multiplier: 0.25)
    ])
    
    self.view = superView
  }
}
