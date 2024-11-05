<%@ Page Title="" Language="C#" MasterPageFile="~/Patanjali/pfl.master" AutoEventWireup="true"
    CodeFile="dashboard.aspx.cs" Inherits="Patanjali_dashboard" %>
    <%@ Register
        Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
        Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
        <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
            <script src="https://code.highcharts.com/highcharts.js"></script>
            <script src="https://code.highcharts.com/maps/modules/map.js"></script>
            <script src="https://code.highcharts.com/mapdata/countries/in/in-all.js"></script>
            <script src="https://code.highcharts.com/maps/modules/exporting.js"></script>
        </asp:Content>
        <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
            <div class="dashboard-header">
                <div class="position-relative">
                    <div class="row">
                        <div class="col-lg-8">
                            <h4 id="greeting"></h4>
                            <h1 id="licompname" runat="server"></h1>
                        </div>
                        <div class="col-lg-4 text-end">
                            <p id="lastlogin" runat="server"></p>
                        </div>
                    </div>
                </div>
            </div>
            <!--  -->
            <div class="home-section">
                <div class="dashboard-top-cards">
                    <div class="row row-cols-xxl-4 row-cols-xl-4 row-cols-lg-4 row-cols-md-2 row-cols-1 g-4">
                        <div class="col d-flex">
                            <div class="card">
                                <div class="card-body">
                                    <ul>
                                        <li>
                                            <h6 class="card-title">
                                                <asp:Label runat="server">Generated Codes</asp:Label>
                                            </h6>
                                            <h2 class="text-success">
                                                <asp:Label ID="lbltotalcode" runat="server">
                                                </asp:Label>
                                            </h2>
                                        </li>
                                        <li>
                                            <img src="assets/img/Generated-Codes.svg" alt="Generated Codes">
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col d-flex">
                            <div class="card">
                                <div class="card-body">
                                    <ul>
                                        <li>
                                            <h6 class="card-title">
                                                <asp:Label runat="server">Checked Code</asp:Label>
                                            </h6>
                                            <h2 class="text-danger">
                                                <asp:Label ID="lblttlusedcode" runat="server">
                                                </asp:Label>
                                            </h2>
                                        </li>
                                        <li>
                                            <img src="assets/img/Checked-Code.svg" alt="Generated Codes">
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col d-flex">
                            <div class="card">
                                <div class="card-body">
                                    <ul>
                                        <li>
                                            <h6 class="card-title">
                                                <asp:Label runat="server">Registered User</asp:Label>
                                            </h6>
                                            <h2 class="text-primary">
                                                <asp:Label ID="lblttluser" runat="server">
                                                </asp:Label>
                                            </h2>
                                        </li>
                                        <li>
                                            <img src="assets/img/Registered-User.svg" alt="Generated Codes">
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col d-flex">
                            <div class="card">
                                <div class="card-body">
                                    <ul>
                                        <li>
                                            <h6 class="card-title">
                                                <asp:Label runat="server">Registered Product</asp:Label>
                                            </h6>
                                            <h2 class="text-warning">
                                                <asp:Label ID="lblttlproduct" runat="server">
                                                </asp:Label>
                                            </h2>
                                        </li>
                                        <li>
                                            <img src="assets/img/Registered-Product.svg" alt="Generated Codes">
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                 <div class="row g-14">
                        <div class="col-4">
                           <label class="form-label">form date</label>
                            <input type="date" id="txtfromdate" runat="server" class="form-control"  />
                             
                        </div> 
                  <div class="col-4">
                           <label class="form-label">To Date</label>
                            <input type="date" id="txtTodate" runat="server" class="form-control"  />
                             
                        </div> 
                <div class="col-4" style="margin-top:2.7%">
                    
                    <asp:Button ID="btnFiler" runat="server" class="btn btn-primary" OnClick="btnFiler_Click"  Text="Search"/>
                       
                    
                </div>
               </div>   

                <!-- pie charts -->
                <div class="graphical-reports">
                    <div class="row g-4">
                        <div class="col-lg-6 col-md-12 d-flex">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Patanjali Foods Ltd. Heatmap</h5>
                                    <div id="container">
                                        
                                    </div>

                                    
                                </div>
                                <div class="position-absolute bottom-0 translate-middle start-50">
                                        <asp:Button ID="Button1" runat="server" Text="Download" OnClick="Button1_Click" CssClass="btn btn-primary" />
                                    </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-12 d-flex">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Checked Code v/s Unchecked Code</h5>
                                    <asp:Chart ID="Chart1" runat="server" CssClass="piewieth" BorderlineWidth="0"
                                        Height="475px" Palette="None" PaletteCustomColors="" Width="539px"
                                        BorderlineColor="64, 0, 64">
                                        <Titles>
                                            <asp:Title Alignment="BottomCenter" Font="bold" Name="Items" />
                                        </Titles>
                                        <Legends>
                                            <asp:Legend Alignment="Center" Docking="Right" IsTextAutoFit="False"
                                                Name="Default" LegendStyle="Table" />
                                        </Legends>
                                        <Series>
                                            <asp:Series Name="Default" />
                                        </Series>
                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1" BorderWidth="0" />
                                        </ChartAreas>
                                    </asp:Chart>
                                     <div class="position-absolute bottom-0 translate-middle start-50">
                                        <asp:Button ID="btn_download" runat="server" Text="Download" OnClick="btn_download_Click" CssClass="btn btn-primary" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-12 d-flex">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">State wise Code check Statistics</h5>
                                    <asp:Chart ID="Chart2" runat="server" CssClass="piewieth" BorderlineWidth="0"
                                        Height="475px" Palette="None" PaletteCustomColors="" Width="539px"
                                        BorderlineColor="64, 0, 64">
                                        <Titles>
                                            <asp:Title ShadowOffset="10" Name="Items" />
                                        </Titles>
                                        <Legends>
                                            <asp:Legend Alignment="Center" Docking="Right" IsTextAutoFit="False"
                                                Name="Default" LegendStyle="Table" />
                                        </Legends>
                                        <Series>
                                            <asp:Series Name="Default" />
                                        </Series>
                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1" BorderWidth="0" />
                                        </ChartAreas>
                                    </asp:Chart>
                                     <div class="position-absolute bottom-0 translate-middle start-50">
                                        <asp:Button ID="btnStatewiseCodeCheck" runat="server" Text="Download" OnClick="btnStatewiseCodeCheck_Click" CssClass="btn btn-primary" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-12 d-flex">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">State wise Users Statistics</h5>
                                    <asp:Chart ID="Chart3" runat="server" CssClass="piewieth" BorderlineWidth="0"
                                        Height="475px" Palette="None" PaletteCustomColors="" Width="539px"
                                        BorderlineColor="64, 0, 64">
                                        <Titles>
                                            <asp:Title ShadowOffset="0" Font="bold" TextStyle="Embed" Name="Items" />
                                        </Titles>
                                        <Legends>
                                            <asp:Legend Alignment="Center" Docking="Right" IsTextAutoFit="False"
                                                Name="Default" LegendStyle="Table" />
                                        </Legends>
                                        <Series>
                                            <asp:Series Name="Default" />
                                        </Series>
                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1" BorderWidth="0" />
                                        </ChartAreas>
                                    </asp:Chart>
                                      <div class="position-absolute bottom-0 translate-middle start-50">
                                        <asp:Button ID="btnCodecheckStatics" runat="server" Text="Download" OnClick="btnCodecheckStatics_Click" CssClass="btn btn-primary" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12 d-flex">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Code Check Statistics-Product-Specific</h5>
                                    <asp:Chart ID="Chart4" runat="server" CssClass="piewieth"
                                        BorderlineColor="64, 0, 64" style="height:300px!important" Palette="None" PaletteCustomColors=""
                                        Width="539px">
                                        <Series>
                                            <asp:Series Name="Series1">
                                            </asp:Series>
                                        </Series>
                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                        
                                    </asp:Chart>
                                    <div class="position-absolute start-50 bottom-0">
                                        <asp:Button ID="btnFilersChart" runat="server" Text="Download" OnClick="btnFilersChart_Click" CssClass="btn btn-primary" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end -->
            </div>
            <script>
                // Get the current hour
                const hour = new Date().getHours();

                // Greeting function
                function greeting() {
                    if (hour >= 5 && hour < 12) {
                        return "Good morning!";
                    } else if (hour >= 12 && hour < 18) {
                        return "Good afternoon!";
                    } else {
                        return "Good evening!";
                    }
                }

                // Call the greeting function
                const message = greeting();
                // Display the greeting message in the HTML document
                document.getElementById('greeting').innerText = message;

            </script>
             <script>
                 document.addEventListener('DOMContentLoaded', function () {
                     // Fetch data from the API
                     fetch('../Info/PatanjaliHandler.ashx?method=heatMap&companyid=Comp-1693')
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

                             processedData.forEach(state => {
                                 const stateName = state.properties['name'];
                                 const stateCode = stateMappings[stateName];
                                 const data = jsonData.find(item => item.State === stateName);

                                 if (data) {
                                     state.value = data.Success !== undefined ? data.Success : 0; // Replace undefined with 0
                                     state.Unsuccess = data.Unsuccess !== undefined ? data.Unsuccess : 0; // Replace undefined with 0
                                     state.ActiveUsers = data['Active Users'] !== undefined ? data['Active Users'] : 0; // Replace undefined with 0
                                 } else {
                                     // If no data found for the state, set defaults
                                     state.value = 0;
                                     state.Unsuccess = 0;
                                     state.ActiveUsers = 0;
                                 }

                                 //if (data) {
                                 //    state.value = data.Success; // Display Success data on the map
                                 //    state.Unsuccess = data.Unsuccess; // Store Unsuccess data for tooltip
                                 //    state.ActiveUsers = data['Active Users']; // Store Active Users data for tooltip
                                 //}
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
                                         fontSize: '24px',
                                         display: 'none'
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
                                     //minColor: '#FFA500', // Light gray for minimum value
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
                                     joinBy: 'name', // Link the data by state name
                                     states: {
                                         hover: {
                                             enabled: false // Disable hover state effect
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


            <%--<script>
                document.addEventListener('DOMContentLoaded', function () {
                    // Fetch data from the API
                    fetch('../Info/PatanjaliHandler.ashx?method=heatMap&companyid=Comp-1693')
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
            
                            processedData.forEach(state => {
                                const stateName = state.properties['name'];
debugger;
		 
                                const stateCode = stateMappings[stateName];
                                const data = jsonData.find(item => item.State === stateName.toUpperCase());
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
                                        fontSize: '24px',
                                        display: 'none'
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
            </script>--%>
        </asp:Content>