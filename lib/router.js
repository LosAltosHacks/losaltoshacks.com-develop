// routes

Router.configure({
});


Router.map( function () {

	// homepage
	this.route('home', {

		path: '/',
		template: 'home'

	});

	this.route('scavenger', {
		path: '/scavenger',
		template: 'scavenger'
	});
});
