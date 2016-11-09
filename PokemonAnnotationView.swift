//
//  PokemonAnnotationView.swift
//  Pokemon
//
//  Created by Khalid Mohamed on 11/2/16.
//  Copyright © 2016 Khalid Mohamed. All rights reserved.
//

import UIKit
import MapKit

class PokemonAnnotationView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        let pokemonAnnotation = annotation as! PokemonAnnotation
        DispatchQueue.global().sync {
        let imageData = try? Data(contentsOf: URL(string: pokemonAnnotation.imageURL)!)
            
            if imageData != nil {
                let image = UIImage(data: imageData!)
                let imgView = UIImageView(image: image)
                
                imgView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
                DispatchQueue.main.async{
                    self.addSubview(imgView)

            }
            
           }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
 }

}
