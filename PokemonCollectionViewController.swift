//
//  PokemonCollectionViewController.swift
//  Pokemon
//
//  Created by Khalid Mohamed on 10/31/16.
//  Copyright © 2016 Khalid Mohamed. All rights reserved.r
//
//
import UIKit

class Pokemon {
    var imageURL :String!
    var title :String!
    var userId :Int!
    var longitude: Double!
    var latitude: Double!
}

private let reuseIdentifier = "Cell"

class PokemonCollectionViewController: UICollectionViewController {
    //@IBOutlet  weak var imageView :UIImageView?
    //@IBOutlet weak var textLabel :UILabel?
    var pokemon :[Pokemon]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pokemon = [Pokemon]()
        let pokemonURL = "http://still-wave-26435.herokuapp.com/pokemon/all"
        let url = URL(string: pokemonURL)
        
        
        URLSession.shared.dataTask(with: url!) { (data :Data?,response:URLResponse?, error :Error?) in
          
            let result = try! JSONSerialization.jsonObject(with: data!, options: []) as! [[String:Any]]
            for item in result {
            let pokemon = Pokemon()
            pokemon.title = item["name"] as! String
            pokemon.imageURL = item["imageURL"] as! String
            self.pokemon.append(pokemon)
            
           self.collectionView?.reloadData()
            

            }
        }.resume()
            
        }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.pokemon.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as!
        CollectionViewCell
        let pokemon = self.pokemon[indexPath.row]
       cell.textLabel?.text = pokemon.title
        let imageData = try! Data(contentsOf: URL(string: pokemon.imageURL)!)
        cell.imageView?.image = UIImage(data :imageData)
        

        return cell
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
