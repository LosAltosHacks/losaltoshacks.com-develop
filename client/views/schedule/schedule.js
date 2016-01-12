Controller('schedule', {
    helpers: {
        days: [
            {
                date: "Saturday, January 30th",
                scheduleItems: [
                    {time: "11:00 AM", name: "Doors Open"},
                    {time: "12:00 PM", name: "Lunch"},
                    {time: "1:00 PM", name: "Start Hacking"},
                    {time: "6:00 PM", name: "Dinner"}
                ]
            },
            {
                date: "Sunday, January 31st",
                scheduleItems: [
                    {time: "12:00 AM", name: "Midnight Snack"},
                    {time: "8:00 AM", name: "Breakfast"},
                    {time: "11:00 AM", name: "Lunch"},
                    {time: "1:00 PM", name: "Submit Hacks"},
                    {time: "4:00 PM", name: "Hackathon Ends"}
                ]
            }
        ],
    },
    rendered: function() {

    }
});
