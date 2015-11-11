Controller('intro', {

    helpers: {

    	title: "Los Altos Hacks",
    	location: "Microsoft Silicon Valley Campus",
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

        // if(is_chrome === false) {
        //     $.stellar();
        // } else {
        //     $("#intro").css("background-attachment", "fixed");
        // }

        var navbar = document.getElementById("nav");
        window.addEventListener("scroll", function() {
            var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
            if(scrollTop > 100) {
                navbar.style["background-color"] = "#222";
            }
            else {
                navbar.style["background-color"] = "transparent";
            }
        });
    }

});
