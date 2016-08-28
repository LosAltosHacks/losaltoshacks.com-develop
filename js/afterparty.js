$("#show-arrow").click(function() {
    $("html, body").animate({scrollTop: $("#ap-stats").offset().top}, 800);
});

$("#email").keypress(function (e) {
    if ((e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)) {
        $('#submit').click();
    }
});

$("#submit").click(function (e) {
    var email = $("#email").val();
    $.ajax({
        type: "POST",
        url: "http://api.losaltoshacks.com/subscribe",
        data: JSON.stringify({ email: email }),
        contentType: "application/json"
    })
});
