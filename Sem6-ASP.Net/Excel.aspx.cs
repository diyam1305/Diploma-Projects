//using ClosedXML.Excel;
//using System;
//using System.Configuration;
//using System.Data;
//using System.Data.SqlClient;
//using System.IO;
//using System.Web;
//using System.Web.UI;
//using System.Web.UI.WebControls;

//namespace Quiz_Management_System
//{
//    public partial class Excel : System.Web.UI.Page
//    {
//        string conStr = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

//        protected void Page_Load(object sender, EventArgs e)
//        {
//            if (Session["User_ID"] == null)
//                Response.Redirect("~/LoginPage.aspx");
//        }
//        protected void btnUpload_Click(object sender, EventArgs e)
//        {
//            if (!fileUploadExcel.HasFile)
//            {
//                ShowAlert("Please select an Excel file.");
//                return;
//            }

//            string ext = Path.GetExtension(fileUploadExcel.FileName).ToLower();
//            if (ext != ".xlsx")
//            {
//                ShowAlert("Only .xlsx format is supported. Please save your file as Excel Workbook (.xlsx).");
//                return;
//            }

//            try
//            {
//                // Read into MemoryStream directly — bypass disk entirely
//                byte[] fileBytes;
//                using (var ms = new MemoryStream())
//                {
//                    fileUploadExcel.PostedFile.InputStream.CopyTo(ms);
//                    fileBytes = ms.ToArray();
//                }

//                if (fileBytes.Length < 100)
//                {
//                    ShowAlert("Uploaded file appears to be empty or corrupted.");
//                    return;
//                }

//                // Save to disk
//                string folder = Server.MapPath("~/Uploads/Temp/");
//                if (!Directory.Exists(folder))
//                    Directory.CreateDirectory(folder);

//                string filePath = Path.Combine(folder, Guid.NewGuid() + ext);
//                File.WriteAllBytes(filePath, fileBytes);

//                // Read Excel from memory (not disk path)
//                DataTable dt = ReadExcelFromBytes(fileBytes);

//                if (dt == null || dt.Rows.Count == 0)
//                {
//                    ShowAlert("No data found in the Excel file. Make sure data starts from row 2.");
//                    return;
//                }

//                Session["ExcelData"] = dt;
//                Session["ExcelFilePath"] = filePath;

//                Response.Redirect("~/ExcelPreview.aspx");
//            }
//            catch (Exception ex)
//            {
//                ShowAlert("Error: " + ex.Message);
//            }
//        }

//        private DataTable ReadExcelFromBytes(byte[] fileBytes)
//        {
//            DataTable dt = new DataTable();
//            dt.Columns.Add("RowNumber", typeof(int));
//            dt.Columns.Add("QuizName");
//            dt.Columns.Add("Question");
//            dt.Columns.Add("OptionA");
//            dt.Columns.Add("OptionB");
//            dt.Columns.Add("OptionC");
//            dt.Columns.Add("OptionD");
//            dt.Columns.Add("CorrectOption");
//            dt.Columns.Add("Marks", typeof(int));

//            using (var ms = new MemoryStream(fileBytes))
//            using (var wb = new XLWorkbook(ms))
//            {
//                var ws = wb.Worksheet(1);
//                var lastRow = ws.LastRowUsed();
//                if (lastRow == null) return dt;

//                int rows = lastRow.RowNumber();

//                for (int i = 2; i <= rows; i++)
//                {
//                    DataRow dr = dt.NewRow();
//                    dr["RowNumber"] = i - 1;
//                    dr["QuizName"] = ws.Cell(i, 1).GetString().Trim();
//                    dr["Question"] = ws.Cell(i, 2).GetString();
//                    dr["OptionA"] = ws.Cell(i, 3).GetString();
//                    dr["OptionB"] = ws.Cell(i, 4).GetString();
//                    dr["OptionC"] = ws.Cell(i, 5).GetString();
//                    dr["OptionD"] = ws.Cell(i, 6).GetString();
//                    dr["CorrectOption"] = ws.Cell(i, 7).GetString().ToUpper();
//                    dr["Marks"] = int.TryParse(ws.Cell(i, 8).GetString(), out int m) ? m : 1;
//                    dt.Rows.Add(dr);
//                }
//            }
//            return dt;
//        }

//        protected void lnkDownloadSample_Click(object sender, EventArgs e)
//        {
//            Response.Clear();
//            Response.ClearContent();
//            Response.ClearHeaders();
//            Response.Buffer = true;

