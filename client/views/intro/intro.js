Controller('intro', {

    helpers: {
        title: "Los Altos Hacks",
        location: "Microsoft SVC Building 1",
        address: "1065 La Avenida St, Mountain View",
        mapLink: "https://www.google.com/maps/place/Microsoft+SVC+Building+1/@37.4115725,-122.0735347,17z/data=!3m1!4b1!4m2!3m1!1s0x808fb75a8f4aef1d:0xc1bc0e6d308e6c78", 
        date: "January 30th-31st, 2016"
    },

    rendered: function() {
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
