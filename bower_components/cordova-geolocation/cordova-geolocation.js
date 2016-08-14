/*globals Polymer */
Polymer(
  {
    is: 'cordova-geolocation',

    properties: {
      /**
       * Accuracy level of the latitude and longitude coordinates in meters.
       */
      accuracy: {
        notify: true,
        readOnly: true,
        type: Number
      },

      /**
       * Height of the position in meters above the ellipsoid.
       */
      altitude: {
        notify: true,
        readOnly: true,
        type: Number
      },

      /**
       * If true, automatically performs watch when device is ready.
       */
      auto: Boolean,

      /**
       * Direction of travel, specified in degrees counting clockwise relative
       * to the true north.
       */
      heading: {
        notify: true,
        readOnly: true,
        type: Number
      },

      /**
       * Provides a hint that the application needs the best possible results.
       */
      highAccuracy: Boolean,

      /**
       * Latitude in decimal degrees.
       */
      latitude: {
        notify: true,
        readOnly: true,
        type: Number
      },

      /**
       * Longitude in decimal degrees.
       */
      longitude: {
        notify: true,
        readOnly: true,
        type: Number
      },

      /**
       * If true, will watch over again, every period is finished.
       */
      loop: {
        observer: '_observeLoop',
        type: Boolean
      },

      /**
       * Accept a cached position whose age is no greater than the specified
       * time in milliseconds.
       */
      maxAge: Number,

      /**
       * Return if cordova deviceready event has been fired.
       */
      ready: {
        computed: '_computeReady(_ready_, _paused_)',
        notify: true,
        type: Boolean
      },

      /**
       * Current ground speed of the device, specified in meters per second.
       */
      speed: {
        notify: true,
        readOnly: true,
        type: Number
      },

      /**
       * Creation timestamp for coordinates.
       */
      timestamp: {
        notify: true,
        readOnly: true,
        type: Number
      },

      /**
       * The maximum length of time (milliseconds) that is allowed to collect
       * the coordinates.
       */
      timeout: Number
    },

    observers: ['_observeReady(auto, ready)'],

    _computeReady(ready, paused) {
      return ready && !paused;
    },

    _observeLoop(loop) {
      (loop) ? this.watch() : this.clearWatch();
    },

    _observeReady(auto, ready) {
      if (auto && ready) {
        this.watch();
      }
    },

    _setLocation(location) {
      this._setTimestamp(location.timestamp);

      const coords = location.coords;

      this._setAccuracy(coords.accuracy);
      this._setAltitude(coords.altitude);
      this._setHeading(coords.heading);
      this._setLatitude(coords.latitude);
      this._setLongitude(coords.longitude);
      this._setSpeed(coords.speed);
    },

    /**
     * Stop watching the Acceleration.
     */
    clearWatch() {
      if (this.ready && this.watchId) {
        navigator.geolocation.clearWatch(this.watchId);

        this.loop = false;
        this.watchId = null;
      }
    },

    /**
     * Get the current current position when a change in position is detected.
     * If loop  is set, it gets position at regular interval.
     */
    watch() {
      if (this.ready) {
        const errorCb = this.fire.bind(this, 'cordova-geolocation-error');
        const fn = (this.loop) ? 'watchPosition' : 'getCurrentPosition';
        const optionsFn = {
          enableHighAccuracy: this.highAccuracy,
          maximumAge: this.maxAge,
          timeout: this.timeout
        };
        const successCb = this._setLocation.bind(this);

        this.watchId = navigator.geolocation[fn](successCb, errorCb, optionsFn);
      }
    }
  }
);
