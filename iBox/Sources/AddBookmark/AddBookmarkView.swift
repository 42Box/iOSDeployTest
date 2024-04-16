//
//  AddBookmarkView.swift
//  iBox
//
//  Created by jiyeon on 1/5/24.
//

import UIKit
import Combine

import SnapKit

class AddBookmarkView: UIView {
    
    var cancellables = Set<AnyCancellable>()
    
    var onButtonTapped: (() -> Void)?
    var onTextChange: ((Bool) -> Void)?
    
    var selectedFolderName: String? {
        didSet {
            selectedFolderLabel.text = selectedFolderName
        }
    }
    
    // MARK: - UI Components
    
    private let textFieldView: UIView = UIView().then {
        $0.backgroundColor = UIColor.backgroundColor
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    
    private let nameTextViewPlaceHolder = UILabel().then {
        $0.text = "북마크 이름"
        $0.font = .cellTitleFont
        $0.textColor = .systemGray3
    }
    
    let nameTextView = UITextView().then {
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 0
        $0.textContainerInset = UIEdgeInsets(top: 7, left: 0, bottom: 0, right: 0)
        $0.font = .cellTitleFont
        $0.textColor = .label
        $0.isScrollEnabled = true
        $0.keyboardType = .default
        $0.autocorrectionType = .no
    }
    
    private let clearButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        $0.tintColor = .systemGray3
        $0.isHidden = true
    }
    
    private let separatorView = UIView().then {
        $0.backgroundColor = .systemGray3
    }
    
    private let urlTextViewPlaceHolder = UILabel().then {
        $0.text = "URL"
        $0.font = .cellTitleFont
        $0.textColor = .systemGray3
    }
    
    let urlTextView = UITextView().then {
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 0
        $0.textContainerInset = UIEdgeInsets(top: 7, left: 0, bottom: 0, right: 0)
        $0.font = .cellTitleFont
        $0.textColor = .label
        $0.isScrollEnabled = true
        $0.keyboardType = .URL
        $0.autocorrectionType = .no
    }
    
    private let button = UIButton(type: .custom).then {
        $0.backgroundColor = UIColor.backgroundColor
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.titleLabel?.font = .cellTitleFont
        $0.isEnabled = true
    }
    
    private let buttonLabel = UILabel().then {
        $0.text = "목록"
        $0.font = .cellTitleFont
        $0.textColor = .label
    }
    
    let selectedFolderLabel = UILabel().then {
        $0.font = .descriptionFont
        $0.textColor = .systemGray
        $0.textAlignment = .right
    }
    
