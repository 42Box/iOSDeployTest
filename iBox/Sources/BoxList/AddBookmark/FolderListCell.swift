//
//  FolderListCell.swift
//  iBox
//
//  Created by 최종원 on 3/7/24.
//

import UIKit

class FolderListCell: UITableViewCell {
    
    static let reuseIdentifier = "ListCell"
    
    private let folderImageView = UIImageView().then {
        $0.image = UIImage(systemName: "folder.fill")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .gray
    }
    
    let folderNameLabel = UILabel().then {
        $0.textColor = .label
        $0.font = .systemFont(ofSize: 17, weight: .regular)
    }

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.contentView.addSubview(folderImageView)
        self.contentView.addSubview(folderNameLabel)
        self.backgroundColor = .clear
        setupLayout()
    }
    
    func setupLayout() {
        folderImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(30)
            make.top.greaterThanOrEqualToSuperview().offset(10)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        }
        
        folderNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(folderImageView.snp.trailing).offset(10)
            make.trailing.lessThanOrEqualToSuperview().offset(-20)
            make.top.greaterThanOrEqualToSuperview().offset(10)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        }
        
    }
    
}