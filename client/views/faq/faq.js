
var faqs = [
	{
		question: "What is Los Altos Hacks?",
		answer: "Los Altos Hacks is the first <a href=\"https://medium.com/essays-by-kern/what-is-a-hackathon-c2162b893b0a\">hackathon</a> run by students from Los Altos High School. A hackathon is an event where people can code a project together. At Los Altos Hacks, you will have 24 hours to make your idea a reality."
	},
	{
		question: "Who can participate?",
		answer: "Any high school student can participate. If you’ve already graduated from high school, you can’t participate, but you can come help mentor others."
	},
	{
		question: "Does this cost money?",
		answer: "No! Los Altos Hacks is free for all participants — all food, swag, and other costs are covered."
	},
	{
		question: "What if I can't code?",
		answer: "No problem! We are accepting people regardless of experience. Plus, we'll have workshops where you can learn."
	},
	{
		question: "What should I bring? Will I need my own laptop?",
		answer: "Bring a valid student ID for admission and your laptop, phone, chargers, etc. We will <em>not</em> provide laptops or chargers for you. Power strips, ethernet cables, sleeping bags, and toiletries are highly recommended."
	},
	{
		question: "How do I form or join a team?",
		answer: "You can either specify your team on the application or form teams at the hackathon, where we’ll have a session for you to meet others. Each team can have a maximum of 4 people."
	},
	{
		question: "Do you have a code of conduct?",
		answer: "Yes. We expect all participants to read and follow the <a href='https://docs.google.com/document/d/1OdIVefNLUfE9CLe-B8WuDZIPyqRaJ6GZO0KjBfrJOqc/edit'>Hacker Fund</a> and <a href='http://static.mlh.io/docs/mlh-code-of-conduct.pdf'>MLH</a> Code of Conducts. You can electronically sign (with your parents) at <a href='http://bit.ly/LosAltosHacksParentPacket'>this HelloSign link</a>.  You will not be let into the hackathon without the packet."
	},
	{
		question: "Is there a privacy policy?",
		answer: "Yes, you are under Hacker Fund's privacy policy.  "

	},
	{
		question: "What if I still have a question?",
		answer: "Contact us at <a href=\"mailto:info@losaltoshacks.com\" class=\"\" id=\"info-email-anchor\">info@losaltoshacks.com</a>."
	}

];

Controller('faq', {
	helpers: {

		faqs: faqs

	},

	rendered: function() {

	}
});
