//
//  SlideToControl.swift
//  TechAlchemyProj
//
//  Created by indianic
//  Copyright © 2018 indianic. All rights reserved.
//

import UIKit

@IBDesignable
class SlideToControl: UIControl {
  
  // MARK: Constants
  
  private struct Constants {
    static let thumbInset: CGFloat = 4
    static let thumbAnimationSpeed: Double = 0.2
    static let thumbCornerRadius: CGFloat = 15
  }

  // MARK: Outlets

  @IBOutlet private weak var rightTextLabel: UILabel!
  @IBOutlet private weak var leftTextLabel: UILabel!
  @IBOutlet private weak var viewTitleLabel: UILabel!
  @IBOutlet private weak var thumbView: UIView!
  @IBOutlet private weak var leadingThumbConstraint: NSLayoutConstraint!

  // MARK: variables

  private var endXPoint: CGFloat = 0
  private var locationInThumb: CGFloat = 0
  private var view: UIView?
  private var isAnimaionEnabled: Bool = true
  weak var delegate: SlideToControlDelegate?
  
  // MARK: Initializers

  override init(frame: CGRect) {
    super.init(frame: frame)
    xibSetup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    xibSetup()
  }


  // MARK: Internal methods

  private func xibSetup() {
    view = loadViewFromNib()
    view?.frame = bounds
    view?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    view?.isUserInteractionEnabled = false
    thumbView.isUserInteractionEnabled = false
    layoutSubviews()
    guard let resultView = view else {  return  }
    addSubview(resultView)
  }

  private func loadViewFromNib() -> UIView {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: "SlideToControl", bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    return view
  }

  override func layoutSubviews() {
    guard let width = view?.frame.width else { return }
    thumbView.layer.cornerRadius = Constants.thumbCornerRadius
    thumbView.layer.masksToBounds = true
    view?.layer.cornerRadius = Constants.thumbCornerRadius
    view?.layer.masksToBounds = true
    endXPoint = width - Constants.thumbInset * 2 - thumbView.frame.width + 5
  }

  private func updateThumbPositionWith(value: CGFloat) {
    leadingThumbConstraint.constant = value
    layoutIfNeeded()
  }

  private func isTappedOnThumbWith(point: CGPoint) -> Bool {
    let x = thumbView.frame.origin.x
    let y = thumbView.frame.origin.y
    let widthX = thumbView.frame.width + thumbView.frame.origin.x
    let heightY = thumbView.frame.height + thumbView.frame.origin.y
    if point.x > x && point.x < widthX && point.y > y && point.y < heightY {
      return true
    } else {
      return false
    }
  }


  // MARK: override UIControl methods

  override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    super.beginTracking(touch, with: event)
    locationInThumb = touch.location(in: thumbView).x
    let location = touch.location(in: view)
    if isTappedOnThumbWith(point: location) {
      updateThumbPositionWith(value: location.x - locationInThumb)
      return true
    } else {
      return false
    }
  }

  override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    super.continueTracking(touch, with: event)
    let locationX = touch.location(in: view).x - locationInThumb
    let locationY = touch.location(in: view).y
    print("locatioX \(locationX)")
    print("locatioX \(locationY)")
    if locationX >= endXPoint {
      isAnimaionEnabled = false
      rightTextLabel.alpha = 0
      leftTextLabel.alpha = 1
      viewTitleLabel.text = "DONE"
      viewTitleLabel.textColor = UIColor.red
        thumbColor = UIColor.white
      updateThumbPositionWith(value: endXPoint)
      delegate?.sliderCameToEnd()
      endTracking(touch, with: event)
      return false
    } else if locationX < Constants.thumbInset{
      isAnimaionEnabled = false
      rightTextLabel.alpha = 1
      leftTextLabel.alpha = 0
      viewTitleLabel.text = "£6/Pack"
        thumbColor = UIColor.black
      viewTitleLabel.textColor = UIColor.white
      updateThumbPositionWith(value: Constants.thumbInset)
      endTracking(touch, with: event)
      return false
    } else if locationY < 0 || locationY > view!.bounds.height {
      isAnimaionEnabled = true
      endTracking(touch, with: event)
      return false
    }
    rightTextLabel.alpha = 1 - (locationX / endXPoint)
    leftTextLabel.alpha = 0 + (locationX / endXPoint)
    updateThumbPositionWith(value: locationX)
    if locationX <= 150{
        isAnimaionEnabled = false
        rightTextLabel.alpha = 1
        leftTextLabel.alpha = 0
        thumbColor = UIColor.black
        viewTitleLabel.text = "£6/Pack"
        viewTitleLabel.textColor = UIColor.white
        endTracking(touch, with: event)
    }
    print(locationX)
    return true
  }

  override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
    super.endTracking(touch, with: event)
    if isAnimaionEnabled {
      UIView.animate(withDuration: Constants.thumbAnimationSpeed) {
        self.leadingThumbConstraint.constant = Constants.thumbInset
        self.rightTextLabel.alpha = 1
        self.leftTextLabel.alpha = 0
        self.layoutIfNeeded()
      }
    }
    isAnimaionEnabled = true
  }
}

  // MARK: Inspectable

extension SlideToControl {
  @IBInspectable var thumbColor: UIColor? {
    set(color) {
      thumbView.backgroundColor = color
    }
    get {
      return thumbView.backgroundColor
    }
  }
  @IBInspectable var bgColor: UIColor? {
    set(color) {
      view?.backgroundColor = color
    }
    get {
      return view?.backgroundColor
    }
  }
//  @IBInspectable var labelColor: UIColor? {
//    set(color) {
//      textLabel.textColor = color
//    }
//    get {
//      return textLabel.textColor
//    }
//  }
//  @IBInspectable var labelText: String? {
//    set(text) {
//      textLabel.text = text
//    }
//    get {
//      return textLabel.text
//    }
//  }
//  @IBInspectable var labelFontSize: CGFloat {
//    set(size) {
//      textLabel.font = UIFont.systemFont(ofSize: size)
//    }
//    get {
//      return textLabel.font.pointSize
//    }
//  }
}

  // MARK: Delegate

protocol SlideToControlDelegate: class {
  func sliderCameToEnd()
}
