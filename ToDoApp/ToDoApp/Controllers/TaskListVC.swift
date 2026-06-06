//
//  TaskListVC.swift
//  ToDoApp
//
//  Created by Danil Chekantsev on 04.06.2026.
//

import UIKit

class TaskListVC: UIViewController {
    
    // MARK: - Properties
    
    private var tasks: [TaskEntity] = []
    
    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        
        return tableView
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTasks()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupNavigation() {
        title = "Tasks"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addTaskTapped)
        )
    }
    
    // MARK: - Data
    
    private func loadTasks() {
        tasks = CoreDataManager.shared.fetchTasks()
        tableView.reloadData()
    }
    
    // MARK: - Actions (objc method)
    
    @objc private func addTaskTapped() {
        let vc = CreateTaskVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
    
    // MARK: - UITableViewDataSource & Delegate
extension TaskListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as! TaskCell
        cell.configure(with: tasks[indexPath.row])
        cell.delegate = self
        
        return cell
    }
    
    // DELEGATE
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = TaskDetailsVC(task: tasks[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - TaskCellDelegate

extension TaskListVC: TaskCellDelegate {
     
    func didTapAction(for task: TaskEntity) {
        loadTasks()
    }
}
    
    

