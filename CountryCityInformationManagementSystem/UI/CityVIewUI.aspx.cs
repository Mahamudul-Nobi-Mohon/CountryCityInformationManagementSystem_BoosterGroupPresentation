using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using System.Data;
using System.Drawing;
using System.Net;
using CountryCityInformationManagementSystem.BLL;

namespace CountryCityInformationManagementSystem.UI
{
    public partial class CityVIewUI : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
               CountryDropdownList();
            }
            
        }

        CityViewManager cityViewManager=new CityViewManager();
        protected void searchButton_Click(object sender, EventArgs e)
        {
           GetSelectedCityOrCountryInformation();
            if (cityListGridView.Rows.Count > 0)
            {
                cityListGridView.Visible = true;
                
            }
            else
            {
                cityListGridView.Visible = false;
            }
        }

        protected void GetSelectedCityOrCountryInformation()
        {
            messageLabel.Text = "";
                          
            DataSet dataSet = new DataSet();
            
           if (cityNameRadioButton.Checked)
              {
                  if (cityNameTextBox.Text == "")
                  {
                      messageLabel.Text = "<h3>Please Type a City Name.</h3>";
                      messageLabel.ForeColor = Color.Red;
                  }
                  else
                  {
                      string cityName = cityNameTextBox.Text;
                      dataSet = cityViewManager.GetSelectedCityInformation(cityName);
                      cityListGridView.DataSource = dataSet;
                      cityListGridView.DataBind();
                      if (cityListGridView.Rows.Count < 1)
                      {
                           messageLabel.Text = "<h3>No Data Found.</h3>";
                              messageLabel.ForeColor = Color.Red;
                         
                      }
                  }
                  
              }
            else if (countryRadioButton.Checked)
              {
                  if (countryDropDownList.SelectedIndex <= 0)
                  {
                     messageLabel.Text = "<h3>Please Select a Country Name.</h3>";
                      messageLabel.ForeColor = Color.Red;
                      
                  }
                  else
                  {
                      string selectedCountryName = countryDropDownList.SelectedValue;
                      int countryId = cityViewManager.GetSelectedCountryId(selectedCountryName);

                      dataSet = cityViewManager.GetSelectedCountryInformation(countryId);
                      cityListGridView.DataSource = dataSet;
                      cityListGridView.DataBind();
                      if (cityListGridView.Rows.Count < 1)
                      {
                             messageLabel.Text = "<h3>No Data Found.</h3>";
                              messageLabel.ForeColor = Color.Red;
                         
                      }
                  }
              }
              
                
            }
        
        protected void gvDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            cityListGridView.PageIndex = e.NewPageIndex;
            GetSelectedCityOrCountryInformation();
        }


        public void CountryDropdownList()
        {
            List<string> countryNameList = cityViewManager.GetCountryDropdownList();
            foreach (string countryName in countryNameList)
            {
                countryDropDownList.Items.Add(countryName);
            }  
        }
    }
}