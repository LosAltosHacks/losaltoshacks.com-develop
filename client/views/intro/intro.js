Controller('intro', {

    helpers: {

    	title: "Los Altos Hacks",
    	location: "Hillview Community Center",
	date: "January 30th-31th, 2016"

    },

    rendered: function() {
        // setupAffix();
        
        $(".nav-menu").click(function() {
            $("#nav-sections").show();
            setTimeout(function() {
              $("#nav-sections").addClass("active");
            }, 50);
        }); 

        var is_chrome = navigator.userAgent.toLowerCase().indexOf('chrome') > -1;

        if(is_chrome === false) {
            $.stellar();
        } else {
            $("#intro").css("background-attachment", "fixed");
        }
    }

});
