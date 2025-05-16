//
//  NewsArticleListViewModel.swift
//  NewsApp
//
//  Created by Mohammad Azam on 6/30/21.
//

import Foundation

@MainActor
class NewsArticleListViewModel: ObservableObject {
    
    @Published var newsArticles = [NewsArticleViewModel]()
    
    func getNewsBy(sourceId: String) {
        
        Webservice().fetchNews(by: sourceId, url: Constants.Urls.topHeadlines(by: sourceId)) { result in
            switch result {
            case .success(let newsArticles):
                self.newsArticles = newsArticles.map(NewsArticleViewModel.init)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

struct NewsArticleViewModel {
    
    let id = UUID()
    fileprivate let newsArticle: NewsArticle
    
    var title: String {
        newsArticle.title
    }
    
    var description: String {
        newsArticle.description ?? ""
    }
    
    var author: String {
        newsArticle.author ?? ""
    }
    
    var urlToImage: URL? {
        URL(string: newsArticle.urlToImage ?? "")
    }
    
}
