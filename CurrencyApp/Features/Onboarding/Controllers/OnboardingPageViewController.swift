//
//  OnboardingPageViewController.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 10/12/20.
//

import UIKit

class OnboardingPageViewController: UIPageViewController {
    
    //MARK: - Public variables
    
    //MARK: - Private variables
    
    let pages: [UIViewController] = [
        OnboardingFirstViewController(),
        OnboardingSecondViewController(),
        OnboardingThirdViewController()]
    
    //MARK: - GUI variables
    
    private lazy var pageControl: UIPageControl = {
        var control = UIPageControl()
        control.numberOfPages = self.pages.count
        control.currentPage = 0
        control.currentPageIndicatorTintColor = .black
        control.pageIndicatorTintColor = .lightGray
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

    //MARK: - View life cycle

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: options)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        if let firstVC = self.pages.first {
            self.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
}

//MARK: - UIPageViewControllerDelegate, UIPageViewControllerDataSource

extension OnboardingPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = self.pages.firstIndex(of: viewControllers[0]) {
                self.pageControl.currentPage = viewControllerIndex
            }
        }
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = self.pages.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard self.pages.count > previousIndex else {
            return nil
        }
        
        return self.pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = self.pages.firstIndex(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        let pagesCount = self.pages.count
        
        guard pagesCount != nextIndex else {
            return nil
        }
        guard pagesCount > nextIndex else {
            return nil
        }
        return self.pages[nextIndex]
    }
    
}
