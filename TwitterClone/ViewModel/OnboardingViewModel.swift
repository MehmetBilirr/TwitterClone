//
//  OnboardingViewModel.swift
//  TwitterClone
//
//  Created by Mehmet Bilir on 16.11.2022.
//

import Foundation
import UIKit

protocol OnboardingToAppDelegate:AnyObject {
    func didTapSignUp(navigationController:UINavigationController)
    func didTapLogin(navigationController:UINavigationController)
    
}

protocol OnboardingViewModelInterface:AnyObject {
    var navigationController:UINavigationController? {get set}
    var delegate:OnboardingToAppDelegate? {get set}
    func viewDidLoad()
    func didTapSignUp()
    func didTapLogin()
    
}

final class OnboardingViewModel {
    weak var navigationController:UINavigationController?
    weak var view : OnboardingViewInterface? 
    weak var delegate:OnboardingToAppDelegate?
    
    
}

extension OnboardingViewModel:OnboardingViewModelInterface {
    
    func viewDidLoad() {
        view?.style()
        view?.layout()
    }
    
    func didTapSignUp() {
        delegate?.didTapSignUp(navigationController: navigationController!)
    }
    
    func didTapLogin() {
        delegate?.didTapLogin(navigationController: navigationController!)
    }
    
    
    
    
}
