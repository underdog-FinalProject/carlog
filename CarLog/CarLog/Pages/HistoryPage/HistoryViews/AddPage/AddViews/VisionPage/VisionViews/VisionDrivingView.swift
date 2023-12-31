//
//  VisionDrivingView.swift
//  CarLog
//
//  Created by 김지훈 on 11/9/23.
//

import UIKit

class VisionDrivingView: UIView {

    lazy var visionDrivingStackView: UIStackView = {
        let visionDrivingStackView = UIStackView(arrangedSubviews: [visionInfoLabel, visionButtonTextFieldStackView])
        visionDrivingStackView.customStackView(spacing: 20, axis: .vertical, alignment: .center)
        visionDrivingStackView.backgroundColor = .white
        visionDrivingStackView.layer.cornerRadius = Constants.cornerRadius
        return visionDrivingStackView
    }()
    
    //안내 라벨
    lazy var visionInfoLabel: UILabel = {
        let visionInfoLabel = UILabel()
        visionInfoLabel.customLabel(text: "출발, 도착 주행거리를 선택해주세요.", textColor: .mainNavyColor, font: UIFont.spoqaHanSansNeo(size: Constants.fontSize16, weight: .medium), alignment: .center)
        return visionInfoLabel
    }()
    
    //MARK: - 버튼, 텍스트필드 스택뷰
    lazy var visionButtonTextFieldStackView: UIStackView = {
        let visionButtonTextFieldStackView = UIStackView(arrangedSubviews: [visionDepartDistanceStackView, visionArriveDistanceStackView])
        visionButtonTextFieldStackView.customStackView(spacing: Constants.verticalMargin, axis: .horizontal, alignment: .center)
        return visionButtonTextFieldStackView
    }()
    
    //MARK: - 왼쪽 출발 버튼, 텍스트필드 스택뷰
    lazy var visionDepartDistanceStackView: UIStackView = {
        let visionDepartDistanceStackView = UIStackView(arrangedSubviews: [departLabel, visionDepartImageButton, visionDepartTextField, visionDepartImageView])
        visionDepartDistanceStackView.customStackView(spacing: Constants.verticalMargin, axis: .vertical, alignment: .center)
        return visionDepartDistanceStackView
    }()
    
    lazy var departLabel: UILabel = {
        let departLabel = UILabel()
        departLabel.customLabel(text: "출발", textColor: .mainNavyColor, font: UIFont.spoqaHanSansNeo(size: Constants.fontSize16, weight: .medium), alignment: .center)
        return departLabel
    }()
    
    //출발 이미지 선택 버튼
    lazy var visionDepartImageButton: UIButton = {
        let visionDepartImageButton = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .mainNavyColor
        config.image = UIImage(systemName: "plus")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 80, weight: .medium))
        visionDepartImageButton.configuration = config
        return visionDepartImageButton
    }()
    
    //출발 텍스트필드
    lazy var visionDepartTextField: UITextField = {
        let visionDepartTextField = UITextField()
        
        //customTextField 수정
        let placeholderColor: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.spoqaHanSansNeo(size: Constants.fontSize20, weight: .medium),
        ]
        
        visionDepartTextField.historyNewCustomTextField(placeholder: NSAttributedString(string: "ex) 10000", attributes: placeholderColor), font: UIFont.spoqaHanSansNeo(size: Constants.fontSize20, weight: .medium), textColor: .black, alignment: .right, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: Constants.horizontalMargin, height: visionDepartTextField.frame.size.height)), keyboardType: .decimalPad)
        
        return visionDepartTextField
    }()
    
    //출발 이미지뷰
    lazy var visionDepartImageView: UIImageView = {
        let visionDepartImageView = UIImageView()
        visionDepartImageView.contentMode = .scaleAspectFit
        return visionDepartImageView
    }()
    
    //MARK: - 오른쪽 도착 버튼, 텍스트필드 스택뷰
    lazy var visionArriveDistanceStackView: UIStackView = {
        let visionArriveDistanceStackView = UIStackView(arrangedSubviews: [arriveLabel, visionArriveImabeButton, visionArriveTextField, visionArriveImageView])
        visionArriveDistanceStackView.customStackView(spacing: Constants.verticalMargin, axis: .vertical, alignment: .center)
        return visionArriveDistanceStackView
    }()
    
    lazy var arriveLabel: UILabel = {
        let arriveLabel = UILabel()
        arriveLabel.customLabel(text: "도착", textColor: .mainNavyColor, font: UIFont.spoqaHanSansNeo(size: Constants.fontSize16, weight: .medium), alignment: .center)
        return arriveLabel
    }()
    
    //도착 이미지 선택 버튼
    lazy var visionArriveImabeButton: UIButton = {
        let visionArriveImabeButton = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .mainNavyColor
        config.image = UIImage(systemName: "plus")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 80, weight: .medium))
        visionArriveImabeButton.configuration = config
        return visionArriveImabeButton
    }()
    
    //도착 텍스트필드
    lazy var visionArriveTextField: UITextField = {
        let visionArriveTextField = UITextField()
        
        //customTextField 수정
        let placeholderColor: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.spoqaHanSansNeo(size: Constants.fontSize20, weight: .medium),
        ]
        
        visionArriveTextField.historyNewCustomTextField(placeholder: NSAttributedString(string: "ex) 10020", attributes: placeholderColor), font: UIFont.spoqaHanSansNeo(size: Constants.fontSize20, weight: .medium), textColor: .black, alignment: .right, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: Constants.horizontalMargin, height: visionArriveTextField.frame.size.height)), keyboardType: .decimalPad)
        
        return visionArriveTextField
    }()
    
    //도착 이미지뷰
    lazy var visionArriveImageView: UIImageView = {
        let visionArriveImageView = UIImageView()
        visionArriveImageView.contentMode = .scaleAspectFit
        return visionArriveImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - addVisionFueling UI 설정
    private func setupUI() {
        addSubview(visionDrivingStackView)

        visionDrivingStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(0.7)
            make.leading.equalTo(safeAreaLayoutGuide).offset(Constants.horizontalMargin * 2)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-Constants.horizontalMargin * 2)
        }
        
        visionInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(visionDrivingStackView).offset(20)
        }
        
        visionDepartTextField.snp.makeConstraints { make in
            make.bottom.equalTo(visionDrivingStackView.snp.bottom).offset(-20)
        }
        
        visionArriveTextField.snp.makeConstraints { make in
            make.bottom.equalTo(visionDrivingStackView.snp.bottom).offset(-20)
        }
        
        visionDepartImageButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(150)
        }

        visionArriveImabeButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
    }
    
}
