
var protodata = {
    title: "Welcome back",
    username: "Malloc Frobnitz",
    journeys: [
        {
            "name": "Azure: Setup a three node Eventstore cluster",
            "progress": "70",
            "stepName": "Build a docker image",
            "stepState": "in progress",
            "stops": [
                {
                    "title": ""
                }
            ]
        },
        {
            "name": "Guitar: 4 chords for 1000 songs",
            "progress": "25",
            "stepName": "Learn the G-chords",
            "stepState": "next step",
            "stops": [
                {
                    "title": ""
                }
            ]
        }
    ]
};

var formatDays = function(days) {
return (days == 0) ? "Today!"
        : (days == 1) ? "Tomorrow"
        : days + " days";
}

var today = new Date(Date.now());
today.setHours(0);
today.setMinutes(0);
today.setSeconds(1);

var anniversaries =
    {
        "2015-02-22T22:11:00.000Z": "Signes birthday",
        "2009-04-04T03:42:00.000Z": "Desmonds birthday",
        "2005-07-03T18:15:00.000Z": "J+J first date",
        "2011-11-05T18:00:00.000Z": "J+J wedding day",
        "1980-06-01T08:00:00.000Z": "Jenny´s birthday",
        "1980-05-16T12:00:00.000Z": "Jonas birthday"
    };

var sorted = [];

var tempDate;
var tempAniversaryCount;
for (var anniversary in anniversaries) {
    tempAniversaryCount = 0;
    tempDate = new Date(anniversary);
    while (tempDate.getTime() < today.getTime()) {
        tempAniversaryCount += 1;
        tempDate.setFullYear(tempDate.getFullYear() + 1);
    }
    sorted[sorted.length] = {
        "title": anniversaries[anniversary],
        "original": anniversary,
        "next": tempDate.toJSON(),
        "count": tempAniversaryCount
    };
}
sorted.sort(function (a, b) {
    return new Date(a.next).getTime() - new Date(b.next).getTime();
});

var a = moment(today.toJSON());
var b = moment(sorted[0].next);

var days = b.diff(a, 'days');

// next-title

document.querySelector("#page-title").textContent = protodata.title;
document.querySelector("#page-subtitle").textContent = protodata.username;

document.querySelector("#journey_count").textContent = protodata.journeys.length;

// journey_count

var upcoming = "", journey;

for(var journeryIndex in protodata.journeys) {
    journey  =protodata.journeys[journeryIndex];
    upcoming += "<hr />" 
    upcoming += "<a href='#'>";
    upcoming += "<h4>" + journey.name + " <small>" + journey.progress  + "%</small></h4>";
    upcoming += "<h2><small>" + journey.stepState  + ":</small> " + journey.stepName + " </h2>";
    upcoming += "</a>";
}
document.querySelector("#journeys").innerHTML = upcoming;
