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
            // If preventDefault isn't called, the browser will scroll to the
            // element before our animation starts. Then, when our animation
            // starts and scrolls the page a bit, the page will "jump" back to
            // just after where it started. This is because the browser already
            // scrolled the page, so what should be a small step turns into a
            // leap. Calling preventDefault stops the browser from scrolling
            // before our animation, and thus prevents a flash from occuring.
            evt.preventDefault();
            scrollToElement(document.querySelector(evt.target.hash), 800);
        });
    };
};

ready(addClickHandlers);
