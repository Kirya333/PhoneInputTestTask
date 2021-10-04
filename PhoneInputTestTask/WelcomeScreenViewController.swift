//
//  WelcomeScreenViewController.swift
//  PhoneInputTestTask
//
//  Created by Кирилл Тарасов on 29.09.2021.
//

import UIKit
import SnapKit
import InputMask

class WelcomeScreenViewController: UIViewController, MaskedTextFieldDelegateListener, UITextFieldDelegate {
    
    let scrollView = UIScrollView()
    let backButton = UIButton(type: .system)
    let mainImage = UIImage(named: "imageMain")
    lazy var mainImageView = UIImageView(image: mainImage)
    var circleView = UIView()
    let phoneLabel = UILabel()
    let descriptionLabel = UILabel()
    let phoneTextField = UITextField()
    let getCodeButton = UIButton(type: .system)
    
    var listener: MaskedTextFieldDelegate? = MaskedTextFieldDelegate(primaryFormat: " +7 [000]-[000]-[00]-[00]")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listener!.affinityCalculationStrategy = .prefix
        listener!.affineFormats = [
            " +7 ([000]) [000] [00] [00]"
        ]
        phoneTextField.delegate = listener
        listener!.listener = self
        
        setupSubviews()
        applyConstraints()
        getCodeButton.isUserInteractionEnabled = false
        getCodeButton.alpha = 0.5
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        hideKeyboardGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(hideKeyboardGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    open func textField(
        _ textField: UITextField,
        didFillMandatoryCharacters complete: Bool,
        didExtractValue value: String
    ) {
        print(value)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

            let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)

            if !text.isEmpty{
                getCodeButton.isUserInteractionEnabled = true
                getCodeButton.alpha = 1.0
                getCodeButton.layer.backgroundColor = UIColor(red: 0.039, green: 0.824, blue: 0.424, alpha: 1).cgColor
                getCodeButton.setTitleColor(.black, for: .normal)
            } else {
                getCodeButton.isUserInteractionEnabled = false
                getCodeButton.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5).cgColor
                
                getCodeButton.setTitleColor(#colorLiteral(red: 0.572997272, green: 0.5371989012, blue: 0.6040434837, alpha: 1), for: .normal)
                
            }
            return true
        }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func hideKeyboard(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    private func setupSubviews() {
        
        // MARK: - Scrollview
        scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundViewImage")!)
        view.addSubview(scrollView)
        
        // MARK: - Button
        backButton.layer.backgroundColor = UIColor(red: 0.102, green: 0.067, blue: 0.204, alpha: 1).cgColor
        view.addSubview(backButton)
        backButton.setTitleColor(.white, for: .normal)
        backButton.setTitle("Back", for: .normal)
        backButton.layer.cornerRadius = 20
        backButton.clipsToBounds = true
        
        // MARK: - Image
//        mainImageView.backgroundColor = UIColor.white
//        view.addSubview(mainImageView)
//        mainImageView.layer.cornerRadius = 88
//        mainImageView.clipsToBounds = true
        
        // MARK: - View with image
        circleView.addSubview(mainImageView)
        circleView.backgroundColor = .white
        circleView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        view.addSubview(circleView)
        circleView.layer.cornerRadius = 170
        circleView.clipsToBounds = true
        
        // MARK: - PhoneLabel
        view.addSubview(phoneLabel)
        phoneLabel.text = "Номер телефона"
        phoneLabel.numberOfLines = 1
        phoneLabel.font = UIFont.boldSystemFont(ofSize: 10)
        phoneLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        phoneLabel.textColor = UIColor(red: 0.039, green: 0.824, blue: 0.424, alpha: 1)
        
        // MARK: - Description label
        view.addSubview(descriptionLabel)
        descriptionLabel.text = "Мы проверим, есть ли у вас карта клуба X-Fit"
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 18)
        descriptionLabel.textColor = .white
        
        // MARK: - Phone textField
        phoneTextField.backgroundColor = .white
        phoneTextField.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        view.addSubview(phoneTextField)
        
        phoneTextField.placeholder = " + 7"
        phoneTextField.font = UIFont.systemFont(ofSize: 18)
        phoneTextField.keyboardType = .phonePad
        phoneTextField.layer.cornerRadius = 12
        
        func textField(
            _ textField: UITextField,
            didFillMandatoryCharacters complete: Bool,
            didExtactValue value: String
        ) {
            print(value)
        }
        
        // MARK: - Button get code
        getCodeButton.backgroundColor = UIColor.clear
        view.addSubview(getCodeButton)
        
        getCodeButton.layer.cornerRadius = 12
        getCodeButton.layer.borderWidth = 1
        phoneLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        getCodeButton.setTitleColor(#colorLiteral(red: 0.572997272, green: 0.5371989012, blue: 0.6040434837, alpha: 1), for: .normal)
        getCodeButton.setTitle("Получить код", for: .normal)
        
        getCodeButton.addTarget(self,
                                action: #selector(buttonTapped),
                                for: .touchUpInside
        )
    }
    
    private func applyConstraints() {
        
        // MARK: - Scrollview
        scrollView.snp.makeConstraints { maker in
            maker.top.leading.trailing.equalToSuperview().inset(0)
            maker.width.equalTo(UIScreen.main.bounds.width)
            maker.height.equalTo(1940)
            
            // MARK: - Button
            backButton.snp.makeConstraints { maker in
                maker.top.equalToSuperview().inset(58)
                maker.leading.equalTo(16)
                maker.width.equalTo(50)
                maker.height.equalTo(42)
            }
            
            // MARK: - Image
            mainImageView.snp.makeConstraints { maker in
                maker.width.equalTo(215)
                maker.height.equalTo(203)
                maker.leading.equalTo(circleView).offset(10)
                maker.bottom.equalTo(circleView).inset(40)
            }
            
            // MARK: - View with image
            circleView.snp.makeConstraints { maker in
                maker.trailing.equalToSuperview().offset(120)
                maker.top.equalToSuperview().offset(-75)
                maker.width.equalTo(347.44)
                maker.height.equalTo(351.74)
            }
            
            // MARK: - PhoneLabel
            phoneLabel.snp.makeConstraints { maker in
                maker.trailing.leading.equalToSuperview().inset(16)
                maker.top.equalToSuperview().inset(529)
            }
            
            // MARK: - Description label
            descriptionLabel.snp.makeConstraints { maker in
                maker.leading.trailing.equalToSuperview().inset(16)
                maker.top.equalToSuperview().inset(577)
            }
            
            // MARK: - Phone textField
            phoneTextField.snp.makeConstraints { maker in
                maker.width.equalTo(343)
                maker.height.equalTo(58)
                maker.leading.trailing.equalToSuperview().inset(16)
                maker.top.equalToSuperview().inset(674)
            }
            
            // MARK: - Button get code
            getCodeButton.snp.makeConstraints { maker in
                maker.leading.trailing.equalToSuperview().inset(16)
                maker.top.equalToSuperview().inset(750)
                maker.width.equalTo(343)
                maker.height.equalTo(58)
            }
        }
    }
    
    @objc private func buttonTapped() {
        
    }
}
