Controller('afterparty', {
	helpers: {

	},

	rendered: function() {

	},

	events: {
		'click #show-arrow': function() {
			$("html, body").animate({scrollTop: $("#ap-stats").offset().top}, 800);
		}
	}
});
