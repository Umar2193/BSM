namespace BSMDataAccess
{
    using System;
    using System.Data;
    using System.Data.SqlClient;
   public class DataViewer
    {
        public static DataSet GetTrainingMatrix (string ConnectionString, int EmpDept, int JobTitleId)
        {
            string storedProcedure = "bsm.GetTrainingMatrix";
            DataSet dataSet = new DataSet();
            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    using (SqlCommand command = new SqlCommand(storedProcedure, connection))
                    {
                        using (SqlDataAdapter dataAdapter = new SqlDataAdapter(command))
                        {
                            command.CommandType = CommandType.StoredProcedure;
                            command.Parameters.Add("@empDepartmentId", SqlDbType.Int).Value = EmpDept;
                            command.Parameters.Add("@jobTitleId", SqlDbType.Int).Value = JobTitleId;
                            dataAdapter.Fill(dataSet);
                        }
                    }
                }                
            }
            catch (Exception ex)
            {

            }
            return dataSet;
        }
        public static DataSet GetTrainingReport(string ConnectionString, int SkillsId)
        {
            string storedProcedure = "bsm.GetTrainingReport";
            DataSet dataSet = new DataSet();
            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    using (SqlCommand command = new SqlCommand(storedProcedure, connection))
                    {
                        using (SqlDataAdapter dataAdapter = new SqlDataAdapter(command))
                        {
                            command.CommandType = CommandType.StoredProcedure;
                            command.Parameters.Add("@skillsId", SqlDbType.Int).Value = SkillsId;
                            dataAdapter.Fill(dataSet);
                        }
                    }
                }
            }
            catch (Exception ex)
            {

            }
            return dataSet;
        }
        public static DataSet GetExpirySheet(string ConnectionString, string SearchDate)
        {
            string storedProcedure = "bsm.GetExpirySheet";
            DataSet dataSet = new DataSet();
            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    using (SqlCommand command = new SqlCommand(storedProcedure, connection))
                    {
                        using (SqlDataAdapter dataAdapter = new SqlDataAdapter(command))
                        {
                            command.CommandType = CommandType.StoredProcedure;
                            command.Parameters.Add("@searchDate", SqlDbType.VarChar).Value = SearchDate;
                            dataAdapter.Fill(dataSet);
                        }
                    }
                }
            }
            catch (Exception ex)
            {

            }
            return dataSet;
        }
        public static void AddCurrentloggedInUser(string ConnectionString, string UserName)
        {
            string storedProcedure = "bsm.AddCurrentLoggedInUser";
            DataSet dataSet = new DataSet();
            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand(storedProcedure, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add("@userName", SqlDbType.VarChar).Value = UserName;
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {

            }
            
        }
        public static DataSet GetReviewSheet(string ConnectionString, string ReviewerName, string AuditDate)
        {
            string storedProcedure = "bsm.GetReviewSheet";
            DataSet dataSet = new DataSet();
            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    using (SqlCommand command = new SqlCommand(storedProcedure, connection))
                    {
                        using (SqlDataAdapter dataAdapter = new SqlDataAdapter(command))
                        {
                            command.CommandType = CommandType.StoredProcedure;
                            command.Parameters.Add("@reviewerName", SqlDbType.VarChar).Value = ReviewerName;
                            command.Parameters.Add("@auditDate", SqlDbType.VarChar).Value = AuditDate;
                            dataAdapter.Fill(dataSet);
                        }
                    }
                }
            }
            catch (Exception ex)
            {

            }
            return dataSet;
        }
        public static void EditAuditLog(string ConnectionString, string AuditLogId, string Comment)
        {
            string storedProcedure = "bsm.UpdateReviewSheet";
            DataSet dataSet = new DataSet();
            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand(storedProcedure, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add("@auditLogId", SqlDbType.VarChar).Value = AuditLogId;
                        command.Parameters.Add("@comment", SqlDbType.VarChar).Value = Comment;
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {

            }

        }
        public static DataSet GetEmployee(string ConnectionString, string username, string password)
        {
            string storedProcedure = "bsm.GetLoginEmployee";
            DataSet dataSet = new DataSet();
            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {

                    using (SqlCommand command = new SqlCommand(storedProcedure, connection))
                    {
                        SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
                        try
                        {
                            command.CommandType = CommandType.StoredProcedure;
                            command.Parameters.Add("@username", SqlDbType.VarChar).Value = username;
                            command.Parameters.Add("@password", SqlDbType.VarChar).Value = password;
                            dataAdapter.Fill(dataSet);
                            return dataSet;
                        }
                        finally
                        {
                            ((IDisposable)(object)dataAdapter)?.Dispose();
                        }
                    }
                }
            }
            catch (Exception)
            {
                return null;
            }
        }
    }
}
