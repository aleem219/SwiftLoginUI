//
//  SwiftLoginUIApp.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 02/04/26.
//

import SwiftUI
//
//@main
//struct SwiftLoginUIApp: App {
//    @State private var vm = LoginViewModel()
//    @State private var userViewModel = UserViewModel()
//    @State private var userDetailViewModel = UserDetailViewModel()
//    
//    var body: some Scene {
//        WindowGroup {
//            NavigationStack {
//                if vm.isLoggedIn {
//                    TabbarView()
//                        .environment(vm)
//                } else {
//                    LoginView()
//                        .environment(vm)
//                }
//            }
//            .environment(vm)
//            .environment(userViewModel)
//            .environment(userDetailViewModel)
//        }
//    }
//}


@main
struct SwiftLoginUIApp: App {
    @State private var vm = LoginViewModel()
    @State private var userViewModel = UserViewModel()
    @State private var userDetailViewModel = UserDetailViewModel()
    @State private var productViewModel = ProductViewModel()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if vm.isLoggedIn {
                    NavigationStack {
                        TabbarView()
                    }
                    .environment(userViewModel)
                    .environment(userDetailViewModel)
                    .environment(productViewModel)  
                } else {
                    NavigationStack {
                        LoginView()
                    }
                }
            }
            .environment(vm)
        }
    }
}
