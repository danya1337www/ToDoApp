//
//  TaskCell.swift
//  ToDoApp
//
//  Created by Danil Chekantsev on 04.06.2026.
//

import UIKit

protocol TaskCellDelegate: AnyObject {
    func didTapAction(for task: TaskEntity)
}

class TaskCell: UITableViewCell {
    
    static let identifier = "TaskCell"
    weak var delegate: TaskCellDelegate?
    private var task: TaskEntity?

    // MARK: - UI
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .tertiaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(buttonStack)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            statusLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            dateLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            buttonStack.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            buttonStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            buttonStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    // MARK: - Configure
    
    func configure(with task: TaskEntity) {
        self.task = task
        titleLabel.text = task.title
        
        let status = TaskStatus(rawValue: task.status ?? "")
        statusLabel.text = status?.rawValue
        
        switch status {
        case .new:
            statusLabel.textColor = .systemBlue
        case .inProgress:
            statusLabel.textColor = .systemOrange
        case .done:
            statusLabel.textColor = .systemGreen
        case .none:
            break
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        dateLabel.text = task.createdAt.map { formatter.string(from: $0) }
        
        setupButtons(for: status)
    }
    
    private func setupButtons(for status: TaskStatus?) {
        buttonStack.arrangedSubviews.forEach { $0.removeFromSuperview() }

        switch status {
        case .new:
            addButton(title: "To process", color: .systemOrange, action: #selector(toWorkTapped))
            addButton(title: "Delete", color: .systemRed, action: #selector(deleteTapped))
        case .inProgress:
            addButton(title: "Done", color: .systemGreen, action: #selector(doneTapped))
        case .done:
            break
        case .none:
            break
        }
    }
    
    private func addButton(title: String, color: UIColor, action: Selector) {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        button.addTarget(self, action: action, for: .touchUpInside)
        buttonStack.addArrangedSubview(button)
    }
    
    // MARK: - Actions
    
    @objc private func toWorkTapped() {
        guard let task else { return }
        
        CoreDataManager.shared.updateStatus(task, status: .inProgress)
        delegate?.didTapAction(for: task)
    }
    
    @objc private func doneTapped() {
        guard let task else { return }
        
        CoreDataManager.shared.updateStatus(task, status: .done)
        delegate?.didTapAction(for: task)
    }
    
    @objc private func deleteTapped() {
        guard let task else { return }
        
        CoreDataManager.shared.deleteTask(task)
        delegate?.didTapAction(for: task)
    }
    
    
}
