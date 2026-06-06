//
//  CreateTaskVC.swift
//  ToDoApp
//
//  Created by Danil Chekantsev on 04.06.2026.
//

import UIKit

class CreateTaskVC: UIViewController {

    // MARK: - UI
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Short description"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16)
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 8
        textView.translatesAutoresizingMaskIntoConstraints = false
    
        return textView
    }()
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Full description"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .systemGray3
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupNavigation()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(titleTextField)
        view.addSubview(descriptionTextView)
        descriptionTextView.addSubview(placeholderLabel)
        descriptionTextView.delegate = self
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleTextField.heightAnchor.constraint(equalToConstant: 50),
            
            descriptionTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16),
            descriptionTextView.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 150),
            
            placeholderLabel.topAnchor.constraint(equalTo: descriptionTextView.topAnchor, constant: 8),
            placeholderLabel.leadingAnchor.constraint(equalTo: descriptionTextView.leadingAnchor, constant: 5)
        ])
    }
    
    private func setupNavigation() {
        title = "New task"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Save",
            style: .done,
            target: self,
            action: #selector(saveTapped)
        )
    }
    
    // MARK: - Actions
    
    @objc private func saveTapped() {
        guard let title = titleTextField.text, !title.isEmpty else {
            showAlert(message: "Text short description")
            return
        }
        
        let description = descriptionTextView.text ?? ""
        CoreDataManager.shared.createTask(title: title, fullDescription: description)
        navigationController?.popViewController(animated: true)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(
            title: "error",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "ok", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UITextViewDelegate
extension CreateTaskVC: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
