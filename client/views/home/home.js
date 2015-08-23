Controller('home', {

    helpers: {


    },

    rendered: function() {
        initiateWaypoints();
        // setupLinkToggle();
    }

});


// function setupLinkToggle() {

//     $(".links > a").click(function() {
//       // remove classes from all

//       console.log("clicked");
//       $(".links > a").removeClass("active");
//       // add class to the one we clicked
//       $(this).addClass("active");
//    });

// }


function initiateWaypoints() {

    // Bind to the click of all links with a #hash in the href
    $('a[href^="#"]').click(function(e) {
        // Prevent the jump and the #hash from appearing on the address bar
        e.preventDefault();
        // Scroll the window, stop any previous animation, stop on user manual scroll
        // Check https://github.com/flesler/jquery.scrollTo for more customizability
        $(window).stop(true).scrollTo(this.hash, {
            duration: 800,
            interrupt: true
        });
    });
}