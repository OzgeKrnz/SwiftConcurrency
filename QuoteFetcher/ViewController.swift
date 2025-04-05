//
//  ViewController.swift
//  QuoteFetcher
//
//  Created by özge kurnaz on 6.04.2025.
//

import UIKit

class ViewController: UIViewController {
    
    
    struct Quote: Decodable{
        let title: String
    }

    
    @IBOutlet weak var quotelabel: UILabel!
    
    @IBAction func getQuoteButtonTapped(_ sender: Any) {
        Task{
            do {
                let quote  = try await fetchQuote()
                quotelabel.text = quote

            }
            catch{
                quotelabel.text = "Bir hata olustu"

            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    func fetchQuote() async throws -> String{
        guard let url = URL(string:  "https://jsonplaceholder.typicode.com/todos/1") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedQuote = try JSONDecoder().decode(Quote.self, from: data)
        
        return decodedQuote.title
        
        
    }


}

