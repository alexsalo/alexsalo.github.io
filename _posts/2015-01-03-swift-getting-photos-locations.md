---
layout: post
title: Get location of selected photo Swift
---

In the previos post I tried to access location data using AssetsLibrary. However this method is depreciated, today we will try to use PHAsset from Photos framework

So the code of block below retrieves all the assets of type. Image and prints location info if available


{% highlight swift linenos %}
import UIKit
import Photos
import CoreMedia
import CoreLocation
import AddressBook

//fetch all photo assets from device
if let allAssets = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: nil){    
    //enumerate through all assets efficiently doing the block of code
    allAssets.enumerateObjectsUsingBlock({asset, index, stop in
        
        //optional unwrapping to make sure assets have what we need
        if let ass = asset as? PHAsset{
            if let location = ass.location{                
                println(location)                
            }else{
                println("No location for this asset")
            }
        }else{
            println("Error while converting to PHAsset")
        }
    })
    println("Finished running location getter")
}else{
    println("Error with fetching the assets")
}
{% endhighlight %}

Then, to display the actual address instead of location coordinates we can use CLgeodecoder 

{% highlight swift linenos %}
import CoreLocation
import AddressBook

//used to convert coordinates to the physical address
let geocoder = CLGeocoder()

//request Apple server to geodecode the coordinates
//works async, be careful!
geocoder.reverseGeocodeLocation(location) { (data, error) -> Void in
    
    //get address and extract city and state
    let address = data[0].addressDictionary!
    let city = address[kABPersonAddressCityKey] as String
    let state = address[kABPersonAddressStateKey] as String
    
    //unique id for the place - need to be carefully taken care of
    let place = city + ", " + state
    prinln(place)
}
{% endhighlight %}

All this works great except Apple restricts the amount of requests to the server for geodecoding. Hope that helps.
