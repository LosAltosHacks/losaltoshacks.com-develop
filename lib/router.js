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

	this.route('apply', {
		path: '/apply',
		template: 'apply-template'
	});
});

// Router.route('apply', function() {
// 	window.location.replace("https://losaltoshacks.typeform.com/to/ixL15U");
// })
