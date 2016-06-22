$(document).ready(function() {
    $("#show-arrow").click(function() {
        $("html, body").animate({scrollTop: $("#ap-stats").offset().top}, 800);
    });
});
