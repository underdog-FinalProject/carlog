import UIKit

import SnapKit

final class JoinupView: UIView {
    let duplicateComponents = DuplicateComponents()
    var isSecure = true
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
        
    let contentView: UIView = {
        let contentView = UIView()
//        contentView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
        return contentView
    }()
    
    lazy var emailLabel = makeLabel(text: "아이디", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)

    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.loginCustomTextField(placeholder: "아이디", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)))
        textField.rightView = checkEmailButton
        textField.delegate = self
        textField.rightViewMode = .always
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let closeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.closeKeyboard))
        toolbar.setItems([flexibleSpace, closeButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolbar
        return textField
    }()
    
    @objc func closeKeyboard(){
        emailTextField.resignFirstResponder()
        
    }
    
    lazy var checkEmailButton: UIButton = {
        var configuration = UIButton.Configuration.tinted()
        configuration.baseBackgroundColor = .white
        configuration.imagePadding = 10
        
        let button = UIButton(configuration: configuration)
        button.customButton(text: "중복확인", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .medium), titleColor: .black, backgroundColor: .clear)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
        return button
    }()
    
    lazy var emailAlertLabel = makeAlertLabel(text: "아이디는 필수 입력 정보입니다", textColor: .red)
    
    lazy var passwordLabel = makeLabel(text: "비밀번호", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.loginCustomTextField(placeholder: "비밀번호", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)))
        textField.isSecureTextEntry = isSecure
        textField.rightView = showPasswordButton
        textField.rightViewMode = .always
        textField.delegate = self
        return textField
    }()
    
    lazy var passwordAlertLabel = makeAlertLabel(text: "영대/소문자와 숫자, 특수문자를 조합하여 8글자 이내로 작성하세요", textColor: .red)

    lazy var confirmPasswordLabel = makeLabel(text: "비밀번호 재확인", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)
    
    lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.loginCustomTextField(placeholder: "비밀번호 재확인", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)))
        textField.isSecureTextEntry = isSecure
        textField.rightView = showConfirmPasswordButton
        textField.rightViewMode = .always
        textField.delegate = self
        return textField
    }()
    
    lazy var confirmPasswordAlertLabel = makeAlertLabel(text: "영대/소문자와 숫자, 특수문자를 조합하여 8글자 이내로 작성하세요", textColor: .red)
    
    lazy var smtpEmailLabel = makeLabel(text: "이메일 인증", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)
    
    lazy var smtpEmailTextField: UITextField = {
        let textField = UITextField()
        textField.loginCustomTextField(placeholder: "유효한 이메일을 입력", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)))
        textField.delegate = self
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    lazy var smtpButton = makeButton(text: "인증", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .bold), titleColor: .gray, backgroundColor: .lightGray)
  
    lazy var stmpStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [smtpEmailTextField, smtpButton])
        stackView.customStackView(spacing: Constants.horizontalMargin, axis: .horizontal, alignment: .fill)
        smtpEmailTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.75).isActive = true
        smtpButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.2).isActive = true
        return stackView
    }()
    
    lazy var smtpNumberTextField: UITextField = {
        let textField = UITextField()
        textField.loginCustomTextField(placeholder: "인증번호를 입력", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)))
        textField.keyboardType = .numberPad
        return textField
    }()

    lazy var smtpNumberButton: UIButton = makeButton(text: "확인", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .bold), titleColor: .gray, backgroundColor: .lightGray)
    
    lazy var smtpTimerLabel: UILabel = makeLabel(text: "3:00", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .center)
    
    lazy var smtpNumberStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [smtpNumberTextField, smtpNumberButton, smtpTimerLabel])
        stackView.customStackView(spacing: Constants.horizontalMargin, axis: .horizontal, alignment: .fill)
        smtpNumberTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.5).isActive = true
        smtpNumberButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.2).isActive = true
        return stackView
    }()
    
    lazy var allTextFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField, emailAlertLabel, passwordLabel, passwordTextField, passwordAlertLabel, confirmPasswordLabel, confirmPasswordTextField, confirmPasswordAlertLabel, smtpEmailLabel, stmpStackView, smtpNumberStackView])
        stackView.customStackView(spacing: Constants.verticalMargin, axis: .vertical, alignment: .fill)
        return stackView
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [joinInButton, popButton])
        stackView.customStackView(spacing: Constants.verticalMargin, axis: .vertical, alignment: .fill)
        return stackView
    }()
    
    lazy var spaceView: UIView = {
        let spaceView = UIView()
        spaceView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        spaceView.backgroundColor = .yellow
        return spaceView
    }()
    
    lazy var allStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [allTextFieldStackView, buttonStackView])
        stackView.customStackView(spacing: Constants.verticalMargin, axis: .vertical, alignment: .fill)
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    lazy var showPasswordButton: UIButton = makeToggleButton()
    lazy var showConfirmPasswordButton: UIButton = makeToggleButton()

    lazy var joinInButton = makeButton(text: "다 음", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua24, weight: .bold), titleColor: .gray, backgroundColor: .lightGray)
    lazy var popButton = makeButton(text: "취 소", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua24, weight: .bold), titleColor: .buttonSkyBlueColor, backgroundColor: .mainNavyColor)
   
    private func setupUI() {
        let safeArea = safeAreaLayoutGuide
//        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: self.contentView.frame.size.height)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(allStackView)
        //contentView.addSubview(buttonStackView)
        
        smtpTimerLabel.isHidden = true
        showPasswordButton.addTarget(self, action: #selector(togglePasswordVisibilityTapped), for: .touchUpInside)
        showConfirmPasswordButton.addTarget(self, action: #selector(toggleConfirmVisibilityTapped), for: .touchUpInside)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea) // 832
        }
                    
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.height.equalTo(scrollView)
            make.trailing.equalTo(safeArea.snp.trailing)
        }
   
//        allTextFieldStackView.snp.makeConstraints { make in
//            make.top.equalTo(contentView).offset(Constants.verticalMargin)
//            make.leading.equalTo(contentView).offset(Constants.horizontalMargin)
//            make.trailing.equalTo(contentView).offset(-Constants.horizontalMargin)
//            //make.height.equalTo(300)
//        }
    
        allStackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView)
            make.leading.equalTo(contentView).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contentView).offset(-Constants.horizontalMargin)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension JoinupView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            confirmPasswordTextField.becomeFirstResponder()
        } else if textField == confirmPasswordTextField {
            smtpEmailTextField.becomeFirstResponder()
        } else if textField == smtpEmailTextField {
            smtpNumberTextField.becomeFirstResponder()
        }
        return true
    }
}

