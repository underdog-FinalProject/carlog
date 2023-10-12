import UIKit

import SnapKit

class JoinupPageViewController: UIViewController {
    let joinupView = JoinupView()
    let carNumberView = CarNumberView()
    let carModelView = CarModelView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryColor
        setupUI()
    }

    func setupUI() {
        view.addSubview(joinupView) //첫번째 화면 뷰
        
        joinupView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        joinupView.joinInButton.addTarget(self, action: #selector(joinInButtonTapped), for: .touchUpInside)
        carNumberView.popButton.addTarget(self, action: #selector(carNumberViewPopButtonTapped), for: .touchUpInside)
        carNumberView.nextButton.addTarget(self, action: #selector(carNumberViewPopNextButtonTapped), for: .touchUpInside)
        carModelView.popButton.addTarget(self, action: #selector(carModelViewPopButtonTapped), for: .touchUpInside)
        carModelView.nextButton.addTarget(self, action: #selector(carModelViewNextButtonTapped), for: .touchUpInside)
    }

    @objc func joinInButtonTapped() {
        view.addSubview(carNumberView)
        joinupView.isHidden = true
        carNumberView.isHidden = false
        carNumberView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    } //회원가입 페이지 버튼

    @objc func carNumberViewPopButtonTapped() {
        joinupView.isHidden = false
        carNumberView.isHidden = true
    }
    @objc func carNumberViewPopNextButtonTapped() {
        view.addSubview(carModelView)
        carNumberView.isHidden = true
        carModelView.isHidden = false
        carModelView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    @objc func carModelViewPopButtonTapped(){
        carNumberView.isHidden = false
        carModelView.isHidden = true
    }
    @objc func carModelViewNextButtonTapped(){}
}
