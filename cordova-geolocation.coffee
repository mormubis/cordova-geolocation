Polymer
  is: "cordova-geolocation"

  properties:
    accuracy:
      notify: yes
      readOnly: yes
      reflectToAttribute: yes
      type: Number
    altitude:
      notify: yes
      readOnly: yes
      reflectToAttribute: yes
      type: Number
    auto:
      reflectToAttribute: yes
      type: Boolean
      value: off
    heading:
      notify: yes
      readOnly: yes
      reflectToAttribute: yes
      type: Number
    latitude:
      notify: yes
      readOnly: yes
      reflectToAttribute: yes
      type: Number
    longitude:
      notify: yes
      readOnly: yes
      reflectToAttribute: yes
      type: Number
    loop:
      reflectToAttribute: yes
      type: Boolean
      value: off
    ready:
      notify: true
      observer: "_observeReady"
      readOnly: yes
      type: Boolean
      value: no
    speed:
      notify: yes
      readOnly: yes
      reflectToAttribute: yes
      type: Number

    _observeReady: (ready) ->
      @watch() if ready

    _setLocation: (location) ->
      coords = location.coords

      @_setAccuracy coords.accuracy
      @_setAltitude coords.altitude
      @_setHeading coords.heading
      @_setLatitude coords.latitude
      @_setLongitude coords.longitude
      @_setSpeed coords.speed


    clearWatch: ->
      navigator.geolocation.clearWatch @watchId
      @watchId = null

    watch: ->
      errorCb = @fire.bind this, "cordova-geolocation-error"
      fn = if @loop then "watchPosition" else "getCurrentPosition"
      optionsFn = {@highAccuracy, @maxAge, @timeout}
      successCb = @_setLocation

      @watchId = navigator.geolocation[fn] successCb, errorCb, optionsFn if @ready
