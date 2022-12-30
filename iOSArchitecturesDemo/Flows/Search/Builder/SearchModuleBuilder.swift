//
//  SearchModuleBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Артур Кондратьев on 26.12.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class SearchModuleBuilder {
    static func build() -> (UIViewController & SearchViewInput) {
        let interactor = SearchInteractor()
        let router = SearchRouter()
        let presenter = SearchPresenter(interactor: interactor, router: router)
        let viewController = SearchViewController(presenter: presenter )
        presenter.viewInput = viewController
        router.viewController = viewController
        return viewController
    }
}
