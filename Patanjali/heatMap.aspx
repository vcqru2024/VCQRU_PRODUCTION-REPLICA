<%@ Page Title="" Language="C#" MasterPageFile="~/Patanjali/pfl.master" AutoEventWireup="true" CodeFile="heatMap.aspx.cs" Inherits="Patanjali_heatMap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/maps/modules/map.js"></script>
    <script src="https://code.highcharts.com/mapdata/countries/in/in-all.js"></script>
    <script src="https://code.highcharts.com/maps/modules/exporting.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <style>
        /* Optional: CSS for the chart container */
        #container {
            height: 500px; /* Adjust the height as needed */
            max-width: 600px; /* Adjust the width as needed */
            margin: 0 auto;
        }
    </style>

       <div id="container"></div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Fetch data from the API
        fetch('../Info/PatanjaliHandler.ashx?method=heatMap&companyid=Comp-1605')
            .then(response => response.json())
            .then(jsonData => {
                const stateMappings = {
                    "Andaman and Nicobar Islands": "in-an",
                    "Andhra Pradesh": "in-ap",
                    "Arunachal Pradesh": "in-ar",
                    "Assam": "in-as",
                    "Bihar": "in-br",
                    "Chandigarh": "in-ch",
                    "Chhattisgarh": "in-ct",
                    "Dadra and Nagar Haveli and Daman and Diu": "in-dn",
                    "Delhi NCT": "in-dl",
                    "Goa": "in-ga",
                    "Gujarat": "in-gj",
                    "Haryana": "in-hr",
                    "Himachal Pradesh": "in-hp",
                    "Jammu and Kashmir": "in-jk",
                    "Jharkhand": "in-jh",
                    "Karnataka": "in-ka",
                    "Kerala": "in-kl",
                    "Ladakh": "in-la",
                    "Lakshadweep": "in-ld",
                    "Madhya Pradesh": "in-mp",
                    "Maharashtra": "in-mh",
                    "Manipur": "in-mn",
                    "Meghalaya": "in-ml",
                    "Mizoram": "in-mz",
                    "Nagaland": "in-nl",
                    "Odisha": "in-or",
                    "Puducherry": "in-py",
                    "Punjab": "in-pb",
                    "Rajasthan": "in-rj",
                    "Sikkim": "in-sk",
                    "Tamil Nadu": "in-tn",
                    "Telangana": "in-tg",
                    "Tripura": "in-tr",
                    "Uttar Pradesh": "in-up",
                    "Uttarakhand": "in-ut",
                    "West Bengal": "in-wb"
                    // Add mappings for other states as needed
                };

                // Process fetched data
                const processedData = Highcharts.geojson(Highcharts.maps['countries/in/in-all']);
 debugger;
                processedData.forEach(state => {
                    const stateName = state.properties['name'];
                    const stateCode = stateMappings[stateName];
                    const data = jsonData.find(item => item.State === stateName.toUpperCase());
 debugger;
                    if (data) {
                        state.value = data.Success; // Display Success data on the map
                        state.Unsuccess = data.Repeated; // Store Unsuccess data for tooltip
                        state.ActiveUsers = data['Active Users']; // Store Active Users data for tooltip
                    }
                });

                // Create the heatmap chart
                Highcharts.mapChart('container', {
                    chart: {
                        map: 'countries/in/in-all'
                    },
                    title: {
                        text: 'Patanjali Foods Ltd. Heatmap',
                        style: {
                            color: '#333',
                            fontSize: '24px'
                        }
                    },
                    mapNavigation: {
                        enabled: true, // Enable map navigation
                        enableButtons: true, // Enable zoom buttons
                        enableMouseWheelZoom: true, // Enable mouse wheel zoom
                        enableDoubleClickZoomTo: true // Enable double click zoom
                    },
                    colorAxis: {
                        min: 0,
                        type: 'linear', // Use linear color axis
                        minColor: '#f7f7f7', // Light gray for minimum value
                        maxColor: '#ff6464', // Red for maximum value
                        labels: {
                            style: {
                                color: '#333' // Label color
                            }
                        },
                        title: {
                            text: 'Success',
                            style: {
                                color: '#333' // Title color
                            }
                        }
                    },
                    tooltip: {
                        formatter: function () {
                            return '<b>' + this.point.name + '</b><br>' +
                                'Success: ' + this.point.value + '<br>' +
                                'Unsuccess: ' + this.point.Unsuccess + '<br>' +
                                'Active Users: ' + this.point.ActiveUsers;
                        }
                    },
                    series: [{
                        name: 'Success',
                        data: processedData,
                        states: {
                            hover: {
                                color: '#BADA55'
                            }
                        },
                        dataLabels: {
                            enabled: true,
                            format: '{point.name}'
                        }
                    }]
                });
            })
            .catch(error => {
                console.error('Error fetching data:', error);
            });
    });
</script>
</asp:Content>