    private let chevronImageView = UIImageView().then {
        let image = UIImage(systemName: "chevron.forward")?.withRenderingMode(.alwaysTemplate)
        $0.image = image
        $0.tintColor = .systemGray
        $0.contentMode = .scaleAspectFit
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProperty()
        setupHierarchy()
        setupLayout()
        setupBindings()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setup Methods
    
    private func setupProperty() {
        backgroundColor = .systemGroupedBackground
        updateTextFieldWithIncomingData()
        clearButton.addTarget(self, action: #selector(clearTextView), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        nameTextView.delegate = self
        urlTextView.delegate = self
    }
    
    private func setupHierarchy() {
        addSubview(textFieldView)
        addSubview(nameTextView)
        addSubview(clearButton)
        addSubview(separatorView)
        addSubview(urlTextView)
        addSubview(nameTextViewPlaceHolder)
        addSubview(urlTextViewPlaceHolder)
        addSubview(button)
        addSubview(buttonLabel)
        addSubview(selectedFolderLabel)
        addSubview(chevronImageView)
    }
    
    private func setupLayout() {
        
        textFieldView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.height.equalTo(150)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        nameTextView.snp.makeConstraints { make in
            make.top.equalTo(textFieldView.snp.top).offset(10)
            make.leading.equalTo(textFieldView.snp.leading).offset(15)
            make.trailing.equalTo(textFieldView.snp.trailing).offset(-15)
            make.height.equalTo(30)
        }
        
        nameTextViewPlaceHolder.snp.makeConstraints { make in
            make.top.equalTo(nameTextView.snp.top).offset(7)
            make.leading.equalTo(nameTextView.snp.leading).offset(5)
        }
        
        clearButton.snp.makeConstraints { make in
            make.top.equalTo(nameTextView.snp.top).offset(7)
            make.trailing.equalTo(nameTextView.snp.trailing).offset(-5)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(nameTextView.snp.bottom).offset(10)
            make.leading.equalTo(nameTextView.snp.leading).offset(5)
            make.trailing.equalTo(nameTextView.snp.trailing).offset(-5)
            make.height.equalTo(1)
        }
        
        urlTextView.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(nameTextView)
            make.bottom.equalTo(textFieldView.snp.bottom).offset(-10)
        }
        
        urlTextViewPlaceHolder.snp.makeConstraints { make in
            make.top.equalTo(urlTextView.snp.top).offset(7)
            make.leading.equalTo(urlTextView.snp.leading).offset(5)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(textFieldView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        buttonLabel.snp.makeConstraints { make in
            make.leading.equalTo(button.snp.leading).offset(20)
            make.centerY.equalTo(button.snp.centerY)
            make.height.equalTo(40)
        }
        
        selectedFolderLabel.snp.makeConstraints { make in
            make.leading.equalTo(buttonLabel.snp.trailing).offset(10)
            make.trailing.equalTo(chevronImageView.snp.leading).offset(-10)
            make.centerY.equalTo(button.snp.centerY)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.trailing.equalTo(button.snp.trailing).offset(-20)
            make.centerY.equalTo(button.snp.centerY)
            make.width.equalTo(17)
            make.height.equalTo(17)
        }
        
    }
    
    private func updateTextField(textField: UITextView, placeholder: UILabel, withData data: String?) {
        if let data = data, !data.isEmpty {
            textField.text = data
            placeholder.isHidden = true
            if textField == nameTextView {
                clearButton.isHidden = false
            }
        } else {
            textField.text = ""
            placeholder.isHidden = false
            if textField == nameTextView {
                clearButton.isHidden = true
            }
        }
    }
    
    private func setupBindings() {
        AddBookmarkManager.shared.$incomingTitle
            .receive(on: DispatchQueue.main)
            .sink { [weak self] title in
                self?.nameTextView.text = title
                self?.nameTextViewPlaceHolder.isHidden = !(title?.isEmpty ?? true)
                self?.clearButton.isHidden = title?.isEmpty ?? true
                self?.updateTextFieldsFilledState()
            }
            .store(in: &cancellables)
        
        AddBookmarkManager.shared.$incomingData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] url in
                self?.urlTextView.text = url
                self?.urlTextViewPlaceHolder.isHidden = !(url?.isEmpty ?? true)
                self?.updateTextFieldsFilledState()
            }
            .store(in: &cancellables)
    }
    
    private func updateTextFieldWithIncomingData() {
        updateTextField(textField: nameTextView, placeholder: nameTextViewPlaceHolder, withData: AddBookmarkManager.shared.incomingTitle)
        AddBookmarkManager.shared.incomingTitle = nil
        
        updateTextField(textField: urlTextView, placeholder: urlTextViewPlaceHolder, withData: AddBookmarkManager.shared.incomingData)
        AddBookmarkManager.shared.incomingData = nil
    }
    
    func updateTextFieldsFilledState() {
        let isBothTextViewsFilled = !(nameTextView.text?.isEmpty ?? true) && !(urlTextView.text?.isEmpty ?? true)
        onTextChange?(isBothTextViewsFilled)
    }
    
    @objc func clearTextView() {
        nameTextView.text = ""
        textViewDidChange(nameTextView)
    }
    
    @objc private func buttonTapped() {
        onButtonTapped?()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}

extension AddBookmarkView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        let textLength: Int = textView.text.count
        textView.selectedRange = NSRange(location: textLength, length: 0)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            if textView == nameTextView {
                urlTextView.becomeFirstResponder()
            } else if textView == urlTextView {
                textView.resignFirstResponder()
            }
            return false
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        let isBothTextViewsFilled = !nameTextView.text.isEmpty && !urlTextView.text.isEmpty
        onTextChange?(isBothTextViewsFilled)
        
        if textView == nameTextView {
            nameTextViewPlaceHolder.isHidden = !nameTextView.text.isEmpty
            clearButton.isHidden = nameTextView.text.isEmpty
        }
        
        if textView == urlTextView {
            urlTextViewPlaceHolder.isHidden = !urlTextView.text.isEmpty
        }
        
    }
}
