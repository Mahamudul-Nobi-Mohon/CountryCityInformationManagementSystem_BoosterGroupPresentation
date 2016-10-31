using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CountryCityInformationManagementSystem.Models;
using System.Data;
using System.Web.Services;
using CountryCityInformationManagementSystem.BLL;

using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Configuration;

namespace CountryCityInformationManagementSystem.UI
{
    public partial class CountryEntryUI : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetCountryInformation();
            }
        }
        static CountryEntryManager countryEntryManager = new CountryEntryManager();
        private static Country country;
      

        protected void cancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }

      //  protected void saveButton_Click(object sender, EventArgs e)
        [WebMethod]
        public static int SaveCountry(string countryName, string countryAbout)
      
        {
            try
            {

                country = new Country(countryName, countryAbout);



                int result = countryEntryManager.SetCountryInformation(country);

                return result;
            }
            catch (Exception exception)
            {
                return 0;
            }
           // GetCountryInformation();
        }


       

        
        protected void GetCountryInformation()
        {
            DataSet dataSet = countryEntryManager.GetCountryInformation();
            countryListGridView.DataSource = dataSet;
            countryListGridView.DataBind();
        }

        protected void gvDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            countryListGridView.PageIndex = e.NewPageIndex;
            GetCountryInformation();
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
            GetCountryInformation();
        }


    }
}