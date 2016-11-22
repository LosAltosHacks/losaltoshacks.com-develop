$(document).ready(function(){
    $("#navbar a").click(function () {
        $("html, body").animate({scrollTop: $($(this).attr("href")).offset().top}, 800);
    });

    // var bg = new Background(20);
});


// var Background = function(sideLength) {
//     this.canvas = document.getElementById("canvas");
//     this.sideLength = sideLength;
//     this.init();
// };
//
// Background.prototype = {
//     init: function() {
//         this.context = this.canvas.getContext("2d");
//
//         this.canvas.width = window.innerWidth;
//         this.canvas.height = window.innerHeight;
//
//         this.numRows = Math.floor(this.canvas.width / this.sideLength) + 1;
//         this.numCols = Math.floor(this.canvas.height / this.sideLength) + 1;
// 
//         console.log(this.numRows, this.numCols);
//
//         // this.context.fillRect(0, 0, this.canvas.width, this.canvas.height);
//         for(var i = 0; i < this.numRows; i++) {
//             for(var j = 0; j < this.numCols; j++) {
//                 this.context.fillStyle = randomColor({
//                    luminosity: 'dark',
//                    format: 'rgba' // e.g. 'rgba(9, 1, 107, 0.6482447960879654)'
//                 });
//                 this.context.fillRect(i * this.sideLength, j * this.sideLength,
//                                       this.sideLength, this.sideLength);
//             }
//         }
//     },
// }
