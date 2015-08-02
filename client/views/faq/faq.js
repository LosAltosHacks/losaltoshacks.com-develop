
var frequentlyAskedQuestions = [
	{
		question: "question 1",
		answer: "answer 1"
	},
	{
		question: "question 2",
		answer: "answer 2"
	},
	{
		question: "question 3",
		answer: "qnswer 3"
	},
	{
		question: "question 4",
		answer: "qnswer 4"
	},
	{
		question: "question 5",
		answer: "answer 5"
	},
	{
		question: "test",
		answer: "test"
	}
]



Controller('faq', {
		helpers: {

			faqs: frequentlyAskedQuestions
			
		},

		rendered: function() {

		}
})