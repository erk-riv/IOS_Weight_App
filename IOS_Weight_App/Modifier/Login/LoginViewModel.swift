//
//  LoginViewModel.swift
//  IOS_Weight_App
//
//  Created by Erick Rivera on 2/9/23.
//

import Combine
import Foundation

enum LoginState {
    case successful
    case failed(error: Error)
    case na
}

protocol LoginViewModel {
    func login()
    var service: LoginService { get }
    var state: LoginState { get }
    var credentials: LoginCredentials { get }
    var hasError: Bool { get }
    init(service: LoginService)
}

final class LoginViewModelImpl: ObservableObject, LoginViewModel {
    let service: LoginService
    @Published var hasError: Bool = false
    @Published var state: LoginState = .na
    @Published var credentials: LoginCredentials = LoginCredentials.new
    private var subscriptions = Set<AnyCancellable>()
    
    init(service: LoginService) {
        self.service = service
        setupErrorSubscriptions()
    }
    
    func login() {
        service
            .login(with: credentials)
            .sink { res in
                switch res {
                    case .failure(let err):
                        self.state = .failed(error: err)
                    default: break
                }
            } receiveValue: {[weak self] in
                self?.state = .successful
            }
            .store(in: &subscriptions)
    }
}

private extension LoginViewModelImpl {
    func setupErrorSubscriptions() {
        $state
            .map { state -> Bool in
                switch state {
                case .successful,
                        .na:
                    return false
                case .failed:
                    return true
                }
            }
            .assign(to: &$hasError)
    }
}
