//
//  GuideView.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/11/06.
//

import UIKit

class GuideView: UIView {
    // MARK: Properties
    private lazy var totalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [gasolineStackView, dieselStackView, carWashStackView, storeStackView])
        view.customStackView(spacing: 5, axis: .vertical, alignment: .leading)
        view.distribution = .fillEqually
        return view
    }()
    
    private lazy var gasolineStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [gasolineImage,gasolineLabel])
        view.customStackView(spacing: 10, axis: .horizontal, alignment: .center)
        return view
    }()
    
    private let gasolineImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "greenoil")
        return view
    }()
    
    private let gasolineLabel: UILabel = {
        let label = UILabel()
        label.text = "휘발유"
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontSize10, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private lazy var dieselStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [dieselImage, dieselLabel])
        view.customStackView(spacing: 10, axis: .horizontal, alignment: .center)
        return view
    }()
    
    private let dieselImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "yellowoil")
        return view
    }()
    
    private let dieselLabel: UILabel = {
        let label = UILabel()
        label.text = "경유"
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontSize10, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private lazy var carWashStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [carWashImage, carWashLabel])
        view.customStackView(spacing: 10, axis: .horizontal, alignment: .center)
        return view
    }()
    
    private let carWashImage = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "carwash")
        return imageView
    }()
    
    private let carWashLabel: UILabel = {
        let label = UILabel()
        label.text = "세차장 유무"
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontSize10, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private lazy var storeStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [storeImage, storeLabel])
        view.customStackView(spacing: 10, axis: .horizontal, alignment: .center)
        return view
    }()
    
    private let storeImage = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "store")
        return imageView
    }()
    
    private let storeLabel: UILabel = {
        let label = UILabel()
        label.text = "편의점 유무"
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontSize10, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    // MARK: LifeCycle
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Method
    private func setupUI() {
        self.addSubview(totalStackView)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = Constants.cornerRadius
        self.alpha = 0.9
        
        totalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.verticalMargin)
            $0.size.equalTo(90)
        }
        
        gasolineImage.snp.makeConstraints {
            $0.size.equalTo(20)
        }
        
        dieselImage.snp.makeConstraints {
            $0.size.equalTo(20)
        }
        
        carWashImage.snp.makeConstraints {
            $0.size.equalTo(15)
        }
        
        storeImage.snp.makeConstraints {
            $0.size.equalTo(15)
        }
    }
}
