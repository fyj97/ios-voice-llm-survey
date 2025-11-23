import UIKit

class QuestionPageViewController: UIViewController {
    
    // MARK: - Properties
    var questions: [Question] = []
    var pageIndex: Int = 0
    
    // MARK: - UI Elements
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayQuestions()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Display Questions
    private func displayQuestions() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for (index, question) in questions.enumerated() {
            let questionView = createQuestionView(question: question, questionNumber: pageIndex * 2 + index + 1)
            stackView.addArrangedSubview(questionView)
        }
        
        // If only one question on last page, add spacer
        if questions.count == 1 {
            let spacerView = UIView()
            spacerView.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(spacerView)
        }
    }
    
    private func createQuestionView(question: Question, questionNumber: Int) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .secondarySystemBackground
        containerView.layer.cornerRadius = 12
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 4
        
        let numberLabel = UILabel()
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.text = "Question \(questionNumber)"
        numberLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        numberLabel.textColor = .systemBlue
        
        let questionLabel = UILabel()
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.text = question.question
        questionLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        questionLabel.textColor = .label
        questionLabel.numberOfLines = 0
        
        let typeLabel = UILabel()
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.text = "Type: \(question.type)"
        typeLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        typeLabel.textColor = .secondaryLabel
        
        if let followUp = question.followUp {
            let followUpLabel = UILabel()
            followUpLabel.translatesAutoresizingMaskIntoConstraints = false
            followUpLabel.text = "Follow-up: \(followUp)"
            followUpLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            followUpLabel.textColor = .systemOrange
            followUpLabel.numberOfLines = 0
            
            containerView.addSubview(numberLabel)
            containerView.addSubview(questionLabel)
            containerView.addSubview(typeLabel)
            containerView.addSubview(followUpLabel)
            
            NSLayoutConstraint.activate([
                numberLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
                numberLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
                numberLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
                
                questionLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 12),
                questionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
                questionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
                
                typeLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 12),
                typeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
                typeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
                
                followUpLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 12),
                followUpLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
                followUpLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
                followUpLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
                
                containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150)
            ])
        } else {
            containerView.addSubview(numberLabel)
            containerView.addSubview(questionLabel)
            containerView.addSubview(typeLabel)
            
            NSLayoutConstraint.activate([
                numberLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
                numberLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
                numberLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
                
                questionLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 12),
                questionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
                questionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
                
                typeLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 12),
                typeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
                typeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
                typeLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
                
                containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150)
            ])
        }
        
        return containerView
    }
}

