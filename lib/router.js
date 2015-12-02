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
