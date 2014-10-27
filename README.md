# Death Certificate Generator

This project is a tool to create a death certificate by taking form inputs and generating a PDF file using [Prawn](http://prawnpdf.org/). The application is built with Ruby on [Sinatra](http://www.sinatrarb.com/), and utilizes [Sinatra AssetPack](http://ricostacruz.com/sinatra-assetpack/) to incorporate both SASS and CoffeeScript.

The app is meant to be lightweight, and minimize dependencies. It pulls in the [area](https://rubygems.org/gems/area) gem for geocoding zip codes, but does not use jQuery or other JavaScript libraries.

### Running the Application

You can run the app like any other Sinatra [modular application](http://www.sinatrarb.com/intro.html#Modular%20vs.%20Classic%20Style), by running from the project directory:

```
rackup -p 4567
```

### Example Output

![](certificate.pdf)

### TODO

There are probably not too many features that will be added. The idea is to keep things simple, so helpful refinements are most likely. A happy path test using rspec would probably be the next step to ensure basic functionality continues to work.
