The purpose of this block of code is to print to the console the city and region where the photo, 
selected via standard ios image picker controller, was taken.


{% highlight ruby linenos %}
def show
  puts "Outputting a very lo-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-ong lo-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-ong line"
  @widget = Widget(params[:id])
  respond_to do |format|
    format.html # show.html.erb
    format.json { render json: @widget }
  end
end
{% endhighlight %}

{% highlight haskell linenos %}
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
