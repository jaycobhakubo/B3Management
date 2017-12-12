using System;
using System.Data.SqlClient;
using System.Threading.Tasks;
using System.Windows.Forms;
using GameTech.B3Reports._cs_Other;

namespace GameTech.B3Reports.Forms
{
    public partial class DatabaseConnectionForm : GradientForm
    {
        private readonly bool m_connectOnLoad;

        public DatabaseConnectionForm(bool connectOnLoad)
        {
            InitializeComponent();
            m_connectOnLoad = connectOnLoad;
        }

        private void DatabaseConnectionForm_Load(object sender, EventArgs e)
        {
            txtbxDatabasePassword.PasswordChar = '\u25CF';
            pnlWarning.Visible = false;
            lblConnecting.Visible = false;

            txtbxDatabaseServer.Text = B3DatabaseConnection.GetServerNameFromRegistry();
            txtbxDatabaseName.Text = B3DatabaseConnection.GetDatabaseNameFromRegistry();
            txtbxDatabaseUser.Text = B3DatabaseConnection.GetDatabaseUserFromRegistry();
            txtbxDatabasePassword.Text = B3DatabaseConnection.GetDatabasePasswordRegistry();


            //fire button connect click event if flag is set
            if (m_connectOnLoad)
            {
                imgBtnConnect_Click(null, EventArgs.Empty);
            }
        }

        private void EnableControls(bool enable)
        {
            lblDatabaseName.Enabled = enable;
            lblDatabaseServer.Enabled = enable;
            lblDatabaseUser.Enabled = enable;
            lblDatabasePassword.Enabled = enable;
            lblB3DatabaseConnection.Enabled = enable;

            txtbxDatabaseServer.Enabled = enable;
            txtbxDatabaseName.Enabled = enable;
            txtbxDatabaseUser.Enabled = enable;
            txtbxDatabasePassword.Enabled = enable;
        }

        private bool IsValidConnection(string connectionString)
        {
            var isValid = false;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                try
                {
                    connection.Open();
                    isValid = true;
                }
                catch
                {
                    // ignored
                }
                finally
                {
                    connection.Close();
                }
            }

            return isValid;
        }

        private void ConnectionAttemptCompleted(bool isValid)
        {
            if (isValid)
            {
                B3DatabaseConnection.SaveCredentials(txtbxDatabaseServer.Text,
                    txtbxDatabaseName.Text,
                    txtbxDatabaseUser.Text,
                    txtbxDatabasePassword.Text);
                DialogResult = DialogResult.OK;
                Close();
            }
            else
            {
                pnlWarning.Visible = true;
            }

            lblConnecting.Visible = false;
            EnableControls(true);
        }

        private void txtbx_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (char)13)
            {
                SendKeys.Send("{TAB}");
            }
        }

        private void txtbx_PasswordKeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (char)13)
            {
                imgBtnConnect_Click(null, EventArgs.Empty);
            }
        }

        private void txtbx_TextChanged(object sender, EventArgs e)
        {
            var textbox = sender as TextBox;
            if (textbox == null)
            {
                return;
            }
            pnlWarning.Visible = false;

            imgBtnConnect.Enabled = !string.IsNullOrWhiteSpace(textbox.Text);
        }

        private void imgBtnConnect_Click(object sender, EventArgs e)
        {
            EnableControls(false);
            imgBtnConnect.Enabled = false;
            lblConnecting.Visible = true;

            bool isValid;

            var connectionString = string.Format(B3DatabaseConnection.ConnectionStringTemplate,
                    txtbxDatabaseServer.Text,
                    txtbxDatabaseName.Text,
                    txtbxDatabaseUser.Text,
                    txtbxDatabasePassword.Text);

            Task.Factory.StartNew(() =>
            {
                isValid = IsValidConnection(connectionString);

                //invoke back to UI thread
                Invoke(new Action(() => { ConnectionAttemptCompleted(isValid); }));

            });
        }

        public bool IsValidDatabaseConnection()
        {
            return IsValidConnection(B3DatabaseConnection.GetConnectionString);
        }

    }
}
