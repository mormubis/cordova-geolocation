Polymer
  is: "cordova-geolocation"

  properties:
    ### Accuracy level of the latitude and longitude coordinates in meters. ###
    accuracy:
      notify: yes
      readOnly: yes
      reflectToAttribute: yes
      type: Number
    ### Height of the position in meters above the ellipsoid. ###
    altitude:
      notify: yes
      readOnly: yes
      reflectToAttribute: yes
      type: Number
    ### If true, automatically performs watch when device is ready.  ###
    auto:
      reflectToAttribute: yes
      type: Boolean
      value: off
    ### Direction of travel, specified in degrees counting clockwise relative to
   the true north. ###
    heading:
      notify: yes
      readOnly: yes
      reflectToAttribute: yes
      type: Number
    ### Latitude in decimal degrees. ###
    latitude:
      notify: yes
      readOnly: yes
      reflectToAttribute: yes
      type: Number
    ### Longitude in decimal degrees. ###
    longitude:
      notify: yes
      readOnly: yes
      reflectToAttribute: yes
      type: Number
    ### If true, will watch over again, every period is finished. ###
    loop:
      observer: "_observeLoop"
      reflectToAttribute: yes
      type: Boolean
      value: off
    ### Return if cordova deviceready event has been fired. ###
    ready:
      notify: true
      observer: "_observeReady"
      readOnly: yes
      type: Boolean
      value: no
    ### Current ground speed of the device, specified in meters per second. ###
    speed:
      notify: yes
      readOnly: yes
      reflectToAttribute: yes
      type: Number

    _observeLoop: ->
      if @loop then @watch() else @clearWatch()

    _observeReady:  ->
      @watch() if @auto

    _setLocation: (location) ->
      coords = location.coords

      @_setAccuracy coords.accuracy
      @_setAltitude coords.altitude
      @_setHeading coords.heading
      @_setLatitude coords.latitude
      @_setLongitude coords.longitude
      @_setSpeed coords.speed

    ### Stop watching the Acceleration ###
    clearWatch: ->
      if @ready and @watchId?
        navigator.geolocation.clearWatch @watchId
        @loop = false
        @watchId = null

    ### Get the current current position when a change in position is detected.
   If loop  is set, it gets position at regular interval. ###
    watch: ->
      errorCb = @fire.bind this, "cordova-geolocation-error"
      fn = if @loop then "watchPosition" else "getCurrentPosition"
      optionsFn = {@highAccuracy, @maxAge, @timeout}
      successCb = @_setLocation

      @watchId = navigator.geolocation[fn] successCb, errorCb, optionsFn if @ready

