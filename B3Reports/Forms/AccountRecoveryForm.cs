using System;
using System.Drawing;
using System.Windows.Forms;
using GameTech.B3Reports.Properties;

namespace GameTech.B3Reports.Forms
{
    public partial class AccountRecoveryForm : GradientForm
    {
        private readonly Timer m_statusTimer = new Timer();
        public AccountRecoveryForm()
        {
            InitializeComponent();
            StatusLabel.Text = string.Empty;
            m_statusTimer.Interval = 3000;
            m_statusTimer.Tick += OnStatusTimerTick;
        }

        public void OnStatusTimerTick(object sender, EventArgs e)
        {
            StatusLabel.Text = string.Empty;
            m_statusTimer.Stop();
        }

        private void RecoverButtonClick(object sender, EventArgs e)
        {
            m_statusTimer.Stop();
            m_statusTimer.Start();

            int accountNumber;
            if (!int.TryParse(AccountNumberTextBox.Text, out accountNumber))
            {
                StatusLabel.ForeColor = Color.Red;
                StatusLabel.Text = Resources.Invalid_Account_Number_String;
                return;
            }

            var accountStatus = RecoverOrphanedAccount.Recover(accountNumber);
            switch (accountStatus)
            {
                case RecoverAccountStatus.Success:
                    StatusLabel.ForeColor = Color.Green;
                    StatusLabel.Text = Resources.Account_Recovered_String;
                    break;
                case RecoverAccountStatus.NoActiveSession:
                    StatusLabel.ForeColor = Color.Red;
                    StatusLabel.Text = Resources.No_active_session_String;
                    break;
                case RecoverAccountStatus.ReceiptHasAlreadyBeenRedeemed:
                    StatusLabel.ForeColor = Color.Red;
                    StatusLabel.Text = Resources.Receipt_has_already_been_redeemed_String;
                    break;
                case RecoverAccountStatus.AccountNotOrphaned:
                    StatusLabel.ForeColor = Color.Black;
                    StatusLabel.Text = Resources.Account_does_not_need_to_be_recovered;
                    break;
                default:
                    StatusLabel.ForeColor = Color.Red;
                    StatusLabel.Text = Resources.Invalid_Account_Number_String;
                    break;
            }
        }

        private void CancelButtonClick(object sender, EventArgs e)
        {
            m_statusTimer.Stop();
        }

        private void AccountNumberKeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (char) Keys.Back)
            {
                return;
            }

            if (e.KeyChar == (char)13)
            {
                RecoverButton.PerformClick();
                return;
            }

            if (AccountNumberTextBox.Text.Length > 12)
            {
                e.Handled = true;
                return;
            }


            if (!char.IsDigit(e.KeyChar))
            {
                e.Handled = true;
            }
        }
    }
}
