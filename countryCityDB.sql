USE [master]
GO
/****** Object:  Database [CountryCityManagementSystemDB]    Script Date: 10/31/2016 10:26:45 PM ******/
CREATE DATABASE [CountryCityManagementSystemDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CountryCityManagementSystemDB', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\CountryCityManagementSystemDB.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'CountryCityManagementSystemDB_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\CountryCityManagementSystemDB_log.ldf' , SIZE = 3456KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [CountryCityManagementSystemDB] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CountryCityManagementSystemDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CountryCityManagementSystemDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CountryCityManagementSystemDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CountryCityManagementSystemDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CountryCityManagementSystemDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CountryCityManagementSystemDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [CountryCityManagementSystemDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CountryCityManagementSystemDB] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [CountryCityManagementSystemDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CountryCityManagementSystemDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CountryCityManagementSystemDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CountryCityManagementSystemDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CountryCityManagementSystemDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CountryCityManagementSystemDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CountryCityManagementSystemDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CountryCityManagementSystemDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CountryCityManagementSystemDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CountryCityManagementSystemDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CountryCityManagementSystemDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CountryCityManagementSystemDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CountryCityManagementSystemDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CountryCityManagementSystemDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CountryCityManagementSystemDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CountryCityManagementSystemDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CountryCityManagementSystemDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CountryCityManagementSystemDB] SET  MULTI_USER 
GO
ALTER DATABASE [CountryCityManagementSystemDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CountryCityManagementSystemDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CountryCityManagementSystemDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CountryCityManagementSystemDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [CountryCityManagementSystemDB]
GO
/****** Object:  Table [dbo].[City]    Script Date: 10/31/2016 10:26:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[City](
	[cityId] [int] IDENTITY(1,1) NOT NULL,
	[cityName] [varchar](250) NOT NULL,
	[about] [text] NULL,
	[noOfDwellers] [float] NULL,
	[location] [varchar](20) NULL,
	[weather] [text] NULL,
	[countryId] [int] NOT NULL,
 CONSTRAINT [PK_City] PRIMARY KEY CLUSTERED 
(
	[cityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Country]    Script Date: 10/31/2016 10:26:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Country](
	[countryId] [int] IDENTITY(1,1) NOT NULL,
	[countryName] [varchar](250) NOT NULL,
	[about] [varchar](max) NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[countryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[ViewAllCityWithCountry]    Script Date: 10/31/2016 10:26:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ViewAllCityWithCountry]
AS
SELECT        p.cityId, p.cityName, p.about AS cityAbout, p.noOfDwellers, p.location, p.weather, c.countryId, c.countryName, c.about AS countryAbout
FROM            dbo.City AS p FULL OUTER JOIN
                         dbo.Country AS c ON p.countryId = c.countryId

GO
/****** Object:  View [dbo].[ViewAllCountryInformation]    Script Date: 10/31/2016 10:26:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ViewAllCountryInformation]
AS
SELECT        dbo.Country.countryId, dbo.Country.countryName, dbo.Country.about, ISNULL(c.totalCities, 0) AS [Total City], ISNULL(c.totalDwelers, 0) AS [Total Dwellers]
FROM            dbo.Country FULL OUTER JOIN
                             (SELECT        b.countryId, COUNT(b.cityId) AS totalCities, SUM(b.noOfDwellers) AS totalDwelers
                               FROM            dbo.City AS b FULL OUTER JOIN
                                                         dbo.Country AS a ON b.countryId = a.countryId
                               GROUP BY b.countryId) AS c ON dbo.Country.countryId = c.countryId

GO
SET IDENTITY_INSERT [dbo].[City] ON 

INSERT [dbo].[City] ([cityId], [cityName], [about], [noOfDwellers], [location], [weather], [countryId]) VALUES (4, N'Dhaka', N'<p><img src="../images/300px-Dhaka.jpg" alt="300px-Dhaka.jpg" /></p>
<p><span>Dhaka is the capital city of Bangladesh, in southern Asia. Set  beside the Buriganga River, it&rsquo;s at the center of national government,  trade and culture. The 17th-century old city was the Mughal capital of  Bengal, and many palaces and mosques remain. American architect Louis  Khan&rsquo;s National Parliament House complex typifies the huge, fast-growing  modern metropolis.</span></p>', 10000, N'Dhaka City', N'Mostly Hot', 57)
INSERT [dbo].[City] ([cityId], [cityName], [about], [noOfDwellers], [location], [weather], [countryId]) VALUES (5, N'Pabna', N'<p><img src="../images/pabna.jpg" alt="pabna.jpg" /></p>
<p><span>Pabna District is a district in north-western Bangladesh. It is  the southern most district of Rajshahi Division. Its administrative  capital is eponymous Pabna town.</span></p>', 2000, N'Pabna District', N'Cool', 57)
INSERT [dbo].[City] ([cityId], [cityName], [about], [noOfDwellers], [location], [weather], [countryId]) VALUES (6, N'Rangpur', N'<p><img src="../images/Rangpur.jpg" alt="Rangpur.jpg" width="354" height="175" /></p>
<p><strong>Rangpur</strong> (<a title="Bengali language" href="https://en.wikipedia.org/wiki/Bengali_language">Bengali</a>: <span lang="bn">?????</span>) is one of the major cities in <a title="Bangladesh" href="https://en.wikipedia.org/wiki/Bangladesh">Bangladesh</a> and <a title="Rangpur Division" href="https://en.wikipedia.org/wiki/Rangpur_Division">Rangpur Division</a>.  Rangpur was declared a district headquarters on 16 December 1769, and  established as a municipality in 1869, making it one of the oldest  municipalities in Bangladesh</p>
<p>&nbsp;</p>
<p><img src="../images/Rangpur-city.jpg" alt="Rangpur-city.jpg" width="311" height="175" /></p>
<p>The municipal office building was erected in 1892 under the precedence  Raja Janaki Ballav, Sen. Chairman of the municipality. During the period  of 1890, "Shyama sundari khal" was excavated for improvement of the  town. The Municipality is located in the north western part of  Bangladesh.</p>
<p>&nbsp;</p>
<p><img src="../images/rangpur-railway.jpg" alt="rangpur-railway.jpg" width="327" height="245" /></p>
<p>A Recently established public university of Bangladesh named "Begum  Rokeya University, Rangpur" is situated in the southern part of the  city. Previously, Rangpur was the headquarters of <em>Greater Rangpur</em> district.</p>
<p><img title="Tongue out" src="../tinymce/jscripts/tiny_mce/plugins/emotions/img/smiley-tongue-out.gif" border="0" alt="Tongue out" /><img title="Undecided" src="../tinymce/jscripts/tiny_mce/plugins/emotions/img/smiley-undecided.gif" border="0" alt="Undecided" /></p>', 2000, N'Rangpur district', N'Hot and cool', 57)
INSERT [dbo].[City] ([cityId], [cityName], [about], [noOfDwellers], [location], [weather], [countryId]) VALUES (7, N'Mumbai', N'<p><img src="../images/mumbai.jpg" alt="mumbai.jpg" width="350" height="175" /></p>
<p><span>Mumbai (formerly called Bombay) is a densely populated city on  India&rsquo;s west coast. A financial center, it''s India''s largest city. On  the Mumbai Harbour waterfront stands the iconic Gateway of India stone  arch, built by the British Raj in 1924. Offshore, nearby Elephanta  Island holds ancient cave temples dedicated to the Hindu god Shiva. The  city''s also famous as the heart of the Bollywood film industry.</span></p>', 5000, N'Mumbai division', N'hot', 58)
SET IDENTITY_INSERT [dbo].[City] OFF
SET IDENTITY_INSERT [dbo].[Country] ON 

INSERT [dbo].[Country] ([countryId], [countryName], [about]) VALUES (36, N'nepal', N'<p><img src="../images/nepal.jpg" alt="nepal.jpg" width="263" height="175" /> <span style="font-family: verdana,sans-serif; font-size: x-small;"><span style="font-family: Verdana,sans-serif;">Nepal  (?????) has its flag red with a blue border around the unique shape &nbsp;of  two overlapping right triangles. The smaller, upper triangle has a  white stylized moon and the larger and lower triangle displays a white  12-pointed sun. The color red represents the rhododendron (the National  flower of Nepal) and the color red is sign of victory and bravery. The  blue border signifies peace and harmony; the two right triangles are a  combination of two single pennons (pennants) that originally symbolized  the Himalaya Mountains.&nbsp; The moon represents the serenity of the  Nepalese people and the shade and cool weather in the Himalayas, while  the sun depicts the heat and higher temperatures of the lower parts of  Nepal. The moon and the sun are also said to express the strong belief  that the Nepal will be there in the earth as long as Sun and Moon are in  the sky.</span></span></p>')
INSERT [dbo].[Country] ([countryId], [countryName], [about]) VALUES (57, N'bangladesh', N'<p><img src="../images/bangladesh.jpg" alt="bangladesh.jpg" width="263" height="166" /><a class="mw-redirect" title="Greater Bengal" href="https://en.wikipedia.org/wiki/Greater_Bengal">Greater Bengal</a> was known to the ancient <a title="Ancient Greece" href="https://en.wikipedia.org/wiki/Ancient_Greece">Greeks</a> and <a title="Ancient Rome" href="https://en.wikipedia.org/wiki/Ancient_Rome">Romans</a> as <em><a title="Gangaridai" href="https://en.wikipedia.org/wiki/Gangaridai">Gangaridai</a></em>.<sup id="cite_ref-11" class="reference"><a href="https://en.wikipedia.org/wiki/Bangladesh#cite_note-11">[11]</a></sup> The people of the delta developed their own language, <a class="mw-redirect" title="Bengali script" href="https://en.wikipedia.org/wiki/Bengali_script">script</a>, <a title="Bengali literature" href="https://en.wikipedia.org/wiki/Bengali_literature">literature</a>, <a class="mw-redirect" title="Bengali music" href="https://en.wikipedia.org/wiki/Bengali_music">music</a>, art and <a class="mw-redirect" title="Bengali architecture" href="https://en.wikipedia.org/wiki/Bengali_architecture">architecture</a>. Early Asian literature described the region as a <a class="mw-redirect" title="Seafaring" href="https://en.wikipedia.org/wiki/Seafaring">seafaring</a> power.<sup id="cite_ref-12" class="reference"><a href="https://en.wikipedia.org/wiki/Bangladesh#cite_note-12">[12]</a></sup> It was an important <a class="mw-redirect" title="Entrepot" href="https://en.wikipedia.org/wiki/Entrepot">entrepot</a> of the historic <a title="Silk Road" href="https://en.wikipedia.org/wiki/Silk_Road">Silk Road</a>.<sup id="cite_ref-gutenberg-e.org_13-0" class="reference"><a href="https://en.wikipedia.org/wiki/Bangladesh#cite_note-gutenberg-e.org-13">[13]</a></sup> Bengal was absorbed into the <a title="Muslim world" href="https://en.wikipedia.org/wiki/Muslim_world">Muslim world</a> and ruled by <a title="Sultan" href="https://en.wikipedia.org/wiki/Sultan">sultans</a> for four centuries, including under the <a title="Delhi Sultanate" href="https://en.wikipedia.org/wiki/Delhi_Sultanate">Delhi Sultanate</a> and the <a title="Bengal Sultanate" href="https://en.wikipedia.org/wiki/Bengal_Sultanate">Bengal Sultanate</a>. This was followed by the <a title="Bengal Subah" href="https://en.wikipedia.org/wiki/Bengal_Subah">administration</a> of the <a title="Mughal Empire" href="https://en.wikipedia.org/wiki/Mughal_Empire">Mughal Empire</a>. Islamic Bengal was a <a title="Melting pot" href="https://en.wikipedia.org/wiki/Melting_pot">melting pot</a>, a regional power and a key player in medieval world trade. <a title="British Empire" href="https://en.wikipedia.org/wiki/British_Empire">British colonial conquest</a> took place in the late-18th century. <a title="Nationalism" href="https://en.wikipedia.org/wiki/Nationalism">Nationalism</a>, social reforms and the arts developed under the <a title="British Raj" href="https://en.wikipedia.org/wiki/British_Raj">British Raj</a> in the late 19th and early 20th centuries, when the region was a hotbed of the <a title="Indian independence movement" href="https://en.wikipedia.org/wiki/Indian_independence_movement">anti-colonial movement</a> in the <a class="mw-redirect" title="Subcontinent" href="https://en.wikipedia.org/wiki/Subcontinent">subcontinent</a>.</p>')
INSERT [dbo].[Country] ([countryId], [countryName], [about]) VALUES (58, N'India', N'<p><img src="../images/india.jpg" alt="india.jpg" width="333" height="175" /></p>
<p><span>India is a vast South Asian country with diverse terrain &ndash; from  Himalayan peaks to Indian Ocean coastline &ndash; and history reaching back 5  millennia. In the north, Mughal Empire landmarks include Delhi&rsquo;s Red  Fort complex and massive Jama Masjid mosque, plus Agra&rsquo;s iconic Taj  Mahal mausoleum. Pilgrims bathe in the Ganges in Varanasi, and Rishikesh  is a yoga centre and base for Himalayan trekking.</span></p>')
INSERT [dbo].[Country] ([countryId], [countryName], [about]) VALUES (59, N'Pakistan', N'<p><img src="../images/pakistan.png" alt="pakistan.png" width="473" height="175" /></p>
<p><span>Pakistan, officially the Islamic Republic of Pakistan, is a  federal parliamentary republic in South Asia. It is the sixth-most  populous country with a population exceeding 200 million people.</span><span></span></p>')
INSERT [dbo].[Country] ([countryId], [countryName], [about]) VALUES (60, N'Afghanistan', N'<p><img src="../images/afganistan.jpg" alt="afganistan.jpg" width="280" height="175" /></p>
<p><span>Afghanistan /&aelig;f''g&aelig;n?st&aelig;n/, officially the Islamic Republic of  Afghanistan, is a landlocked country located within South Asia and  Central Asia. It has a population of approximately 32 million, making it  the 42nd most populous country in the world.</span><span></span></p>')
SET IDENTITY_INSERT [dbo].[Country] OFF
ALTER TABLE [dbo].[City]  WITH CHECK ADD  CONSTRAINT [FK_City_Country] FOREIGN KEY([countryId])
REFERENCES [dbo].[Country] ([countryId])
GO
ALTER TABLE [dbo].[City] CHECK CONSTRAINT [FK_City_Country]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "p"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 119
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewAllCityWithCountry'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewAllCityWithCountry'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Country"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 119
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewAllCountryInformation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewAllCountryInformation'
GO
USE [master]
GO
ALTER DATABASE [CountryCityManagementSystemDB] SET  READ_WRITE 
GO
