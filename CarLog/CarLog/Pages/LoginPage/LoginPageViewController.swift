import UIKit

import AuthenticationServices
import FirebaseAuth
import SnapKit

class LoginPageViewController: UIViewController {
    let loginView = LoginView()
    var isChecked = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundCoustomColor
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        addTargets()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        loginView.endEditing(true)
    }

    func setupUI() {
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        loginView.passwordTextField.isSecureTextEntry = true
    }

    func addTargets() {
        loginView.emailTextField.addAction(UIAction(handler: { _ in self.textFieldDidChange() }), for: .editingChanged)
        loginView.passwordTextField.addAction(UIAction(handler: { _ in self.textFieldDidChange() }), for: .editingChanged)
        loginView.loginButton.firstButton.addAction(UIAction(handler: { _ in
            guard let email = self.loginView.emailTextField.text, let password = self.loginView.passwordTextField.text else { return }

            LoginService.loginService.loginUser(email: email, password: password) { isSuccess, error in
                if isSuccess {
                    let tabBarController = Util.mainTabBarController()
                    if let windowScene = UIApplication.shared.connectedScenes
                        .first(where: { $0 is UIWindowScene }) as? UIWindowScene,
                        let window = windowScene.windows.first
                    {
                        window.rootViewController = tabBarController
                    }
                } else {
                    if error != nil {
                        self.showAlert(message: "이메일과 비밀번호를 다시 입력해주세요", completion: {})
                    } else {
                        // 에러가 Firebase에서 반환되지 않은 경우 에러 메시지 표시
                        self.showAlert(message: "서버가 연결되지 않았습니다.", completion: {})
                    }
                }
            }
        }), for: .touchUpInside)
        loginView.loginButton.secondButton.isHidden = true
        loginView.joinupButton.addAction(UIAction(handler: { _ in
            let joinPageViewController = JoinupPageViewController()
            joinPageViewController.modalPresentationStyle = .fullScreen
            self.present(joinPageViewController, animated: true, completion: nil)
        }), for: .touchUpInside)
        loginView.findIdPassword.addAction(UIAction(handler: { _ in
            let findIDPasswordViewController = FindIDPassWordViewController()
            findIDPasswordViewController.modalPresentationStyle = .fullScreen
            self.present(findIDPasswordViewController, animated: true, completion: nil)
        }), for: .touchUpInside)
    }

    func textFieldDidChange() {
        let isEmailValid = loginView.emailTextField.text?.isValidEmail() ?? false
        let isPasswordValid = loginView.passwordTextField.text?.isValidPassword() ?? false

        UIView.animate(withDuration: 0.3) {
            if isEmailValid && isPasswordValid {
                self.loginView.loginButton.firstButton.isEnabled = true
                self.loginView.loginButton.firstButton.setTitleColor(.buttonSkyBlueColor, for: .normal)
                self.loginView.loginButton.firstButton.backgroundColor = .mainNavyColor
            }
        }
    }
}
