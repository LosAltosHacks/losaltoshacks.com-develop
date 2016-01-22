Controller('schedule', {
    helpers: {
        days: [
            {
                date: "Saturday, January 30th",
                scheduleItems: [
                    {time: "9:00 AM", name: "Sponsor and Mentor Check In", location:"Lobby"},
                    {time: "10:30 AM", name: "Hackers Check In", location:"Lobby"},
                    {time: "11:30 AM", name: "Team Mixer", location:"Saturn"},
                    {time: "12:00 PM", name: "Opening Ceremony", location:"Galileo"},
                    {time: "1:00 PM", name: "Hacking Starts", location:"Everywhere"},
                    {time: "1:00 PM", name: "Lunch", location:"Cosmic Cafe"},
                    {time: "1:30 PM", name: "How to Get Started With Python (Microsoft)", location:"Saturn"},
                    {time: "1:30 PM", name: "Gotta Code 'Em All (Make School)", location:"Nebula"},
                    {time: "2:30 PM", name: "How to Make a Windows 10 App for Beginners", location:"Saturn"},
                    {time: "3:30 PM", name: "Hardware Hack: Connecting an IoT device to the cloud", location:"Saturn"},
                    {time: "3:30 PM", name: "Quick Steps to a MVP (Altacode)", location:"Nebula"},
                    {time: "4:00 PM", name: "Design Hacks for Programmers (Make School)", location:"Nebula"},
                    {time: "4:30 PM", name: "FIRST Robotics", location:"Saturn"},
                    {time: "5:00 PM", name: "Cheater Cheater (Microsoft)", location:"Nebula"},
                    {time: "6:00 PM", name: "Cup Stacking", location:"Cosmic Cafe"},
                    {time: "6:30 PM", name: "Dinner", location:"Cosmic Cafe"},
                    {time: "7:30 PM", name: "Break into Tech (Make School)", location:"Nebula"},
                    {time: "8:30 PM", name: "Onesie Meetup", location:"Saturn"},
                    {time: "9:00 PM", name: "Light Saber Battle", location:"Outside"},

                ]
            },
            {
                date: "Sunday, January 31st",
                scheduleItems: [
                    {time: "12:00 AM", name: "Midnight Snack", location:"Cosmic Cafe"},
                    {time: "2:00 AM", name: "Smash Tournament (?)", location:"TBD"},
                    {time: "8:00 AM", name: "Breakfast", location:"Cosmic Cafe"},
                    {time: "10:00 AM", name: "Submissions to Devpost", location:"Everywhere"},
                    {time: "11:00 AM", name: "Lunch", location:"Cosmic Cafe"},
                    {time: "12:00 PM", name: "Judging Expo", location:"Mercury/Saturn/Jupiter"},
                    {time: "2:00 PM", name: "Closing Ceremony", location:"Galileo"},
                ]
            }
        ],
    },
    rendered: function() {

    }
});
