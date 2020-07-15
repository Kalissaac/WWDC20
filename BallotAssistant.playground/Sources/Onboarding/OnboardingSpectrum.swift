import Foundation
import UIKit

public final class OnboardingSpectrumViewController: OnboardingViewController {

  let liberalView = UIView()
  var liberalViewWidthConstraint: NSLayoutConstraint!
  let conservativeView = UIView()
  let slider = UISlider()

  public override func loadView() {
    super.loadView()
    
    self.headerLabel.text = "How would you classify yourself politically?"
    self.footerLabel.text = "Move slider to indicate your position!"
    self.nextButton.addTarget(self, action: #selector(nextPage(_:)), for: .touchUpInside)

    liberalView.backgroundColor = Colors.blue
    conservativeView.backgroundColor = Colors.red
    self.contentView.addSubview(liberalView)
    self.contentView.addSubview(conservativeView)

    liberalView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      liberalView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
      liberalView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
      liberalView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
      ])

    conservativeView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      conservativeView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
      conservativeView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
      conservativeView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
      ])

    conservativeView.leadingAnchor.constraint(equalTo: liberalView.trailingAnchor).isActive = true
    liberalViewWidthConstraint = liberalView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.5)
    liberalViewWidthConstraint.isActive = true


    let liberalIcon = UIImageView(image: Icons.liberal)
    let conservativeIcon = UIImageView(image: Icons.conservative)
    liberalIcon.contentMode = .scaleAspectFit
    conservativeIcon.contentMode = .scaleAspectFit

    liberalView.addSubview(liberalIcon)
    conservativeView.addSubview(conservativeIcon)

    liberalIcon.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      liberalIcon.centerXAnchor.constraint(equalTo: liberalView.centerXAnchor),
      liberalIcon.centerYAnchor.constraint(equalTo: liberalView.centerYAnchor),
      liberalIcon.widthAnchor.constraint(equalTo: liberalView.widthAnchor, multiplier: 0.5)
    ])

    conservativeIcon.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      conservativeIcon.centerXAnchor.constraint(equalTo: conservativeView.centerXAnchor),
      conservativeIcon.centerYAnchor.constraint(equalTo: conservativeView.centerYAnchor),
      conservativeIcon.widthAnchor.constraint(equalTo: conservativeView.widthAnchor, multiplier: 0.5)
    ])


    slider.value = 0.5
    slider.minimumTrackTintColor = UIColor(white: 1, alpha: 0)
    slider.maximumTrackTintColor = UIColor(white: 1, alpha: 0)
    self.contentView.addSubview(slider)

    slider.translatesAutoresizingMaskIntoConstraints = false
    slider.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
    slider.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
    slider.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true

    slider.addTarget(self, action: #selector(adjustSpectrum(_:)), for: .valueChanged)
  }

  @objc func nextPage(_ sender: UIButton) {
    var userProfile = self.userProfile
    
    let rawPercentage = Int(slider.value * 100)
    userProfile.append([rawPercentage]) // Add data collected in this view controller
    
    let nextViewController = OnboardingDecisionsViewController()
    nextViewController.modalPresentationStyle = .fullScreen
    nextViewController.userProfile = userProfile
    self.show(nextViewController, sender: self)
  }

  @objc func adjustSpectrum(_ sender: UISlider) {
    let sliderValue = CGFloat.init(sender.value)
    liberalViewWidthConstraint.isActive = false
    liberalViewWidthConstraint = liberalView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: sliderValue)
    liberalViewWidthConstraint.isActive = true
    self.nextButton.isHidden = false
    let rawPercentage = Int(sliderValue * 100)
    if rawPercentage == 50 {
      self.footerLabel.text = "50% Liberal and 50% Conservative"
    } else if rawPercentage > 50 {
      self.footerLabel.text = "\(rawPercentage)% Liberal"
    } else {
      self.footerLabel.text = "\(100-rawPercentage)% Conservative"
    }
  }
}
