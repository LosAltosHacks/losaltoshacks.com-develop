$(document).ready(function(){
    // $("#navbar").sticky({
    //     topSpacing: 0,
    //     responsiveBreakpoint: 558
    // });

    $("#navbar a").click(function () {
        $("html, body").animate({scrollTop: $($(this).attr("href")).offset().top}, 800);
    });
});
