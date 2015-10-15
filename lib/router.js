// routes

Router.configure({
//	loadingTemplate: '',
//	notFoundTemplate: '',
//	layoutTemplate: '',
	fastRender: true,
//	onAfterAction: function () {
//		document.title = ''
//	}
});


Router.map( function () {

	// homepage
	this.route('home', {

		path: '/',
		template: 'home'

	});
});

Router.route('apply', function() {
	window.location.replace("https://losaltoshacks.typeform.com/to/ixL15U");
})
