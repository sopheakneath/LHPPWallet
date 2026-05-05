//
//  KeyboardRespone.swift
//  LHPPWallet
//
//  Created by sopheakneath on 23/4/26.
//


    import SwiftUI
    import Combine

    final class KeyboardResponder: ObservableObject {
        @Published var height: CGFloat = 0

        private var cancellables = Set<AnyCancellable>()

        init() {
            let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)

            willShow.merge(with: willHide)
                .sink { notification in
                    if notification.name == UIResponder.keyboardWillShowNotification {
                        if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                            self.height = frame.height
                        }
                    } else {
                        self.height = 0
                    }
                }
                .store(in: &cancellables)
        }
    }

// notificationCenter
