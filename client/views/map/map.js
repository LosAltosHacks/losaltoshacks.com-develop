Controller('map', {

	helpers: {
		exampleMapOptions: function() {
	      // Make sure the maps API has loaded
	      if (GoogleMaps.loaded()) {
             //Not sure if this should go here
             GoogleMaps.ready('exampleMap', function(map) {
                var marker = new google.maps.Marker({
                    animation: google.maps.Animation.DROP,
                    position: map.options.center,
                    title: "Hillview Community Center",
                    map: map.instance
                });
             });
	        // Map initialization options
	        return {
	          center: new google.maps.LatLng(37.380323, -122.110906),
	          zoom: 12,
	          scaleControl: true,
	      	 scrollwheel: false
	        };
	      }
	    },

	},

	rendered: function() {
		initMap();
	}

});

function initMap() {
	if (Meteor.isClient) {
	  Meteor.startup(function() {
	    GoogleMaps.load();
	  });

	  // Template.body.onCreated(function() {
	  //   // We can use the `ready` callback to interact with the map API once the map is ready.
	  //   GoogleMaps.ready('exampleMap', function(map) {
	  //     // Add a marker to the map once it's ready
	  //     var marker = new google.maps.Marker({
	  //       position: map.options.center,
	  //       map: map.instance
	  //     });
	  //   });
	  // });
	}
}
