
var frequentlyAskedQuestions = [
	{
		question: "What is a hackathon?",
		answer: "A hackathon is an event where people can get together and code an entirely new project. Los Altos Hacks will give you roughly 24 hours to make your idea become a reality."
	},
	{
		question: "Who can participate?",
		answer: "All high school students can participate. However, university students and those already graduated can come help mentor."
	},
	{
		question: "I'm not from Los Altos High School, can I still participate?",
		answer: "Yes! Any students from all high schools can participate. You do need a student id, though."
	},
	{
		question: "What should I bring? Will I need my own laptop?",
		answer: "All attendees are required to bring a valid student ID, which will be checked at registration. Bring your laptop, phone, hardware, chargers, or anything else you need for the weekend, since the Los Altos Hacks team will not be able to provide these for you. Power strips, ethernet cords, sleeping bags, and toiletries are highly recommended."
	},
	{
		question: "When and how will I know that I’ve been accepted?",
		answer: "Applications will go live during early October, and decisions will be sent out by late October.\nPlease keep in mind that we are not only accepting those with coding abilities, so if you can’t code, that’s totally fine. We’re looking to put on a hackathon for people with differing skill levels."
	},
	{
		question: "How do I form or join a team?",
		answer: "You can either apply with your friends and specify on the application, or you can form teams the day of. If you don’t have a team, don’t worry! We’ll have a session where you can meet others and form teams. The maximum amount of people on a team is 4 people."
	}
];



Controller('faq', {
		helpers: {

			faqs: frequentlyAskedQuestions

		},

		rendered: function() {

		}
});