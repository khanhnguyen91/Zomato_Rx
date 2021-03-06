//
//  MainViewModel.swift
//  mvvm-architect
//
//  Created by Nguyen Duc Huy on 4/20/20.
//  Copyright © 2020 sun. All rights reserved.
//

struct MainViewModel: ViewModelType {
    struct Input {
        let ready: Driver<Void>
        let refreshing: Driver<Void>
        let loadingMore: Driver<Void>
        let selected: Driver<IndexPath>
    }

    struct Output {
        let loading: Driver<Bool>
        let restaurants: Driver<[Restaurants]>
        let isLoadingMore: Driver<Bool>
        let isRefreshing: Driver<Bool>
        let fetchItems: Driver<Void>
        let isEmpty: Driver<Bool>
        let selected: Driver<Void>
        let error: Driver<Error>
    }

    struct Dependencies {
        let api: RestaurantsRepository
        let count: Int
        let navigator: MainNavigatable
    }

    private let dependencies: Dependencies
    let loadMoreTrigger = PublishRelay<Void>()

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func transform(input: Input) -> Output {
        let dataInfo = setUpLoadMorePaging(loadTrigger: input.ready,
                                           getItems: dependencies.api.fetchRestaurants,
                                           refreshTrigger: input.refreshing,
                                           refreshItems: dependencies.api.fetchRestaurants,
                                           loadMoreTrigger: input.loadingMore,
                                           loadMoreItems: dependencies.api.fetchRestaurants)

        let (pagingInfo, fetchItems, errors, isLoading, isRefreshing, isLoadingMore) = dataInfo

        let restaurants = pagingInfo.map { $0.items }.asDriverOnErrorJustComplete()

        let isEmpty = restaurants.map { $0.isEmpty }

        let selected = input.selected
            .asObservable()
            .withLatestFrom(restaurants) { ($0, $1) }
            .do(onNext: { (indexPath: IndexPath, restaurants: [Restaurants]) in
                let resId = restaurants[indexPath.row].restaurant.id
                self.dependencies.navigator.navigateToDetailScreen(with: resId, api: self.dependencies.api)
            })
            .mapToVoid()
            .asDriverOnErrorJustComplete()

        return Output(loading: isLoading,
                      restaurants: restaurants,
                      isLoadingMore: isLoadingMore,
                      isRefreshing: isRefreshing,
                      fetchItems: fetchItems,
                      isEmpty: isEmpty,
                      selected: selected,
                      error: errors)
    }
}
