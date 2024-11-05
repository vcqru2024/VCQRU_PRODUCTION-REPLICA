using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApplication1
{
    public class Location
    {
        //public string IPAddress { get; set; }
        //public string CountryName { get; set; }
        //public string CountryCode { get; set; }
        //public string CityName { get; set; }
        //public string RegionName { get; set; }
        //public string ZipCode { get; set; }
        //public string Latitude { get; set; }
        //public string Longitude { get; set; }
        //public string TimeZone { get; set; }
        public string IPAddress { get; set; }
        public string country_name { get; set; }
        public string country_code { get; set; }
        public string city_name { get; set; }
        public string region_name { get; set; }
        public string zip_code { get; set; }
        public string latitude { get; set; }
        public string longitude { get; set; }
        public string TimeZone { get; set; }


    }
}