//            using (var wb = new ClosedXML.Excel.XLWorkbook())
//            {
//                var ws = wb.Worksheets.Add("Sample");

//                // Header row
//                ws.Cell(1, 1).Value = "Quiz Name";
//                ws.Cell(1, 2).Value = "Question";
//                ws.Cell(1, 3).Value = "Option A";
//                ws.Cell(1, 4).Value = "Option B";
//                ws.Cell(1, 5).Value = "Option C";
//                ws.Cell(1, 6).Value = "Option D";
//                ws.Cell(1, 7).Value = "Correct Option";
//                ws.Cell(1, 8).Value = "Marks";

//                // Sample rows
//                ws.Cell(2, 1).Value = "General Knowledge Quiz";
//                ws.Cell(2, 2).Value = "What is the capital of France?";
//                ws.Cell(2, 3).Value = "London";
//                ws.Cell(2, 4).Value = "Paris";
//                ws.Cell(2, 5).Value = "Berlin";
//                ws.Cell(2, 6).Value = "Madrid";
//                ws.Cell(2, 7).Value = "B";
//                ws.Cell(2, 8).Value = 1;

//                ws.Cell(3, 1).Value = "Science Quiz";
//                ws.Cell(3, 2).Value = "What is H2O?";
//                ws.Cell(3, 3).Value = "Water";
//                ws.Cell(3, 4).Value = "Oxygen";
//                ws.Cell(3, 5).Value = "Hydrogen";
//                ws.Cell(3, 6).Value = "Carbon Dioxide";
//                ws.Cell(3, 7).Value = "A";
//                ws.Cell(3, 8).Value = 2;

//                Response.ContentType =
//                    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
//                Response.AddHeader("Content-Disposition",
//                    "attachment; filename=SampleQuestionsWithQuiz.xlsx");

//                using (var ms = new System.IO.MemoryStream())
//                {
//                    wb.SaveAs(ms);
//                    ms.WriteTo(Response.OutputStream);
//                }

//                Response.Flush();
//                HttpContext.Current.ApplicationInstance.CompleteRequest();
//            }
//        }

//        private void ShowAlert(string msg)
//        {
//            ScriptManager.RegisterStartupScript(this, GetType(), "alert",
//                $"Swal.fire({{ text: '{msg.Replace("'", "\\'")}', icon: 'info', confirmButtonText: 'OK' }});", true);
//        }
//    }
//}





