//
//  ProfileItemCell.swift
//  iBox
//
//  Created by jiyeon on 1/3/24.
//

import UIKit

import SnapKit

class ProfileItemCell: UITableViewCell, BaseViewProtocol {
    
    // MARK: - UI
    
    let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 17, weight: .semibold)
        $0.textColor = .black
    }
    
    let descriptionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .regular)
        $0.textColor = .gray
    }
    
    let chevronButton = UIButton().then {
        $0.configuration = .plain()
        $0.configuration?.image = UIImage(named: "chevron.right")
        $0.configuration?.preferredSymbolConfigurationForImage = .init(pointSize: 15, weight: .bold)
        $0.tintColor = .gray
    }
    
    // MARK: - initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: BaseViewProtocol
    
    func configureUI() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(chevronButton)
        
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        chevronButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(20)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.right.equalTo(chevronButton.snp.left).offset(20)
            $0.centerY.equalToSuperview()
        }
    }
    
}
