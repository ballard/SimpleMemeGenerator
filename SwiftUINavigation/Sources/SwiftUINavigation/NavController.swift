
//
//  NavController.swift
//  CustomNavigationView
//
//  Created by Иван Лазарев on 10.03.2020.
//  Copyright © 2020 Иван Лазарев. All rights reserved.
//

import SwiftUI


// MARK: - Views

public struct NavControllerView<Content>: View where Content: View {
    
    @ObservedObject private var viewModel: NavControllerViewModel
    
    private let content: Content
    
    private let transitions: (push: AnyTransition, pop: AnyTransition)
    
    public init(transition: NavTransition,
         easing: Animation = .easeIn(duration: 0.33),
         @ViewBuilder content: @escaping () -> Content)
    {
        self.viewModel = NavControllerViewModel(easing: easing)
        self.content = content()
        switch transition {
        case .none:
            self.transitions = (.identity, .identity)
        case .custom(let transitionIn, let transitionOut):
            self.transitions = (transitionIn, transitionOut)
        }
        
    }
    
    public var body: some View {
        let isRoot = viewModel.currentScreen == nil
        
        return ZStack {
//            Group {
                if isRoot {
                    self.content
                        .transition(viewModel.navigationType == .push ? transitions.push : transitions.pop)
                        .environmentObject(viewModel)
                } else {
                    viewModel.currentScreen!.nextScreen
                    .transition(viewModel.navigationType == .push ? transitions.push : transitions.pop)
                    .environmentObject(viewModel)
                    
                }
                
//            }
        }
        
    }
}

public struct NavPushButton<Label, Destination/*, Tag*/>: View where Label: View, Destination: View {//, Tag: Hashable {
    
    @EnvironmentObject private var viewModel: NavControllerViewModel
    
    private let destination : Destination
    private let label: Label?
//    private let tag: Tag? = nil
    
//    @Binding private var isActive: Bool
//    @Binding private var selection: Tag?
//
    public init(destination: Destination,/* tag: Tag,*/ @ViewBuilder label: @escaping () -> Label) {
        self.destination = destination
        self.label = label()
    }
    
    public var body: some View {
//        if isActive {
//            DispatchQueue.main.async {
//                self.push()
//            }
//        }
        return label?.onTapGesture {
            self.push()
        }
    }
    
    private func push() {
        self.viewModel.push(self.destination)
    }
    
    
}

struct NavPopButton<Label>: View where Label: View {
    
    @EnvironmentObject private var viewModel: NavControllerViewModel
    
    private let destination: PopDestination
    private let label: Label?
    
    init(destination: PopDestination, @ViewBuilder label: @escaping () -> Label) {
        self.destination = destination
        self.label = label()
    }
    
    var body: some View {
        self.label?.onTapGesture {
            self.pop()
        }
    }
    
    private func pop() {
        viewModel.pop(to: destination)
    }
}

// MARK: - Enums

public enum NavTransition {
    case none
    case custom(AnyTransition, AnyTransition)
}

enum NavType {
    case push
    case pop
}

enum PopDestination {
    case previous
    case root
}

// MARK: - Navigation logic

private struct Screen: Identifiable, Equatable {
    let id: String
    let nextScreen: AnyView
    
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        lhs.id == rhs.id
        
    }
}


final class NavControllerViewModel: ObservableObject {
    
    private let easing: Animation
    var navigationType = NavType.push
    
    @Published fileprivate var currentScreen: Screen?
    private var screenStack = ScreenStack() {
        didSet {
            currentScreen = screenStack.top()
        }
    }
    
    init(easing: Animation) {
        self.easing = easing
    }
    
    func push<S: View>(_ screenView: S) {
        withAnimation(easing) {
            navigationType = .push
            let screen = Screen(id: UUID().uuidString, nextScreen: AnyView(screenView))
            screenStack.push(screen)
        }
    }
    
    func pop(to: PopDestination = .previous) {
        withAnimation(easing) {
            navigationType = .pop
            switch to {
            case .root:
                screenStack.popToRoot()
            case .previous:
                screenStack.popToPrevious()
            }
        }
    }
    
    // Nestet stack model
    private struct ScreenStack {
        
        private var screens = [Screen]()
        func top() -> Screen? {
            screens.last
        }
        
        mutating func push(_ s: Screen) {
            screens.append(s)
        }
        
        mutating func popToPrevious() {
            _ = screens.popLast()
        }
        
        mutating func popToRoot() {
            screens.removeAll()
        }
    }
}
