using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using CountryCityInformationManagementSystem.DAL;
using CountryCityInformationManagementSystem.Models;

namespace CountryCityInformationManagementSystem.BLL
{
    public class CountryEntryManager
    {
        CountryGateway countryGateway=new CountryGateway();
        public int SetCountryInformation(Country country)
        {
            if (IsCountryNameExist(country.Name))
            {
                return 2;
            }
            else
            {
                int result = countryGateway.SetCountryInformation(country);

                return result;
            }
           
        }

        public DataSet GetCountryInformation()
        {
            DataSet dataSet = countryGateway.GetCountryInformation();
            return dataSet;
        }
        public bool IsCountryNameExist(string countryName)
        {
            bool isCountryNameExist = false;
            Country country = countryGateway.GetCountryByName(countryName);
            if (country != null)
            {
                isCountryNameExist = true;
            }
            return isCountryNameExist;

        }

    }
}