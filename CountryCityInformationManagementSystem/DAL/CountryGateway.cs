using System;
using System.Data;
using System.Data.SqlClient;
using CountryCityInformationManagementSystem.Models;

namespace CountryCityInformationManagementSystem.DAL
{
    public class CountryGateway:CommonGateway
    {

        public int SetCountryInformation(Country country)
        {
            GenarateConnection();
            using (Connection)
            {
                Connection.Open();
                string query = "insert into Country(countryName,about) values (@countryName,@about);";

                Command = new SqlCommand(query, Connection);
                Command.Parameters.Clear();

                Command.Parameters.Add("@countryName", SqlDbType.VarChar);
                Command.Parameters["@countryName"].Value = country.Name;
                Command.Parameters.Add("@about", SqlDbType.Text);
                Command.Parameters["@about"].Value = country.About;
                try
                {
                    Command.ExecuteNonQuery();
                    Connection.Close();
                    return 1;
                }
                catch (Exception)
                {
                    return 0;
                }
            }
        }
        public DataSet GetCountryInformation()
        {
            GenarateConnection();
            DataSet = new DataSet();
            using (Connection)
            {
                Connection.Open();
                Command = new SqlCommand("select * from Country order by countryId desc", Connection);
                DataAdapter = new SqlDataAdapter(Command);
                DataAdapter.Fill(DataSet);
                Connection.Close();
            }
            return DataSet;
        }

        public DataSet GetSelectedCountryInformaion(string countryName)
        {
            GenarateConnection();
            DataSet = new DataSet();
            using (Connection)
            {
                Connection.Open();
                Command = new SqlCommand("select * from ViewAllCountryInformation where countryName like '%'+@countryName+'%'", Connection);
                Command.Parameters.Clear();

                Command.Parameters.Add("@countryName", SqlDbType.VarChar);
                Command.Parameters["@countryName"].Value = countryName;
                DataAdapter = new SqlDataAdapter(Command);
                DataAdapter.Fill(DataSet);
                Connection.Close();
            }
            return DataSet;
        }
        public Country GetCountryByName(string countryName)
        {
            GenarateConnection();
            string query = "SELECT * FROM Country WHERE countryName =@countryName";
            Command = new SqlCommand(query, Connection);
            Command.Parameters.Clear();

            Command.Parameters.Add("@countryName", SqlDbType.VarChar);
            Command.Parameters["@countryName"].Value = countryName;
            Connection.Open();
            Country country = null;
            Reader = Command.ExecuteReader();
            if (Reader.HasRows)
            {
                Reader.Read();
                country = new Country();
                country.Name = Reader["countryName"].ToString();
                country.About = Reader["about"].ToString();

                Reader.Close();
            }
            Connection.Close();
            return country;
        }
    }
}