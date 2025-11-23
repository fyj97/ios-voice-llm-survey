import UIKit

class QuestionnaireViewController: UIPageViewController {
    
    // MARK: - Properties
    var questionnaireData: QuestionnaireData?
    private var pageViewControllers: [QuestionPageViewController] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageViewController()
        loadQuestionnaire()
    }
    
    // MARK: - Setup
    private func setupPageViewController() {
        dataSource = self
        delegate = self
        
        // Set page control appearance
        let pageControl = UIPageControl.appearance(whenContainedInInstancesOf: [QuestionnaireViewController.self])
        pageControl.currentPageIndicatorTintColor = .systemBlue
        pageControl.pageIndicatorTintColor = .systemGray
        
        // Set navigation bar
        title = "Questionnaire"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(closeButtonTapped)
        )
    }
    
    private func loadQuestionnaire() {
        guard let url = Bundle.main.url(forResource: "questionnaire", withExtension: "json") else {
            print("Error: questionnaire.json not found in bundle")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            questionnaireData = try decoder.decode(QuestionnaireData.self, from: data)
            setupPages()
        } catch {
            print("Error loading questionnaire: \(error)")
        }
    }
    
    private func setupPages() {
        guard let questions = questionnaireData?.questionnaire.questions else { return }
        
        pageViewControllers.removeAll()
        
        // Group questions into pages (2 per page)
        let questionsPerPage = 2
        var currentPageIndex = 0
        
        for i in stride(from: 0, to: questions.count, by: questionsPerPage) {
            let endIndex = min(i + questionsPerPage, questions.count)
            let pageQuestions = Array(questions[i..<endIndex])
            
            let pageVC = QuestionPageViewController()
            pageVC.questions = pageQuestions
            pageVC.pageIndex = currentPageIndex
            pageViewControllers.append(pageVC)
            
            currentPageIndex += 1
        }
        
        // Set initial page
        if let firstPage = pageViewControllers.first {
            setViewControllers([firstPage], direction: .forward, animated: false)
        }
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
}

// MARK: - UIPageViewControllerDataSource
extension QuestionnaireViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? QuestionPageViewController,
              let currentIndex = pageViewControllers.firstIndex(where: { $0.pageIndex == currentVC.pageIndex }),
              currentIndex > 0 else {
            return nil
        }
        return pageViewControllers[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? QuestionPageViewController,
              let currentIndex = pageViewControllers.firstIndex(where: { $0.pageIndex == currentVC.pageIndex }),
              currentIndex < pageViewControllers.count - 1 else {
            return nil
        }
        return pageViewControllers[currentIndex + 1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let currentVC = pageViewController.viewControllers?.first as? QuestionPageViewController,
              let currentIndex = pageViewControllers.firstIndex(where: { $0.pageIndex == currentVC.pageIndex }) else {
            return 0
        }
        return currentIndex
    }
}

// MARK: - UIPageViewControllerDelegate
extension QuestionnaireViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        // Update title with page info if needed
        if let currentVC = pageViewController.viewControllers?.first as? QuestionPageViewController {
            let totalPages = pageViewControllers.count
            let currentPage = currentVC.pageIndex + 1
            title = "Questionnaire (\(currentPage)/\(totalPages))"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Update title on first load
        if let currentVC = viewControllers?.first as? QuestionPageViewController {
            let totalPages = pageViewControllers.count
            let currentPage = currentVC.pageIndex + 1
            title = "Questionnaire (\(currentPage)/\(totalPages))"
        } else {
            title = "Questionnaire"
        }
    }
}

