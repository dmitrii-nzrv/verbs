//
//  TrainViewController.swift
//  Verregular
//
//  Created by Dmitrii Nazarov on 11.12.2023.
//

import UIKit
import SnapKit

final class TrainVerbsViewController: UIViewController {
    
    //  MARK: ~ GUI Variables
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.showsHorizontalScrollIndicator = false
        
        return view
    }()
    
    private lazy var numberOfCurrentVerbLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "\(count)/ \(dataSource.count)"
        
        return label
    }()
    
    private lazy var numberOfCurrentScoreLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "\(score)"
        
        return label
    }()
    
    private lazy var contentView: UIView = UIView()
    
    private lazy var infinitiveLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var pastSimpleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Past simple"
        
        return label
    }()
    
    private lazy var pastParticipleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Past Participle"
        
        return label
    }()
    
    private lazy var pastSimpleTextField: UITextField = {
        let field = UITextField()
        
        field.borderStyle = .roundedRect
        field.delegate = self
        
        return field
    }()
    
    private lazy var pastParticipleField: UITextField = {
        let field = UITextField()
        
        field.borderStyle = .roundedRect
        field.delegate = self
        
        return field
    }()
    
    private lazy var checkButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemGray5
        button.setTitle("Check".localized, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(checkAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: ~ Properties
    private let edgeInsets = 30
    private let dataSource = IrregularVerbs.shared.selectedVerbs
    
    private var score = 0 {
            didSet {
                numberOfCurrentScoreLabel.text = "Count: " + String(score)
            }
        }
    private var currentVerb: Verb? {
        guard dataSource.count > count else { return nil}
        return dataSource[count]
    }
    
    private var countCurrentVerb = 0 {
           didSet {
               numberOfCurrentVerbLabel.text = "\(countCurrentVerb)/\(dataSource.count)"
           }
       }
    
    private var count = 0 {
        didSet {
            infinitiveLabel.text = currentVerb?.infinitive
            pastSimpleTextField.text = ""
            pastParticipleField.text = ""
            countCurrentVerb += 1
        }
    }
    // MARK: ~ Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Train verbs".localized
        
        setupUI()
        hideKeyboardWhenTappedAround()
        
        infinitiveLabel.text = dataSource.first?.infinitive
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        unregisterForKeyboardNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotification()
    }
    
    // MARK: ~ Private methods
    
    private func showAlert() {
        let stringForAlert = "Score:" + "%d"
        let message = String(format: stringForAlert, score)
        let alert = UIAlertController(title: "The end",message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { _ in
            self.navigationController?.popViewController(animated: true) }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @objc
    private func checkAction() {
        let isSecondAttepmt = checkButton.backgroundColor == .red
        
        if checkAnswers() {
            if currentVerb?.infinitive == dataSource.last?.infinitive {
                //navigationController?.popViewController(animated: true)
                
                score += isSecondAttepmt ? 0 : 1
                showAlert()
            } else {
                checkButton.backgroundColor = .systemGray5
                checkButton.setTitle("Ok", for: .normal)
                
                score += isSecondAttepmt ? 0 : 1
            }
            count += 1
        } else {
            checkButton.backgroundColor = .red
            checkButton.setTitle("Try again".localized, for: .normal)
        }
    }
    
    private func checkAnswers() -> Bool {
        pastSimpleTextField.text?.lowercased() == currentVerb?.pastSimple.lowercased() &&
        pastParticipleField.text?.lowercased() == currentVerb?.pastParticiple.lowercased()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews([
            infinitiveLabel,
            pastSimpleLabel,
            pastSimpleTextField,
            pastParticipleLabel,
            pastParticipleField,
            checkButton,
            numberOfCurrentVerbLabel,
            numberOfCurrentScoreLabel])
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.size.edges.equalToSuperview()
        }
        
        infinitiveLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(200)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        pastSimpleLabel.snp.makeConstraints { make in
            make.top.equalTo(infinitiveLabel.snp.bottom).offset(60)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        pastSimpleTextField.snp.makeConstraints { make in
            make.top.equalTo(pastSimpleLabel.snp.bottom).offset(10)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        pastParticipleLabel.snp.makeConstraints { make in
            make.top.equalTo(pastSimpleTextField.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        pastParticipleField.snp.makeConstraints { make in
            make.top.equalTo(pastParticipleLabel.snp.bottom).offset(10)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        checkButton.snp.makeConstraints { make in
            make.top.equalTo(pastParticipleField.snp.bottom).offset(100)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        numberOfCurrentVerbLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(25)
            make.leading.equalToSuperview().inset(30)
        }
        
        numberOfCurrentScoreLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(25)
            make.trailing.equalToSuperview().inset(30)
        }
    }
}

// MARK: ~ UITextFieldDelegate
extension TrainVerbsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if pastSimpleTextField.isFirstResponder {
            pastParticipleField.becomeFirstResponder()
        } else {
            scrollView.endEditing(true)
        }
        return true
    }
}

// MARK: ~ Keyboard events
private extension TrainVerbsViewController {
    func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterForKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc
    func keyboardWillShow(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return}
            
        scrollView.contentInset.bottom = frame.height + 50
    }
    
    @objc
    func keyboardWillHide() {
        scrollView.contentInset.bottom = .zero - 50
    }
    
    func hideKeyboardWhenTappedAround() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        
        scrollView.addGestureRecognizer(recognizer)
    }
    
    @objc
    func hideKeyboard() {
        scrollView.endEditing(true)
    }
}
