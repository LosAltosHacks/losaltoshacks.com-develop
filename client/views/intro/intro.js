Controller('intro', {

    helpers: {

    	title: "Los Altos Hacks",
    	location: "Microsoft Silicon Valley Campus",
	    date: "January 30th-31st, 2016"

    },

    rendered: function() {
        // setupAffix();

        $(".nav-menu").click(function() {
            $("#nav-sections").show();
            setTimeout(function() {
              $("#nav-sections").addClass("active");
            }, 50);
        });
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