using ClosedXML.Excel;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Quiz_Management_System
{
    public partial class Excel : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

        //protected void Page_Load(object sender, EventArgs e)
        //{
        //    if (Session["User_ID"] == null)
        //        Response.Redirect("~/LoginPage.aspx");

        //    // Escape the UpdatePanel for file upload
        //    ScriptManager sm = ScriptManager.GetCurrent(this.Page);
        //    if (sm != null)
        //    {
        //        sm.RegisterPostBackControl(btnUploadHidden);
        //    }
        //}

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User_ID"] == null)
                Response.Redirect("~/LoginPage.aspx");

            // Escape the UpdatePanel for file upload
            ScriptManager sm = ScriptManager.GetCurrent(this.Page);
            if (sm != null)
            {
                sm.RegisterPostBackControl(btnUploadHidden);
                sm.RegisterPostBackControl(lnkDownloadSample); // <-- add this line
            }
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (!fileUploadExcel.HasFile)
            {
                ShowAlert("Please select an Excel file.");
                return;
            }

            string ext = Path.GetExtension(fileUploadExcel.FileName).ToLower();
            if (ext != ".xlsx")
            {
                ShowAlert("Only .xlsx format is supported. Please save your file as Excel Workbook (.xlsx).");
                return;
            }

            try
            {
                byte[] fileBytes;
                using (var ms = new MemoryStream())
                {
                    fileUploadExcel.PostedFile.InputStream.CopyTo(ms);
                    fileBytes = ms.ToArray();
                }

                if (fileBytes.Length < 100)
                {
                    ShowAlert("Uploaded file appears to be empty or corrupted.");
                    return;
                }

                string folder = Server.MapPath("~/Uploads/Temp/");
                if (!Directory.Exists(folder))
                    Directory.CreateDirectory(folder);

                string filePath = Path.Combine(folder, Guid.NewGuid() + ext);
                File.WriteAllBytes(filePath, fileBytes);

                DataTable dt = ReadExcelFromBytes(fileBytes);

                if (dt == null || dt.Rows.Count == 0)
                {
                    ShowAlert("No data found in the Excel file. Make sure data starts from row 2.");
                    return;
                }

                Session["ExcelData"] = dt;
                Session["ExcelFilePath"] = filePath;

                Response.Redirect("~/ExcelPreview.aspx");
            }
            catch (Exception ex)
            {
                ShowAlert("Error: " + ex.Message);
            }
        }

        private DataTable ReadExcelFromBytes(byte[] fileBytes)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("RowNumber", typeof(int));
            dt.Columns.Add("QuizName");
            dt.Columns.Add("Question");
            dt.Columns.Add("OptionA");
            dt.Columns.Add("OptionB");
            dt.Columns.Add("OptionC");
            dt.Columns.Add("OptionD");
            dt.Columns.Add("CorrectOption");
            dt.Columns.Add("Marks", typeof(int));

            using (var ms = new MemoryStream(fileBytes))
            using (var wb = new XLWorkbook(ms))
            {
                var ws = wb.Worksheet(1);
                var lastRow = ws.LastRowUsed();
                if (lastRow == null) return dt;

                int rows = lastRow.RowNumber();

                for (int i = 2; i <= rows; i++)
                {
                    DataRow dr = dt.NewRow();
                    dr["RowNumber"] = i - 1;
                    dr["QuizName"] = ws.Cell(i, 1).GetString().Trim();
                    dr["Question"] = ws.Cell(i, 2).GetString();
                    dr["OptionA"] = ws.Cell(i, 3).GetString();
                    dr["OptionB"] = ws.Cell(i, 4).GetString();
                    dr["OptionC"] = ws.Cell(i, 5).GetString();
                    dr["OptionD"] = ws.Cell(i, 6).GetString();
                    dr["CorrectOption"] = ws.Cell(i, 7).GetString().ToUpper();
                    dr["Marks"] = int.TryParse(ws.Cell(i, 8).GetString(), out int m) ? m : 1;
                    dt.Rows.Add(dr);
                }
            }
            return dt;
        }

        protected void lnkDownloadSample_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.ClearContent();
            Response.ClearHeaders();
            Response.Buffer = true;

            using (var wb = new ClosedXML.Excel.XLWorkbook())
            {
                var ws = wb.Worksheets.Add("Sample");

                ws.Cell(1, 1).Value = "Quiz Name";
                ws.Cell(1, 2).Value = "Question";
                ws.Cell(1, 3).Value = "Option A";
                ws.Cell(1, 4).Value = "Option B";
                ws.Cell(1, 5).Value = "Option C";
                ws.Cell(1, 6).Value = "Option D";
                ws.Cell(1, 7).Value = "Correct Option";
                ws.Cell(1, 8).Value = "Marks";

                ws.Cell(2, 1).Value = "General Knowledge Quiz";
                ws.Cell(2, 2).Value = "What is the capital of France?";
                ws.Cell(2, 3).Value = "London";
                ws.Cell(2, 4).Value = "Paris";
                ws.Cell(2, 5).Value = "Berlin";
                ws.Cell(2, 6).Value = "Madrid";
                ws.Cell(2, 7).Value = "B";
                ws.Cell(2, 8).Value = 1;

                ws.Cell(3, 1).Value = "Science Quiz";
                ws.Cell(3, 2).Value = "What is H2O?";
                ws.Cell(3, 3).Value = "Water";
                ws.Cell(3, 4).Value = "Oxygen";
                ws.Cell(3, 5).Value = "Hydrogen";
                ws.Cell(3, 6).Value = "Carbon Dioxide";
                ws.Cell(3, 7).Value = "A";
                ws.Cell(3, 8).Value = 2;

                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("Content-Disposition", "attachment; filename=SampleQuestionsWithQuiz.xlsx");

                using (var ms = new System.IO.MemoryStream())
                {
                    wb.SaveAs(ms);
                    ms.WriteTo(Response.OutputStream);
                }

                Response.Flush();
                HttpContext.Current.ApplicationInstance.CompleteRequest();
            }
        }

        private void ShowAlert(string msg)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                $"Swal.fire({{ text: '{msg.Replace("'", "\\'")}', icon: 'info', confirmButtonText: 'OK' }});", true);
        }
    }
}