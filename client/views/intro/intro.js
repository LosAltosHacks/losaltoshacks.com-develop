Controller('intro', {

    helpers: {

    	title: "Los Altos Hacks",
    	location: "Hillview Community Center",
    	date: "Jan. 30-31, 2016"

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
