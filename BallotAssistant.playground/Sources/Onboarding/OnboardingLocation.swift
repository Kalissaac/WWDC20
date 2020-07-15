import Foundation
import UIKit

public final class OnboardingLocationViewController: OnboardingViewController {
  
  var statePickerData: [String] = ["Select one"]
  var countyPickerData: [String] = ["Select one"]
  var cityPickerData: [String] = ["Select one"]
  
  let statePicker = UIPickerView()
  let countyPicker = UIPickerView()
  let cityPicker = UIPickerView()
  
  var statePickerCurrentSelection = 0
  var countyPickerCurrentSelection = 0
  var cityPickerCurrentSelection = 0
  
  public override func loadView() {
    super.loadView()
    self.headerLabel.text = "Let's find your district"
    self.footerLabel.text = "Select your location to continue."
    self.nextButton.addTarget(self, action: #selector(nextPage(_:)), for: .touchUpInside)
    
    statePicker.tag = 1
    statePicker.dataSource = self
    statePicker.delegate = self
    self.contentView.addSubview(statePicker)
    
    countyPicker.tag = 2
    countyPicker.dataSource = self
    countyPicker.delegate = self
    self.contentView.addSubview(countyPicker)
    
    cityPicker.tag = 3
    cityPicker.dataSource = self
    cityPicker.delegate = self
    self.contentView.addSubview(cityPicker)
    
    statePicker.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      statePicker.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
      statePicker.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
      statePicker.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 1/3)
    ])
    
    countyPicker.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      countyPicker.topAnchor.constraint(equalTo: statePicker.bottomAnchor),
      countyPicker.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
      countyPicker.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 1/3)
    ])
    
    cityPicker.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      cityPicker.topAnchor.constraint(equalTo: countyPicker.bottomAnchor),
      cityPicker.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
      cityPicker.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 1/3)
    ])
    
    for state in State.allCases {
      statePickerData.append(state.description)
    }
    for county in County.allCases {
      countyPickerData.append(county.description)
    }
    for city in City.allCases {
      cityPickerData.append(city.description)
    }
  }
  @objc func nextPage(_ sender: UIButton) {
    var userProfile = self.userProfile
    
    userProfile.append([statePickerCurrentSelection, countyPickerCurrentSelection, cityPickerCurrentSelection]) // Add data collected in this view controller
    
    
    let nextViewController = OnboardingGenerationViewController()
    nextViewController.modalPresentationStyle = .fullScreen
    nextViewController.userProfile = userProfile
    self.show(nextViewController, sender: self)
  }
}

extension OnboardingLocationViewController: UIPickerViewDataSource, UIPickerViewDelegate {
  public func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    switch pickerView.tag {
      case 1:
        return statePickerData.count
      case 2:
        return countyPickerData.count
      case 3:
        return cityPickerData.count
      default:
        return 1
    }
  }
  
  public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    switch pickerView.tag {
      case 1:
        return statePickerData[row]
      case 2:
        return countyPickerData[row]
      case 3:
        return cityPickerData[row]
      default:
        return "Select one"
    }
  }
  
  public func pickerView(_ pickerView: UIPickerView, didSelectRow: Int, inComponent: Int) {
    switch pickerView.tag {
      case 1:
        statePickerCurrentSelection = didSelectRow
      case 2:
        countyPickerCurrentSelection = didSelectRow
      case 3:
        cityPickerCurrentSelection = didSelectRow
      default: break
    }
    if didSelectRow == 0 {
      self.footerLabel.text = "Select your location to continue."
      self.nextButton.isHidden = true
    } else if statePickerCurrentSelection != 0 && countyPickerCurrentSelection != 0 && cityPickerCurrentSelection != 0 {
      self.footerLabel.text = ""
      self.nextButton.isHidden = false
    }
  }
}
