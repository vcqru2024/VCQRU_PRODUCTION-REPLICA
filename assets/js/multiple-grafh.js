window.chartColors = {
    red: 'rgb(255, 99, 132)',
    orange: 'rgb(255, 159, 64)',
    yellow: 'rgb(255, 205, 86)',
    green: 'rgb(75, 192, 192)',
    blue: 'rgb(54, 162, 235)',
    purple: 'rgb(153, 102, 255)',
    grey: 'rgb(231,233,237)'
};
var randomScalingFactor = function () {
   
    return (Math.random() > 0.1 ? 0.2 : 1.0) * Math.round(Math.random() * 100);
};

var line1 = [10, 5, 15, 20, 25, 5, 8, 16, 26, 28, 30, 50,];

var line2 = [10, 3, 8, 9, 15, 25, 20, 10, 28, 10, 40, 60,];

var line3 = [10, 9, 12, 14, 10, 15, 20, 7, 10, 14, 18, 20,];

var MONTHS = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
var config = {
    type: 'line',
    data: {
        labels: MONTHS,
        datasets: [{
            label: "SEO",
            backgroundColor: window.chartColors.red,
            borderColor: window.chartColors.red,
            data: line1,
            fill: false,
        }, {
            label: "SMO",
            fill: false,
            backgroundColor: window.chartColors.blue,
            borderColor: window.chartColors.blue,
            data: line2,
        }, {
            label: "PPC",
            fill: false,
            backgroundColor: window.chartColors.green,
            borderColor: window.chartColors.green,
            data: line3,
        }],

    },
    options: {
        responsive: true,
        title: {
            display: true,
            fontStyle: '500',
            fontSize: 22,
            text: 'Business Chart'
        },
        tooltips: {
            mode: 'index',
            intersect: false,
        },
        hover: {
            mode: 'nearest',
            intersect: true
        },
        scales: {
            xAxes: [{
                display: true,
                scaleLabel: {
                    display: true,
                    fontStyle: '600',
                    fontSize: 16,
                    labelString: 'Time Duration in Months'
                }
            }],
            yAxes: [{
                display: true,
                scaleLabel: {
                    display: true,
                    fontStyle: '600',
                    fontSize: 16,
                    labelString: 'Growth'
                },
            }]
        }
    }
};

var ctx = document.getElementById("canvas").getContext("2d");
var myLine = new Chart(ctx, config);

var data1 = [
    randomScalingFactor(),
    randomScalingFactor(),
];

var data2 = [
    randomScalingFactor(),
    randomScalingFactor(),
];

var data3 = [
    randomScalingFactor(),
    randomScalingFactor(),
];

var ctx = document.getElementById("chart-area").getContext("2d");
var myPie = new Chart(ctx, {
    type: 'pie',
    data: {
        labels: ["SEO", "SMO", "PPC"],
        datasets: [{
            label: 'Dataset 1',
            data: data1,
            backgroundColor: [
                "#FF6384",
                "#36A2EB"
            ],
            hoverBackgroundColor: [
                "#FF6384",
                "#36A2EB"
            ],
            borderWidth: 5,
        }, {
            label: 'Dataset 2',
            data: data2,
            backgroundColor: [
                "#FF6384",
                "#36A2EB"
            ],
            hoverBackgroundColor: [
                "#FF6384",
                "#36A2EB"
            ],
            borderWidth: 5,
            },
            {
                label: 'Dataset 3',
                data: data3,
                backgroundColor: [
                    "rgb(75, 192, 192)",
                    "rgb(75, 192, 192)"
                ],
                hoverBackgroundColor: [
                    "rgb(75, 192, 190)",
                    "rgb(75, 192, 190)"
                ],
                borderWidth: 5,
            }],
    },
    options: {
        title: {
            display: true,
            text: 'User OverView',
            fontStyle: '500',
            fontSize: 22
        }
    }
});

/*
$('a[href="#pie"]').on('shown.bs.tab', function(){
  myPie.update();
});
*/





