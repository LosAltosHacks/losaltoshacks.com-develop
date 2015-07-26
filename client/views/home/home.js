Controller('home', {

    helpers: {


    },

    rendered: function() {
        initiateWaypoints();
    }

});

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

    var introWaypoint = new Waypoint({
        element: document.getElementById('intro'),
        handler: function(direction) {
            $('.links > a > li').css('color', 'white');
        },
        offset: function() {
            return 0;
        }
    });
    var scheduleWaypoint = new Waypoint({
        element: document.getElementById('schedule'),
        handler: function(direction) {
            $('.links > a > li').css('color', 'black');
        },
        offset: function() {
            return 0;
        }
    });
    var faqWaypoint = new Waypoint({
        element: document.getElementById('faq'),
        handler: function(direction) {
            $('.links > a > li').css('color', 'white');
        },
        offset: function() {
            return 0;
        }
    });
    var sponsorsWaypoint = new Waypoint({
        element: document.getElementById('sponsors'),
        handler: function(direction) {
            $('.links > a > li').css('color', 'black');
        },
        offset: function() {
            return 0;
        }
    });
}