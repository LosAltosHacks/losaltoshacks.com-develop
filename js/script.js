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

function setupFlickity() {
    // We don't set this in CSS because if JS is disabled, we want the images
    // to display naturally.
    document.querySelector(".winner-carousel").style.height = "400px";

    var projectName = document.querySelector(".winner-project-name"),
        flickity = new Flickity(".winner-carousel", {
        cellSelector: "img",
        imagesLoaded: true
    });

    flickity.on("select", function () {
        var image = flickity.selectedElement;
        projectName.textContent = image.alt;
        projectName.href = image.dataset.link;
    });
}

ready(setupFlickity);
