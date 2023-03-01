//
//  OnboardingViewController.swift
//  CookBookOnboardingModule
//
//  Created by Rose on 28.02.2023.
//

import UIKit
import SwiftUI

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [OnboardingSlide] = []
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextButton.setTitle("Get Started", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.layer.cornerRadius = 10
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        slides = [
            OnboardingSlide(title: "Cook with chef!", description: "Find best recipes for cooking", image: #imageLiteral(resourceName: "slide2")),
            OnboardingSlide(title: "Delicious new recipes every day", description: "Step by step cooking", image: #imageLiteral(resourceName: "slide1")),
            OnboardingSlide(title: "Tasty recipes from around the world", description: "Get recipes based on your tastes, goals and preferences", image: #imageLiteral(resourceName: "slide3"))
        ]
        
    }
    
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            print("Go to the next page")
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}
        
extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
            
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
            
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
            
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}


//// MARK: - SwiftUI
//
//import SwiftUI
//struct ListProvider: PreviewProvider {
//    static var previews: some View {
//        ContainerView().edgesIgnoringSafeArea(.all)
//    }
//
//    struct ContainerView: UIViewControllerRepresentable {
//
//        let listVC = OnboardingViewController()
//
//        func makeUIViewController(context: UIViewControllerRepresentableContext<ListProvider.ContainerView>) -> OnboardingViewController {
//            return listVC
//        }
//
//        func updateUIViewController(_ uiViewController: ListProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ListProvider.ContainerView>) {
//        }
//    }
//}
