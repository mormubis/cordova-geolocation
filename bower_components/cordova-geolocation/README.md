_[Demo and API docs](https://adelarosab.github.io/cordova-geolocation)_

## Note:
Due to restrictions `ready` attribute is not shown into attributes table.

## &lt;cordova-geolocation&gt;

`<cordova-geolocation>` provides information about the device's location, 
such as latitude and longitude.

```html
<cordova-geolocation
    accuracy="10"
    altitude="650"
    auto
    heading="310"
    high-accuracy
    latitude="40.4928869"
    longitude="-3.8700242"
    loop
    highAccuracy
    maxAge="3000"
    ready
    speed="10"
    timestamp="1471173266"
    timeout="5000"
></cordova-geolocation>
```
### Attributes
 
#### accuracy (read-only)

Return accuracy level of the latitude and longitude coordinates in meters.

#### altitude (read-only)

Return height of the position in meters above the ellipsoid.

#### auto

If true, automatically performs watch when device is ready.

#### heading (read-only)

Return direction of travel, specified in degrees counting clockwise relative 
to the true north.

#### highAccuracy

Provides a hint that the application needs the best possible results.

#### latitude (read-only)

Return latitude in decimal degrees.

#### longitude (read-only)

Return longitude in decimal degrees.

#### loop

If true, will watch over again, every period is finished.

#### maxAge

 Accept a cached position whose age is no greater than the specified time in 
 milliseconds.

#### ready (read-only)

Return if cordova deviceready event has been fired.

#### speed (read-only)

Return current ground speed of the device, specified in meters per second.

#### timestamp (read-only)

Return creation timestamp for coordinates.

#### timeout

The maximum length of time (milliseconds) that is allowed to collect the 
coordinates.
