$("#show-arrow").click(function () {
    $("html, body").animate({scrollTop: $("#ap-stats").offset().top}, 800);
});


var spinner = new Spinner($(".spinner"));
var $email = $(".email");
var $submit = $(".submit");

$email.on("change paste keyup", function() {
    $email.removeClass("faded");
});

$email.keypress(function (e) {
    if ((e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)) {
        $submit.click();
    }
});

$submit.click(function (e) {
    var email = $email.val();

    spinner.start(function (finish) {
        $.ajax({
            type: "POST",
            url: "http://api.losaltoshacks.com/subscribe",
            data: JSON.stringify({ email: email }),
            contentType: "application/json",
            success: function() {
                finish(true);
                $email.addClass("faded");
            },
            error: function() {
                finish(false);
            }
        })
    })
});
