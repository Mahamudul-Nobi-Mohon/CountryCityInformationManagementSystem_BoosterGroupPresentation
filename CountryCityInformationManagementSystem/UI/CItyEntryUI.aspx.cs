using System;
using System.Collections.Generic;
using System.Drawing;
using System.Web.UI.WebControls;
using CountryCityInformationManagementSystem.Models;
using System.Data;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using CountryCityInformationManagementSystem.BLL;

namespace CountryCityInformationManagementSystem.UI
{
    public partial class CityEntryUI : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                GetAllCityInformation();
                CountryDropdownList();
            }
        }  
     
        static  CityEntryManager cityEntryManager=new CityEntryManager();
        private static City city;
       
        protected void cancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }

        //protected void saveButton_Click(object sender, EventArgs e)
        [WebMethod]
        public static int SaveCity(string cityName, string cityAbout, double noOfDwellers, string location, string weather, string countryName)
        {
          
            try
            {
               int countryId = cityEntryManager.GetSelectedCountryId(countryName);
               if (countryId != 0)
                {
                    city = new City(cityName, cityAbout, noOfDwellers, location, weather, countryId);
                    int result = cityEntryManager.SetCityInformation(city);

                    return result;
                }
                else
                {
                    return 0;
                }
                
            }
            catch (Exception exception)
            {
                return 0;
            }

            }
        

        public void CountryDropdownList()
        {
            List<string> countryNameList = cityEntryManager.GetCountryDropdownList();
            foreach (string countryName in countryNameList)
            {
                countryDropDownList.Items.Add(countryName);
            }                         
        }


        protected void GetAllCityInformation()
        {

            DataSet dataSet = cityEntryManager.GetAllCityInformation();
            cityListGridView.DataSource = dataSet;
            cityListGridView.DataBind();
            
        }
        protected void gvDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            cityListGridView.PageIndex = e.NewPageIndex;
            GetAllCityInformation();
        }


        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                string FileName = System.IO.Path.GetFileName(FileUpload1.PostedFile.FileName);
                string FilePath = "../images/" + FileName;
                FileUpload1.SaveAs(Server.MapPath(FilePath));
                aboutTextBox.Text += string.Format("<img src = '{0}' alt = '{1}' />", FilePath, FileName);
            }
        }

        protected void showAllButton_Click(object sender, EventArgs e)
        {
            GetAllCityInformation();
        }

    }
}

