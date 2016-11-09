//
//  PokemonMapViewController.swift
//  Pokemon
//
//  Created by Khalid Mohamed on 11/1/16.
//  Copyright © 2016 Khalid Mohamed. All rights reserved.
//

import UIKit
import MapKit
import CloudKit

class PokemonAnnotation:MKPointAnnotation {
    
    var imageURL :String!
    
}

class PokemonMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    var container :CKContainer!
    var publicDB :CKDatabase!
   
   // @IBAction func addpokemonbuttonpressed() {
   //     let pokemonrecord = CKRecord(recordType:"Pokemon")
    //    pokemonrecord.setValue("Bulbasaur",forKey: "Name")
    //    pokemonrecord.setValue( 48.271737, forKey:"latitude")
     //   pokemonrecord.setValue(-116.538831, forKey:"Longitude")
     //   self.publicDB.save(pokemonrecord) { (record :CKRecord? , error :Error?) in
  //  }
  //  }
    
    var pokemon :[Pokemon]!
    @IBOutlet weak var mapView :MKMapView!
    var locationManager :CLLocationManager!
    var pokemons: [Pokemon] = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager = CLLocationManager()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        
        self.mapView.showsUserLocation = true
        self.mapView.delegate = self
        
        self.locationManager.startUpdatingLocation()

     let pokemonURL = "https://still-wave-26435.herokuapp.com/pokemon/all"
      let url = URL(string: pokemonURL)
        
        
      URLSession.shared.dataTask(with: url!) { (data :Data?,response:URLResponse?, error :Error?) in
            
        let result = try! JSONSerialization.jsonObject(with: data!, options: []) as! [[String:Any]]
            
      for item in result {
        
        let pokemon = Pokemon()
        pokemon.imageURL = item ["imageURL"] as! String
        pokemon.latitude = item ["latitude"] as! Double
        pokemon.longitude = item ["longitude"] as! Double
        self.pokemons.append(pokemon)
        
        let annotation = PokemonAnnotation()
        annotation.title = "sss"
        
        
        annotation.coordinate = CLLocationCoordinate2D(latitude:pokemon.latitude, longitude:pokemon.longitude)
        annotation.imageURL = pokemon.imageURL
        
        DispatchQueue.main.async {
        self.mapView.addAnnotation(annotation)
            
            
        }
        
        }
        
        }.resume()
        
    }
    
                //pokemon.title = item["name"] as! String
     // self.container = CKContainer.default()
     // self.publicDB = self.container.publicCloudDatabase
      
      //  let query = CKQuery(recordType: "Pokemon", predicate: NSPredicate(value:true))
      //  self.publicDB.perform(query,inZoneWith: nil) { (records: [CKRecord]?, error : Error?) in
            
        //    if error != nil {
        //        print(error?.localizedDescription)
        //    } else {
         //       for record in records! {
          //          let pokemon = Pokemon()
        
        func mapView (_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    
      //  let pokemonAnnotation = annotation as! PokemonAnnotation
       
        
        if annotation is MKUserLocation{
            return nil
        }
    
   var pokemonAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier:"PokemonAnnotationView")
        
        if pokemonAnnotationView == nil {
            pokemonAnnotationView = PokemonAnnotationView(annotation: annotation, reuseIdentifier: "PokemonAnnotationView")
        }
    
    pokemonAnnotationView?.frame = CGRect(x: 0, y: 0 , width: 50, height: 50)
        
        
   // let imageData = try! Data(contentsOf: URL(string: pokemonAnnotation.imageURL)! )
        
      //  pokemonAnnotationView?.image = UIImage(data: imageData)
       // pokemonAnnotationView?.image = UIImage(named:"Pokemon")
        
    return pokemonAnnotationView
        
       // override func didReceiveMemoryWarning() {
        //    super.didReceiveMemoryWarning()
            }

    



}
