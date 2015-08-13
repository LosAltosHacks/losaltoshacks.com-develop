Controller('intro', {

    helpers: {

    	title: "Los Altos Hacks",
    	description: "A 24-hour hackathon",
    	location: "Hillview Community Center",
    	date: "January 30 - 31, 2016"

    },

    rendered: function() {
        // setupAffix();
        var is_chrome = navigator.userAgent.toLowerCase().indexOf('chrome') > -1;

        if(is_chrome === false) {
            $.stellar();
        } else {
            $("#intro").css("background-attachment", "fixed");
        }
    }

});