extension JoinupView {
    private func makeLabel(text: String, textColor: UIColor, font: UIFont, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.customLabel(text: text, textColor: textColor, font: font, alignment: alignment)
        return label
    }

    private func makeAlertLabel(text: String, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.customLabel(text: text, textColor: textColor, font: UIFont(name: "Jua", size: 12) ?? UIFont(), alignment: .left)
        label.isHidden = true
        return label
    }
    
    private func makeButton(text: String, font: UIFont, titleColor: UIColor, backgroundColor: UIColor) -> UIButton {
        let button = UIButton()
        button.customButton(text: text, font: font, titleColor: titleColor, backgroundColor: backgroundColor)
        button.layer.cornerRadius = Constants.cornerRadius
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }

    private func makeToggleButton() -> UIButton {
        var configuration = UIButton.Configuration.tinted()
        configuration.image = UIImage(named: "invisible")
        configuration.imagePlacement = .trailing
        configuration.baseBackgroundColor = .white
        configuration.imagePadding = 10

        let button = UIButton(configuration: configuration)
        button.setImage(UIImage(named: "invisible"), for: .normal)
        button.tintColor = .black
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        return button
    }
    
    private func toggleVisibility(button: UIButton, textField: UITextField) {
        let imageName = isSecure ? "eye" : "invisible"
        button.setImage(UIImage(named: imageName), for: .normal)
        isSecure.toggle()
        textField.isSecureTextEntry = isSecure
    }
    
    @objc func togglePasswordVisibilityTapped() {
        toggleVisibility(button: showPasswordButton, textField: passwordTextField)
    }

    @objc func toggleConfirmVisibilityTapped() {
        toggleVisibility(button: showConfirmPasswordButton, textField: confirmPasswordTextField)
    }
}
