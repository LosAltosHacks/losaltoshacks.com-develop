
var faqs = [
	{
		question: "What is Los Altos Hacks?",
		answer: "A hackathon is an event where people get together and code an entirely new project. At Los Altos Hacks, you will have 24 hours to make your idea a reality."
	},
	{
		question: "Who can participate?",
		answer: "Students from all high schools, not just Los Altos High School, can participate. If you’ve already graduated from high school, you can’t participate, but you can come help mentor others."
	},
	{
		question: "What should I bring? Will I need my own laptop?",
		answer: "Bring a valid student ID for admission and anything else you might need for the weekend, such as a laptop, phone, or charger. Power strips, ethernet cables, sleeping bags, and toiletries are highly recommended."
	},
	{
		question: "When can I apply and how will I know I’ve been accepted?",
		answer: "Applications will begin early October, and decisions will be sent out by late October. We are accepting people regardless of experience, so you can participate even if you can’t code."
	},
	{
		question: "How do I form or join a team?",
		answer: "You can either specify your team on the application or form teams at the hackathon, where we’ll have a session for you to meet others. Each team can have a maximum of 4 people."
	},
	{
		question: "Can I get travel reimbursements?",
		answer: "Travel reimbursements will be provided on a case-by-case basis. Contact us at <a href=\"mailto:info@losaltoshacks.com\" class=\"\" id=\"info-email-anchor\">info@losaltoshacks.com</a>."

	}
];

Controller('faq', {
		helpers: {

			faqs: faqs

		},

		rendered: function() {

		}
});
