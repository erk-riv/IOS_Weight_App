//
//  NewUserView.swift
//  IOS_Weight_App
//
//  Created by Erick Rivera on 2/9/23.
//

import Foundation
import Combine

enum NewUserState {
    case successful
    case failed(error: Error)
    case na
}

protocol NewUserView {
    func register()
    var hasError: Bool { get }
    var service: NewUserService { get }
    var state: NewUserState { get }
    var userDetails: NewUserInfo { get }
    init(service: NewUserService)
}

final class NewUserViewImpl: ObservableObject, NewUserView {
    let service: NewUserService
    @Published var state: NewUserState = .na
    @Published var hasError: Bool = false
    @Published var userDetails: NewUserInfo = NewUserInfo(email: "",
                                               password: "",
                                               firstName: "",
                                               lastName: "",
                                               age: "")
    private var subscriptions = Set<AnyCancellable>()
    
    init(service: NewUserService) {
        self.service = service
        setupErrorSubscriptions()
    }
    
    func register() {
        service
            .register(with: userDetails)
            .sink { [weak self] res in
                switch res {
                case .failure(let error):
                    self?.state = .failed(error: error)
                default: break
                }
                
            } receiveValue: { [weak self] in
                self?.state = .successful
            }
            .store(in: &subscriptions)
    }
}

private extension NewUserViewImpl {
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
