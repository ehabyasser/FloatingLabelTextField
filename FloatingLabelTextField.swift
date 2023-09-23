//
//  FloatingLabelTextField.swift
//  TagsViewExample
//
//  Created by Ihab yasser on 22/09/2023.
//

import Foundation
import UIKit

class FloatingLabelTextField: UITextField {
    
    // MARK: - Properties
    
    let floatingLabel = UILabel()
    
    @IBInspectable var floatingLabelColor: UIColor = UIColor.blue {
        didSet {
            floatingLabel.textColor = floatingLabelColor
        }
    }
    
    @IBInspectable var floatingLabelActiveColor: UIColor = UIColor.blue {
        didSet {
            updateFloatingLabelColor()
        }
    }
    
    // MARK: - Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        floatingLabel.alpha = 0.0
        floatingLabel.font = UIFont.systemFont(ofSize: 12)
        floatingLabel.textColor = floatingLabelColor
        floatingLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(floatingLabel)
        
        NSLayoutConstraint.activate([
            floatingLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            floatingLabel.topAnchor.constraint(equalTo: topAnchor),
            floatingLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
        
        updateFloatingLabelPosition()
    }
    
    // MARK: - UITextField Delegate
    
    @objc private func textFieldDidBeginEditing() {
        updateFloatingLabelColor()
    }
    
    @objc private func textFieldDidEndEditing() {
        updateFloatingLabelColor()
    }
    
    // MARK: - Private Helpers
    
    private func updateFloatingLabelColor() {
        let color = isEditing ? floatingLabelActiveColor : floatingLabelColor
        floatingLabel.textColor = color
    }
    
    private func updateFloatingLabelPosition() {
        if let text = self.text, !text.isEmpty {
            UIView.animate(withDuration: 0.2) {
                self.floatingLabel.alpha = 1.0
                self.floatingLabel.transform = CGAffineTransform(translationX: 0, y: -self.floatingLabel.frame.height)
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.floatingLabel.alpha = 0.0
                self.floatingLabel.transform = .identity
            }
        }
    }
    
    // MARK: - Text Field Overrides
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 0, dy: 10)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 0, dy: 10)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateFloatingLabelPosition()
    }
}
