---
layout: post
title: Get location of selected photo Swift
---

The purpose of this block of code is to print to the console the city and region where the photo, selected via standard ios image picker controller, was taken.  


In this example I used ALAssets from AssetsLibrary.  


{% highlight swift linenos %}
//UIImagePickerControllerDelegate Methods
func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: NSDictionary!){
    let library = ALAssetsLibrary()
    let URL: AnyObject? = info["UIImagePickerControllerReferenceURL"]
    var error: NSError?
    library.assetForURL(URL as NSURL, resultBlock: { (asset) -> Void in
        let location = asset.valueForProperty(ALAssetPropertyLocation) as? CLLocation
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location!) { (data, error) -> Void in
            let address = data[0].addressDictionary!
            let city = address[kABPersonAddressCityKey] as  NSString!
            let state = address[kABPersonAddressStateKey] as  NSString!
            println(city, state)
        }
    }) { (error) -> Void in
        println(error)
    }
}
{% endhighlight %}
