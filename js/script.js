function ready(fn) {
    if (document.readyState != "loading") {
        fn();
    } else {
        document.addEventListener("DOMContentLoaded", fn);
    }
}

function addClickHandlers() {
    var links = document.querySelectorAll(".scroll-anchor a");
    for (var i = 0; i < links.length; i++) {
        links[i].addEventListener("click", function (evt) {
            scrollToElement(document.querySelector(evt.target.hash), 800);
        });
    };
};

ready(addClickHandlers);
