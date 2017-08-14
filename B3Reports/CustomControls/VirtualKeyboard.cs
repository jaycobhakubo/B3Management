#region Copyright
// This is an unpublished work protected under the copyright laws of the
// United States and other countries.  All rights reserved.  Should
// publication occur the following will apply:  © 2008 GameTech
// International, Inc.
#endregion

using System;
using System.IO;
using System.Collections;
using System.Drawing;
using System.Globalization;
using System.Windows.Forms;
using System.Windows.Forms.Design;
using System.ComponentModel;
using System.ComponentModel.Design;

//namespace GTI.Controls
namespace GameTech.B3Reports.Forms
{
    /// <summary>
    /// This control represents an onscreen keyboard.
    /// This keyboard is designed to be used with the SendKeys class, so
    /// it may not be appropriate for non-Latin based languages.
    /// </summary>
    [Description("GameTech Virtual Keyboard")]
    [DesignerAttribute(typeof(VirtualKeyboardDesigner))]
    public partial class VirtualKeyboard : UserControl
    {
        #region Constants And Data Types
        /// <summary>
        /// Represents an arrangement of keys on the keyboard.
        /// </summary>
        public enum KeyboardLayout
        {
            US,
            Spanish,
            UK
        }

        // Key sizes and positions.
        protected readonly Size BigShiftKey = new Size(125, 50);
        protected readonly Size LittleShiftKey = new Size(75, 50);
        protected readonly Size BigEnterKey = new Size(100, 50);
        protected readonly Size LittleEnterKey = new Size(50, 50);

        protected readonly Point BigEnterKeyLocation = new Point(650, 100);
        protected readonly Point LittleEnterKeyLocation = new Point(700, 100);

        // Key Maps
        // US
        protected readonly string[,] USKeyMap = new string[,]
            {
                {"`", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "=", "{BACKSPACE}"},
                {"{TAB}", "q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "{[}", "{]}", "\\"},
                {"", "a", "s", "d", "f", "g", "h", "j", "k", "l", ";", "\'", "{ENTER}", ""},
                {"", "z", "x", "c", "v", "b", "n", "m", ",", ".", "/", "", " ", ""}
            };

        protected readonly string[,] USKeyMapShift = new string[,]
            {
                {"+`", "!", "@", "#", "$", "+5", "+6", "&", "*", "+9", "+0", "_", "+=", "{BACKSPACE}"},
                {"+{TAB}", "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "+{[}", "+{]}", "|"},
                {"", "A", "S", "D", "F", "G", "H", "J", "K", "L", ":", "\"", "{ENTER}", ""},
                {"", "Z", "X", "C", "V", "B", "N", "M", "<", ">", "?", "", " ", ""}
            };

        protected readonly string[,] USKeyMapCaps = new string[,]
            {
                {"`", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "=", "{BACKSPACE}"},
                {"{TAB}", "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "{[}", "{]}", "\\"},
                {"", "A", "S", "D", "F", "G", "H", "J", "K", "L", ";", "\'", "{ENTER}", ""},
                {"", "Z", "X", "C", "V", "B", "N", "M", ",", ".", "/", "", " ", ""}
            };

        // Spanish
        protected readonly string[,] SpanishKeyMap = new string[,]
            {
                {"°", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "\'", "¡", "{BACKSPACE}"},
                {"{TAB}", "q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "`", "+=", ""},
                {"", "a", "s", "d", "f", "g", "h", "j", "k", "l", "ñ", "´", "ç", "{ENTER}"},
                {"", "<", "z", "x", "c", "v", "b", "n", "m", ",", ".", "-", "", " "}
            };

        protected readonly string[,] SpanishKeyMapShift = new string[,]
            {
                {"ª", "!", "\"", "•", "$", "+5", "&", "/", "+9", "+0", "=", "?", "¿", "{BACKSPACE}"},
                {"+{TAB}", "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "+6", "*", ""},
                {"", "A", "S", "D", "F", "G", "H", "J", "K", "L", "Ñ", "¨", "Ç", "{ENTER}"},
                {"", ">", "Z", "X", "C", "V", "B", "N", "M", ";", ":", "_", "", " "}
            };

        protected readonly string[,] SpanishKeyMapCaps = new string[,]
            {
                {"°", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "\'", "¡", "{BACKSPACE}"},
                {"{TAB}", "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "`", "+=", ""},
                {"", "A", "S", "D", "F", "G", "H", "J", "K", "L", "Ñ", "´", "Ç", "{ENTER}"},
                {"", "<", "Z", "X", "C", "V", "B", "N", "M", ",", ".", "-", "", " "}
            };

        protected readonly string[,] SpanishKeyMapAltGr = new string[,]
            {
                {"\\", "|", "@", "#", "+`", "€", "¬", "", "", "", "", "", "", "{BACKSPACE}"},
                {"{TAB}", "", "", "", "", "", "", "", "", "", "", "{[}", "{]}", ""},
                {"", "", "", "", "", "", "", "", "", "", "", "+{[}", "+{]}", "{ENTER}"},
                {"", "", "", "", "", "", "", "", "", "", "", "", "", " "}
            };

        // PDTS 964
        // UK
        protected readonly string[,] UKKeyMap = new string[,]
            {
                {"`", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "=", "{BACKSPACE}"},
                {"{TAB}", "q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "{[}", "{]}", ""},
                {"", "a", "s", "d", "f", "g", "h", "j", "k", "l", ";", "\'", "#", "{ENTER}"},
                {"", "\\", "z", "x", "c", "v", "b", "n", "m", ",", ".", "/", "", " "}
            };

        protected readonly string[,] UKKeyMapShift = new string[,]
            {
                {"¬", "!", "\"", "£", "$", "+5", "+6", "&", "*", "+9", "+0", "_", "+=", "{BACKSPACE}"},
                {"+{TAB}", "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "+{[}", "+{]}", ""},
                {"", "A", "S", "D", "F", "G", "H", "J", "K", "L", ":", "@", "+`", "{ENTER}"},
                {"", "|", "Z", "X", "C", "V", "B", "N", "M", "<", ">", "?", "", " "}
            };

        protected readonly string[,] UKKeyMapCaps = new string[,]
            {
                {"`", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "=", "{BACKSPACE}"},
                {"{TAB}", "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "{[}", "{]}", ""},
                {"", "A", "S", "D", "F", "G", "H", "J", "K", "L", ";", "\'", "#", "{ENTER}"},
                {"", "\\", "Z", "X", "C", "V", "B", "N", "M", ",", ".", "/", "", " "}
            };

        protected readonly string[,] UKKeyMapAltGr = new string[,]
            {
                {"¦", "", "", "", "€", "", "", "", "", "", "", "", "", "{BACKSPACE}"},
                {"{TAB}", "", "", "é", "", "", "", "ú", "í", "ó", "", "", "", ""},
                {"", "á", "", "", "", "", "", "", "", "", "", "", "", "{ENTER}"},
                {"", "", "", "", "", "", "", "", "", "", "", "", "", " "}
            };

        protected readonly string[,] UKKeyMapShiftAltGr = new string[,]
            {
                {"¦", "", "", "", "€", "", "", "", "", "", "", "", "", "{BACKSPACE}"},
                {"{TAB}", "", "", "É", "", "", "", "Ú", "Í", "Ó", "", "", "", ""},
                {"", "Á", "", "", "", "", "", "", "", "", "", "", "", "{ENTER}"},
                {"", "", "", "", "", "", "", "", "", "", "", "", "", " "}
            };

        protected readonly string[,] UKKeyMapCapsAltGr = new string[,]
            {
                {"¦", "", "", "", "€", "", "", "", "", "", "", "", "", "{BACKSPACE}"},
                {"{TAB}", "", "", "É", "", "", "", "Ú", "Í", "Ó", "", "", "", ""},
                {"", "Á", "", "", "", "", "", "", "", "", "", "", "", "{ENTER}"},
                {"", "", "", "", "", "", "", "", "", "", "", "", "", " "}
            };
        #endregion

        #region Events
        /// <summary>
        /// Occurs when a key on the keyboard is pressed.
        /// </summary>
        [Description("Occurs when a key on the keyboard is pressed.")]
        [Category("Action")]
        public event KeyboardEventHandler KeyPressed;
        #endregion

        #region Member Variables
        public string m_keys = string.Empty;
        protected KeyboardLayout m_layout = KeyboardLayout.US;
        protected bool m_shiftPressed = false;
        protected bool m_altGrPressed = false;
        protected bool m_capsLockOn = false;
        protected char m_deadKey = char.MinValue;
        protected Image m_capsLockImageNormal = null;
        protected Image m_shiftImageNormal = null;
        protected Image m_altGrImageNormal = null;
        #endregion

        #region Constructors
        /// <summary>
        /// Initializes a new instance of the VirtualKeyboard class.
        /// </summary>
        public VirtualKeyboard()
        {
            InitializeComponent();

            // Initialize the US Layout.
            ChangeLayout();
        }
        #endregion

        #region Member Methods
        // PDTS 964
        /// <summary>
        /// Changes the layout of the keys on the keyboard based on the culture 
        /// passed in.
        /// </summary>
        public void SetLayoutByCulture(CultureInfo culture)
        {
            switch(culture.TwoLetterISOLanguageName)
            {
                case "es":
                    KeyLayout = KeyboardLayout.Spanish;
                    break;

                case "en":
                    if(culture.Name == "en-GB" || culture.Name == "en-IE")
                        KeyLayout = KeyboardLayout.UK;
                    else
                        KeyLayout = KeyboardLayout.US;

                    break;

                default:
                    KeyLayout = KeyboardLayout.US;
                    break;
            }
        }

        /// <summary>
        /// Changes the layout of the keys on the keyboard.
        /// </summary>
        private void ChangeLayout()
        {
            // Reset the buttons states.
            m_shiftPressed = false;
            m_altGrPressed = false;
            m_capsLockOn = false;

            UpdateButtonStates();

            switch(m_layout)
            {
                case KeyboardLayout.US:
                default:
                    SetUSLayout();
                    break;

                case KeyboardLayout.Spanish:
                    SetSpanishLayout();
                    break;

                // PDTS 964
                case KeyboardLayout.UK:
                    SetUKLayout();
                    break;
            }
        }

        /// <summary>
        /// Updates the graphics for togglable buttons (Caps, Shift, AltGr).
        /// </summary>
        private void UpdateButtonStates()
        {
            if(m_capsLockKey.ImageNormal != null)
            {
                if(m_capsLockOn)
                    m_capsLockKey.ImageNormal = m_capsLockKey.ImagePressed;
                else
                    m_capsLockKey.ImageNormal = m_capsLockImageNormal;
            }

            if(m_lShiftKey.ImageNormal != null)
            {
                if(m_shiftPressed)
                {
                    m_lShiftKey.ImageNormal = m_lShiftKey.ImagePressed;
                    m_rShiftKey.ImageNormal = m_rShiftKey.ImagePressed;
                }
                else
                {
                    m_lShiftKey.ImageNormal = m_shiftImageNormal;
                    m_rShiftKey.ImageNormal = m_shiftImageNormal;
                }
            }

            if(m_altGrKey.ImageNormal != null)
            {
                if(m_altGrPressed)
                    m_altGrKey.ImageNormal = m_altGrKey.ImagePressed;
                else
                    m_altGrKey.ImageNormal = m_altGrImageNormal;
            }
        }
        
        /// <summary>
        /// Handles a key click event.
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">An EventArgs object that contains 
        /// the event data.</param>
        private void KeyClick(object sender, EventArgs e)
        {
            if(sender is ImageButton)
            {
                Point charPos = (Point)((ImageButton)sender).Tag;

                if(m_altGrPressed)
                {
                    m_altGrPressed = false;
                    UpdateButtonStates();

                    switch(m_layout)
                    {
                        case KeyboardLayout.US:
                        default:
                            m_keys = USKeyMap[charPos.X, charPos.Y];
                            break;

                        case KeyboardLayout.Spanish:
                            m_keys = CheckForDeadKey(SpanishKeyMapAltGr[charPos.X, charPos.Y]);
                            break;

                        // PDTS 964
                        case KeyboardLayout.UK:
                            if(m_shiftPressed)
                            {
                                m_shiftPressed = false;
                                UpdateButtonStates();
                                m_keys = UKKeyMapShiftAltGr[charPos.X, charPos.Y];
                            }
                            else if(m_capsLockOn)
                                m_keys = UKKeyMapCapsAltGr[charPos.X, charPos.Y];
                            else
                                m_keys = UKKeyMapAltGr[charPos.X, charPos.Y];

                            break;
                    }
                }
                else if(m_shiftPressed)
                {
                    m_shiftPressed = false;
                    UpdateButtonStates();

                    switch(m_layout)
                    {
                        case KeyboardLayout.US:
                        default:
                            m_keys = USKeyMapShift[charPos.X, charPos.Y];
                            break;

                        case KeyboardLayout.Spanish:
                            m_keys = CheckForDeadKey(SpanishKeyMapShift[charPos.X, charPos.Y]);
                            break;

                        // PDTS 964
                        case KeyboardLayout.UK:
                            m_keys = UKKeyMapShift[charPos.X, charPos.Y];
                            break;
                    }
                }
                else if(m_capsLockOn)
                {
                    switch(m_layout)
                    {
                        case KeyboardLayout.US:
                        default:
                            m_keys = USKeyMapCaps[charPos.X, charPos.Y];
                            break;

                        case KeyboardLayout.Spanish:
                            m_keys = CheckForDeadKey(SpanishKeyMapCaps[charPos.X, charPos.Y]);
                            break;

                        // PDTS 964
                        case KeyboardLayout.UK:
                            m_keys = UKKeyMapCaps[charPos.X, charPos.Y];
                            break;
                    }
                }
                else
                {
                    switch(m_layout)
                    {
                        case KeyboardLayout.US:
                        default:
                            m_keys = USKeyMap[charPos.X, charPos.Y];
                            break;

                        case KeyboardLayout.Spanish:
                            m_keys = CheckForDeadKey(SpanishKeyMap[charPos.X, charPos.Y]);
                            break;

                        // PDTS 964
                        case KeyboardLayout.UK:
                            m_keys = UKKeyMap[charPos.X, charPos.Y];
                            break;
                    }
                }

                if(m_keys != string.Empty)
                {
                    OnKeyPressed();
                    m_keys = string.Empty;
                }
            }
        }

        /// <summary>
        /// Checks to see if this key press is part of the dead key combo.
        /// </summary>
        /// <param name="key">The key to check.</param>
        /// <returns>The resulting character if it is the last key in a combo, 
        /// an empty string if this is the first key in a combo, or else the 
        /// original key.</returns>
        private string CheckForDeadKey(string key)
        {
            string returnVal = key;

            if(returnVal != string.Empty)
            {
                // Handle the dead key check based on layout.
                switch(m_layout)
                {
                    case KeyboardLayout.Spanish:
                        returnVal = CheckForDeadKeySpanish(key);
                        break;
                }
            }

            return returnVal;
        }

        /// <summary>
        /// Handles the caps lock key click event.
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">An EventArgs object that contains 
        /// the event data.</param>
        private void CapsLockClick(object sender, EventArgs e)
        {
            m_capsLockOn = !m_capsLockOn;
            UpdateButtonStates();
        }

        /// <summary>
        /// Handles the shift key click event.
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">An EventArgs object that contains 
        /// the event data.</param>
        private void ShiftClick(object sender, EventArgs e)
        {
            m_shiftPressed = !m_shiftPressed;
            UpdateButtonStates();
        }

        /// <summary>
        /// Handles the alt gr key click event.
        /// </summary>
        /// <param name="sender">The sender of the event.</param>
        /// <param name="e">An EventArgs object that contains 
        /// the event data.</param>
        private void AltGrClick(object sender, EventArgs e)
        {
            m_altGrPressed = !m_altGrPressed;
            UpdateButtonStates();
        }
        
        /// <summary>
        /// Raises the KeyPressed event.
        /// </summary>
        protected void OnKeyPressed()
        {
            KeyboardEventHandler handler = KeyPressed;

            if(handler != null)
                handler(this, new KeyboardEventArgs(m_keys));
        }

        #region US Keyboard Methods
        /// <summary>
        /// Changes the keyboard to a United States layout.
        /// </summary>
        private void SetUSLayout()
        {
            // Show/hide the needed buttons.
            m_pipeKey.Visible = true;
            m_lessThanKey.Visible = false;
            m_cedillaKey.Visible = false;
            m_altGrKey.Visible = false;

            m_lShiftKey.Size = BigShiftKey;
            m_enterKey.Size = BigEnterKey;
            m_enterKey.Location = BigEnterKeyLocation;

            // Set the text on the keys.
            m_tildeKey.Text = "~\n`";
            m_tildeKey.Tag = new Point(0, 0);
            m_1Key.Text = "!\n1";
            m_1Key.Tag = new Point(0, 1);
            m_2Key.Text = "@\n2";
            m_2Key.Tag = new Point(0, 2);
            m_3Key.Text = "#\n3";
            m_3Key.Tag = new Point(0, 3);
            m_4Key.Text = "$\n4";
            m_4Key.Tag = new Point(0, 4);
            m_5Key.Text = "%\n5";
            m_5Key.Tag = new Point(0, 5);
            m_6Key.Text = "^\n6";
            m_6Key.Tag = new Point(0, 6);
            m_7Key.Text = "&\n7";
            m_7Key.Tag = new Point(0, 7);
            m_8Key.Text = "*\n8";
            m_8Key.Tag = new Point(0, 8);
            m_9Key.Text = "(\n9";
            m_9Key.Tag = new Point(0, 9);
            m_0Key.Text = ")\n0";
            m_0Key.Tag = new Point(0, 10);
            m_minusKey.Text = "_\n-";
            m_minusKey.Tag = new Point(0, 11);
            m_equalKey.Text = "+\n=";
            m_equalKey.Tag = new Point(0, 12);
            m_backspaceKey.Text = "Backspace";
            m_backspaceKey.Tag = new Point(0, 13);
            m_tabKey.Text = "Tab";
            m_tabKey.Tag = new Point(1, 0);
            m_qKey.Text = "Q";
            m_qKey.Tag = new Point(1, 1);
            m_wKey.Text = "W";
            m_wKey.Tag = new Point(1, 2);
            m_eKey.Text = "E";
            m_eKey.Tag = new Point(1, 3);
            m_rKey.Text = "R";
            m_rKey.Tag = new Point(1, 4);
            m_tKey.Text = "T";
            m_tKey.Tag = new Point(1, 5);
            m_yKey.Text = "Y";
            m_yKey.Tag = new Point(1, 6);
            m_uKey.Text = "U";
            m_uKey.Tag = new Point(1, 7);
            m_iKey.Text = "I";
            m_iKey.Tag = new Point(1, 8);
            m_oKey.Text = "O";
            m_oKey.Tag = new Point(1, 9);
            m_pKey.Text = "P";
            m_pKey.Tag = new Point(1, 10);
            m_openBracketKey.Text = "{\n[";
            m_openBracketKey.Tag = new Point(1, 11);
            m_closeBracketKey.Text = "}\n]";
            m_closeBracketKey.Tag = new Point(1, 12);
            m_pipeKey.Text = "|\n\\";
            m_pipeKey.Tag = new Point(1, 13);
            m_capsLockKey.Text = "Caps Lock";
            m_capsLockKey.Tag = new Point(2, 0);
            m_aKey.Text = "A";
            m_aKey.Tag = new Point(2, 1);
            m_sKey.Text = "S";
            m_sKey.Tag = new Point(2, 2);
            m_dKey.Text = "D";
            m_dKey.Tag = new Point(2, 3);
            m_fKey.Text = "F";
            m_fKey.Tag = new Point(2, 4);
            m_gKey.Text = "G";
            m_gKey.Tag = new Point(2, 5);
            m_hKey.Text = "H";
            m_hKey.Tag = new Point(2, 6);
            m_jKey.Text = "J";
            m_jKey.Tag = new Point(2, 7);
            m_kKey.Text = "K";
            m_kKey.Tag = new Point(2, 8);
            m_lKey.Text = "L";
            m_lKey.Tag = new Point(2, 9);
            m_semicolonKey.Text = ":\n;";
            m_semicolonKey.Tag = new Point(2, 10);
            m_quotesKey.Text = "\"\n'";
            m_quotesKey.Tag = new Point(2, 11);
            m_enterKey.Text = "Enter";
            m_enterKey.Tag = new Point(2, 12);
            m_lShiftKey.Text = "Shift";
            m_lShiftKey.Tag = new Point(3, 0);
            m_zKey.Text = "Z";
            m_zKey.Tag = new Point(3, 1);
            m_xKey.Text = "X";
            m_xKey.Tag = new Point(3, 2);
            m_cKey.Text = "C";
            m_cKey.Tag = new Point(3, 3);
            m_vKey.Text = "V";
            m_vKey.Tag = new Point(3, 4);
            m_bKey.Text = "B";
            m_bKey.Tag = new Point(3, 5);
            m_nKey.Text = "N";
            m_nKey.Tag = new Point(3, 6);
            m_mKey.Text = "M";
            m_mKey.Tag = new Point(3, 7);
            m_commaKey.Text = "<\n,";
            m_commaKey.Tag = new Point(3, 8);
            m_periodKey.Text = ">\n.";
            m_periodKey.Tag = new Point(3, 9);
            m_questionKey.Text = "?\n/";
            m_questionKey.Tag = new Point(3, 10);
            m_rShiftKey.Text = "Shift";
            m_rShiftKey.Tag = new Point(3, 11);
            m_spaceKey.Text = string.Empty;
            m_spaceKey.Tag = new Point(3, 12);
            m_altGrKey.Text = "Alt";
            m_altGrKey.Tag = new Point(3, 13);
        }
        #endregion

        #region Spanish Keyboard Methods
        /// <summary>
        /// Changes the keyboard to a Spanish layout.
        /// </summary>
        private void SetSpanishLayout()
        {
            // Show/hide the needed buttons.
            m_pipeKey.Visible = false;
            m_lessThanKey.Visible = true;
            m_cedillaKey.Visible = true;
            m_altGrKey.Visible = true;

            m_lShiftKey.Size = LittleShiftKey;
            m_enterKey.Size = LittleEnterKey;
            m_enterKey.Location = LittleEnterKeyLocation;

            // Set the text on the keys.
            m_tildeKey.Text = "ª  \n°  \\";
            m_tildeKey.Tag = new Point(0, 0);
            m_1Key.Text = "!\n1  |";
            m_1Key.Tag = new Point(0, 1);
            m_2Key.Text = "\"\n2  @";
            m_2Key.Tag = new Point(0, 2);
            m_3Key.Text = "•\n3  #";
            m_3Key.Tag = new Point(0, 3);
            m_4Key.Text = "$\n4  ~";
            m_4Key.Tag = new Point(0, 4);
            m_5Key.Text = "%\n5  €";
            m_5Key.Tag = new Point(0, 5);
            m_6Key.Text = "&\n6  ¬";
            m_6Key.Tag = new Point(0, 6);
            m_7Key.Text = "/\n7";
            m_7Key.Tag = new Point(0, 7);
            m_8Key.Text = "(\n8";
            m_8Key.Tag = new Point(0, 8);
            m_9Key.Text = ")\n9";
            m_9Key.Tag = new Point(0, 9);
            m_0Key.Text = "=\n0";
            m_0Key.Tag = new Point(0, 10);
            m_minusKey.Text = "?\n\'";
            m_minusKey.Tag = new Point(0, 11);
            m_equalKey.Text = "¿\n¡";
            m_equalKey.Tag = new Point(0, 12);
            m_backspaceKey.Text = "<----";
            m_backspaceKey.Tag = new Point(0, 13);
            m_tabKey.Text = "|<---\n--->|";
            m_tabKey.Tag = new Point(1, 0);
            m_qKey.Text = "Q";
            m_qKey.Tag = new Point(1, 1);
            m_wKey.Text = "W";
            m_wKey.Tag = new Point(1, 2);
            m_eKey.Text = "E";
            m_eKey.Tag = new Point(1, 3);
            m_rKey.Text = "R";
            m_rKey.Tag = new Point(1, 4);
            m_tKey.Text = "T";
            m_tKey.Tag = new Point(1, 5);
            m_yKey.Text = "Y";
            m_yKey.Tag = new Point(1, 6);
            m_uKey.Text = "U";
            m_uKey.Tag = new Point(1, 7);
            m_iKey.Text = "I";
            m_iKey.Tag = new Point(1, 8);
            m_oKey.Text = "O";
            m_oKey.Tag = new Point(1, 9);
            m_pKey.Text = "P";
            m_pKey.Tag = new Point(1, 10);
            m_openBracketKey.Text = "^\n`  [";
            m_openBracketKey.Tag = new Point(1, 11);
            m_closeBracketKey.Text = "*\n+  ]";
            m_closeBracketKey.Tag = new Point(1, 12);
            m_capsLockKey.Text = "Bloq Mayús";
            m_capsLockKey.Tag = new Point(2, 0);
            m_aKey.Text = "A";
            m_aKey.Tag = new Point(2, 1);
            m_sKey.Text = "S";
            m_sKey.Tag = new Point(2, 2);
            m_dKey.Text = "D";
            m_dKey.Tag = new Point(2, 3);
            m_fKey.Text = "F";
            m_fKey.Tag = new Point(2, 4);
            m_gKey.Text = "G";
            m_gKey.Tag = new Point(2, 5);
            m_hKey.Text = "H";
            m_hKey.Tag = new Point(2, 6);
            m_jKey.Text = "J";
            m_jKey.Tag = new Point(2, 7);
            m_kKey.Text = "K";
            m_kKey.Tag = new Point(2, 8);
            m_lKey.Text = "L";
            m_lKey.Tag = new Point(2, 9);
            m_semicolonKey.Text = "Ñ";
            m_semicolonKey.Tag = new Point(2, 10);
            m_quotesKey.Text = "¨\n´  {";
            m_quotesKey.Tag = new Point(2, 11);
            m_cedillaKey.Text = "\nÇ  }";
            m_cedillaKey.Tag = new Point(2, 12);
            m_enterKey.Text = "Intro";
            m_enterKey.Tag = new Point(2, 13);
            m_lShiftKey.Text = string.Empty;
            m_lShiftKey.Tag = new Point(3, 0);
            m_lessThanKey.Text = ">\n<";
            m_lessThanKey.Tag = new Point(3, 1);
            m_zKey.Text = "Z";
            m_zKey.Tag = new Point(3, 2);
            m_xKey.Text = "X";
            m_xKey.Tag = new Point(3, 3);
            m_cKey.Text = "C";
            m_cKey.Tag = new Point(3, 4);
            m_vKey.Text = "V";
            m_vKey.Tag = new Point(3, 5);
            m_bKey.Text = "B";
            m_bKey.Tag = new Point(3, 6);
            m_nKey.Text = "N";
            m_nKey.Tag = new Point(3, 7);
            m_mKey.Text = "M";
            m_mKey.Tag = new Point(3, 8);
            m_commaKey.Text = ";\n,";
            m_commaKey.Tag = new Point(3, 9);
            m_periodKey.Text = ":\n.";
            m_periodKey.Tag = new Point(3, 10);
            m_questionKey.Text = "_\n-";
            m_questionKey.Tag = new Point(3, 11);
            m_rShiftKey.Text = string.Empty;
            m_rShiftKey.Tag = new Point(3, 12);
            m_spaceKey.Text = string.Empty;
            m_spaceKey.Tag = new Point(3, 13);
            m_altGrKey.Text = "Alt Gr";
            m_altGrKey.Tag = new Point(3, 0);
        }

        /// <summary>
        /// Checks to see if this key press is part of the dead key 
        /// combo on a Spanish keyboard.
        /// </summary>
        /// <param name="key">The key to check.</param>
        /// <returns>The resulting character if it is the last key in a combo, 
        /// an empty string if this is the first key in a combo, or else the 
        /// original key.</returns>
        string CheckForDeadKeySpanish(string key)
        {
            string returnVal;

            if(m_deadKey != char.MinValue) // The last key in a combo.
            {
                switch(m_deadKey)
                {
                    case '`':
                        switch(key)
                        {
                            case "a":
                                returnVal = "à";
                                break;
                            case "A":
                                returnVal = "À";
                                break;
                            case "e":
                                returnVal = "è";
                                break;
                            case "E":
                                returnVal = "È";
                                break;
                            case "i":
                                returnVal = "ì";
                                break;
                            case "I":
                                returnVal = "Ì";
                                break;
                            case "o":
                                returnVal = "ò";
                                break;
                            case "O":
                                returnVal = "Ò";
                                break;
                            case "u":
                                returnVal = "ù";
                                break;
                            case "U":
                                returnVal = "Ù";
                                break;
                            default:
                                returnVal = m_deadKey.ToString() + key.Trim();
                                break;
                        }
                        break;

                    case '´':
                        switch(key)
                        {
                            case "a":
                                returnVal = "á";
                                break;
                            case "A":
                                returnVal = "Á";
                                break;
                            case "e":
                                returnVal = "é";
                                break;
                            case "E":
                                returnVal = "É";
                                break;
                            case "i":
                                returnVal = "í";
                                break;
                            case "I":
                                returnVal = "Í";
                                break;
                            case "o":
                                returnVal = "ó";
                                break;
                            case "O":
                                returnVal = "Ó";
                                break;
                            case "u":
                                returnVal = "ú";
                                break;
                            case "U":
                                returnVal = "Ú";
                                break;
                            case "y":
                                returnVal = "ý";
                                break;
                            case "Y":
                                returnVal = "Ý";
                                break;
                            default:
                                returnVal = m_deadKey.ToString() + key.Trim();
                                break;
                        }
                        break;

                    case '^':
                        switch(key)
                        {
                            case "a":
                                returnVal = "â";
                                break;
                            case "A":
                                returnVal = "Â";
                                break;
                            case "e":
                                returnVal = "ê";
                                break;
                            case "E":
                                returnVal = "Ê";
                                break;
                            case "i":
                                returnVal = "î";
                                break;
                            case "I":
                                returnVal = "Î";
                                break;
                            case "o":
                                returnVal = "ô";
                                break;
                            case "O":
                                returnVal = "Ô";
                                break;
                            case "u":
                                returnVal = "û";
                                break;
                            case "U":
                                returnVal = "Û";
                                break;
                            default:
                                returnVal = "+6" + key.Trim();
                                break;
                        }
                        break;

                    case '¨':
                        switch(key)
                        {
                            case "a":
                                returnVal = "ä";
                                break;
                            case "A":
                                returnVal = "Ä";
                                break;
                            case "e":
                                returnVal = "ë";
                                break;
                            case "E":
                                returnVal = "Ë";
                                break;
                            case "i":
                                returnVal = "ï";
                                break;
                            case "I":
                                returnVal = "Ï";
                                break;
                            case "o":
                                returnVal = "ö";
                                break;
                            case "O":
                                returnVal = "Ö";
                                break;
                            case "u":
                                returnVal = "ü";
                                break;
                            case "U":
                                returnVal = "Ü";
                                break;
                            case "y":
                                returnVal = "ÿ";
                                break;
                            default:
                                returnVal = m_deadKey.ToString() + key.Trim();
                                break;
                        }
                        break;

                    case '~':
                        switch(key)
                        {
                            case "a":
                                returnVal = "ã";
                                break;
                            case "A":
                                returnVal = "Ã";
                                break;
                            case "n":
                                returnVal = "ñ";
                                break;
                            case "N":
                                returnVal = "Ñ";
                                break;
                            case "o":
                                returnVal = "õ";
                                break;
                            case "O":
                                returnVal = "Õ";
                                break;
                            default:
                                returnVal = "+`" + key.Trim();
                                break;
                        }
                        break;

                    default: // Don't recongnize the dead key so just prepend.
                        returnVal = m_deadKey.ToString() + key;
                        break;
                }

                m_deadKey = char.MinValue;
            }
            else // Check to see if we are starting a combo.
            {
                switch(key)
                {
                    case "`":
                        m_deadKey = key[0];
                        returnVal = string.Empty;
                        break;

                    case "´":
                        m_deadKey = key[0];
                        returnVal = string.Empty;
                        break;

                    case "+6": // ^
                        m_deadKey = '^';
                        returnVal = string.Empty;
                        break;

                    case "¨":
                        m_deadKey = key[0];
                        returnVal = string.Empty;
                        break;

                    case "+`": // ~
                        m_deadKey = '~';
                        returnVal = string.Empty;
                        break;

                    default: // Not a dead key.
                        returnVal = key;
                        break;
                }
            }

            return returnVal;
        }
        #endregion

        #region UK Keyboard Methods
        /// <summary>
        /// Changes the keyboard to a UK layout.
        /// </summary>
        private void SetUKLayout()
        {
            // Show/hide the needed buttons.
            m_pipeKey.Visible = false;
            m_lessThanKey.Visible = true;
            m_cedillaKey.Visible = true;
            m_altGrKey.Visible = true;

            m_lShiftKey.Size = LittleShiftKey;
            m_enterKey.Size = LittleEnterKey;
            m_enterKey.Location = LittleEnterKeyLocation;

            // Set the text on the keys.
            m_tildeKey.Text = "¬  \n`  ¦";
            m_tildeKey.Tag = new Point(0, 0);
            m_1Key.Text = "!\n1";
            m_1Key.Tag = new Point(0, 1);
            m_2Key.Text = "\"\n2";
            m_2Key.Tag = new Point(0, 2);
            m_3Key.Text = "£\n3";
            m_3Key.Tag = new Point(0, 3);
            m_4Key.Text = "$\n4  €";
            m_4Key.Tag = new Point(0, 4);
            m_5Key.Text = "%\n5";
            m_5Key.Tag = new Point(0, 5);
            m_6Key.Text = "^\n6";
            m_6Key.Tag = new Point(0, 6);
            m_7Key.Text = "&\n7";
            m_7Key.Tag = new Point(0, 7);
            m_8Key.Text = "*\n8";
            m_8Key.Tag = new Point(0, 8);
            m_9Key.Text = "(\n9";
            m_9Key.Tag = new Point(0, 9);
            m_0Key.Text = ")\n0";
            m_0Key.Tag = new Point(0, 10);
            m_minusKey.Text = "_\n-";
            m_minusKey.Tag = new Point(0, 11);
            m_equalKey.Text = "+\n=";
            m_equalKey.Tag = new Point(0, 12);
            m_backspaceKey.Text = "Backspace";
            m_backspaceKey.Tag = new Point(0, 13);
            m_tabKey.Text = "Tab";
            m_tabKey.Tag = new Point(1, 0);
            m_qKey.Text = "Q";
            m_qKey.Tag = new Point(1, 1);
            m_wKey.Text = "W";
            m_wKey.Tag = new Point(1, 2);
            m_eKey.Text = "E  É";
            m_eKey.Tag = new Point(1, 3);
            m_rKey.Text = "R";
            m_rKey.Tag = new Point(1, 4);
            m_tKey.Text = "T";
            m_tKey.Tag = new Point(1, 5);
            m_yKey.Text = "Y";
            m_yKey.Tag = new Point(1, 6);
            m_uKey.Text = "U  Ú";
            m_uKey.Tag = new Point(1, 7);
            m_iKey.Text = "I  Í";
            m_iKey.Tag = new Point(1, 8);
            m_oKey.Text = "O  Ó";
            m_oKey.Tag = new Point(1, 9);
            m_pKey.Text = "P";
            m_pKey.Tag = new Point(1, 10);
            m_openBracketKey.Text = "{\n[";
            m_openBracketKey.Tag = new Point(1, 11);
            m_closeBracketKey.Text = "}\n]";
            m_closeBracketKey.Tag = new Point(1, 12);
            m_capsLockKey.Text = "Caps Lock";
            m_capsLockKey.Tag = new Point(2, 0);
            m_aKey.Text = "A  Á";
            m_aKey.Tag = new Point(2, 1);
            m_sKey.Text = "S";
            m_sKey.Tag = new Point(2, 2);
            m_dKey.Text = "D";
            m_dKey.Tag = new Point(2, 3);
            m_fKey.Text = "F";
            m_fKey.Tag = new Point(2, 4);
            m_gKey.Text = "G";
            m_gKey.Tag = new Point(2, 5);
            m_hKey.Text = "H";
            m_hKey.Tag = new Point(2, 6);
            m_jKey.Text = "J";
            m_jKey.Tag = new Point(2, 7);
            m_kKey.Text = "K";
            m_kKey.Tag = new Point(2, 8);
            m_lKey.Text = "L";
            m_lKey.Tag = new Point(2, 9);
            m_semicolonKey.Text = ":\n;";
            m_semicolonKey.Tag = new Point(2, 10);
            m_quotesKey.Text = "@\n\'";
            m_quotesKey.Tag = new Point(2, 11);
            m_cedillaKey.Text = "~\n#";
            m_cedillaKey.Tag = new Point(2, 12);
            m_enterKey.Text = "Enter";
            m_enterKey.Tag = new Point(2, 13);
            m_lShiftKey.Text = "Shift";
            m_lShiftKey.Tag = new Point(3, 0);
            m_lessThanKey.Text = "|\n\\";
            m_lessThanKey.Tag = new Point(3, 1);
            m_zKey.Text = "Z";
            m_zKey.Tag = new Point(3, 2);
            m_xKey.Text = "X";
            m_xKey.Tag = new Point(3, 3);
            m_cKey.Text = "C";
            m_cKey.Tag = new Point(3, 4);
            m_vKey.Text = "V";
            m_vKey.Tag = new Point(3, 5);
            m_bKey.Text = "B";
            m_bKey.Tag = new Point(3, 6);
            m_nKey.Text = "N";
            m_nKey.Tag = new Point(3, 7);
            m_mKey.Text = "M";
            m_mKey.Tag = new Point(3, 8);
            m_commaKey.Text = "<\n,";
            m_commaKey.Tag = new Point(3, 9);
            m_periodKey.Text = ">\n.";
            m_periodKey.Tag = new Point(3, 10);
            m_questionKey.Text = "?\n/";
            m_questionKey.Tag = new Point(3, 11);
            m_rShiftKey.Text = "Shift";
            m_rShiftKey.Tag = new Point(3, 12);
            m_spaceKey.Text = string.Empty;
            m_spaceKey.Tag = new Point(3, 13);
            m_altGrKey.Text = "Alt Gr";
            m_altGrKey.Tag = new Point(3, 0);
        }
        #endregion
        #endregion

        #region Member Properties
        /// <summary>
        /// Gets or sets the KeyboardLayout.
        /// </summary>
        [Description("Determines how the keys are arranged on the keyboard.")]
        [Category("Appearance")]
        [DefaultValue(KeyboardLayout.US)]
        public KeyboardLayout KeyLayout
        {
            get
            {
                return m_layout;
            }
            set
            {
                if(m_layout != value)
                {
                    m_layout = value;
                    ChangeLayout();
                }
            }
        }

        /// <summary>
        /// Gets or sets the foreground color of the buttons.
        /// </summary>
        [Description("The foreground color of the buttons.")]
        [Category("Appearance")]
        [DefaultValue(KnownColor.ControlText)]
        public Color ButtonForeColor
        {
            get
            {
                return m_tildeKey.ForeColor;
            }
            set
            {
                m_tildeKey.ForeColor = value;
                m_1Key.ForeColor = value;
                m_2Key.ForeColor = value;
                m_3Key.ForeColor = value;
                m_4Key.ForeColor = value;
                m_5Key.ForeColor = value;
                m_6Key.ForeColor = value;
                m_7Key.ForeColor = value;
                m_8Key.ForeColor = value;
                m_9Key.ForeColor = value;
                m_0Key.ForeColor = value;
                m_minusKey.ForeColor = value;
                m_equalKey.ForeColor = value;
                m_backspaceKey.ForeColor = value;
                m_tabKey.ForeColor = value;
                m_qKey.ForeColor = value;
                m_wKey.ForeColor = value;
                m_eKey.ForeColor = value;
                m_rKey.ForeColor = value;
                m_tKey.ForeColor = value;
                m_yKey.ForeColor = value;
                m_uKey.ForeColor = value;
                m_iKey.ForeColor = value;
                m_oKey.ForeColor = value;
                m_pKey.ForeColor = value;
                m_openBracketKey.ForeColor = value;
                m_closeBracketKey.ForeColor = value;
                m_pipeKey.ForeColor = value;
                m_capsLockKey.ForeColor = value;
                m_aKey.ForeColor = value;
                m_sKey.ForeColor = value;
                m_dKey.ForeColor = value;
                m_fKey.ForeColor = value;
                m_gKey.ForeColor = value;
                m_hKey.ForeColor = value;
                m_jKey.ForeColor = value;
                m_kKey.ForeColor = value;
                m_lKey.ForeColor = value;
                m_semicolonKey.ForeColor = value;
                m_quotesKey.ForeColor = value;
                m_cedillaKey.ForeColor = value;
                m_enterKey.ForeColor = value;
                m_lShiftKey.ForeColor = value;
                m_lessThanKey.ForeColor = value;
                m_zKey.ForeColor = value;
                m_xKey.ForeColor = value;
                m_cKey.ForeColor = value;
                m_vKey.ForeColor = value;
                m_bKey.ForeColor = value;
                m_nKey.ForeColor = value;
                m_mKey.ForeColor = value;
                m_commaKey.ForeColor = value;
                m_periodKey.ForeColor = value;
                m_questionKey.ForeColor = value;
                m_rShiftKey.ForeColor = value;
                m_spaceKey.ForeColor = value;
                m_altGrKey.ForeColor = value;
            }
        }

        /// <summary>
        /// Gets or sets the background color of the control.
        /// </summary>
        [Description("The background color of the control.")]
        [Category("Appearance")]
        [DefaultValue(KnownColor.Control)]
        public override Color BackColor
        {
            get
            {
                return base.BackColor;
            }
            set
            {
                base.BackColor = value;
                m_tildeKey.BackColor = value;
                m_1Key.BackColor = value;
                m_2Key.BackColor = value;
                m_3Key.BackColor = value;
                m_4Key.BackColor = value;
                m_5Key.BackColor = value;
                m_6Key.BackColor = value;
                m_7Key.BackColor = value;
                m_8Key.BackColor = value;
                m_9Key.BackColor = value;
                m_0Key.BackColor = value;
                m_minusKey.BackColor = value;
                m_equalKey.BackColor = value;
                m_backspaceKey.BackColor = value;
                m_tabKey.BackColor = value;
                m_qKey.BackColor = value;
                m_wKey.BackColor = value;
                m_eKey.BackColor = value;
                m_rKey.BackColor = value;
                m_tKey.BackColor = value;
                m_yKey.BackColor = value;
                m_uKey.BackColor = value;
                m_iKey.BackColor = value;
                m_oKey.BackColor = value;
                m_pKey.BackColor = value;
                m_openBracketKey.BackColor = value;
                m_closeBracketKey.BackColor = value;
                m_pipeKey.BackColor = value;
                m_capsLockKey.BackColor = value;
                m_aKey.BackColor = value;
                m_sKey.BackColor = value;
                m_dKey.BackColor = value;
                m_fKey.BackColor = value;
                m_gKey.BackColor = value;
                m_hKey.BackColor = value;
                m_jKey.BackColor = value;
                m_kKey.BackColor = value;
                m_lKey.BackColor = value;
                m_semicolonKey.BackColor = value;
                m_quotesKey.BackColor = value;
                m_cedillaKey.BackColor = value;
                m_enterKey.BackColor = value;
                m_lShiftKey.BackColor = value;
                m_lessThanKey.BackColor = value;
                m_zKey.BackColor = value;
                m_xKey.BackColor = value;
                m_cKey.BackColor = value;
                m_vKey.BackColor = value;
                m_bKey.BackColor = value;
                m_nKey.BackColor = value;
                m_mKey.BackColor = value;
                m_commaKey.BackColor = value;
                m_periodKey.BackColor = value;
                m_questionKey.BackColor = value;
                m_rShiftKey.BackColor = value;
                m_spaceKey.BackColor = value;
                m_altGrKey.BackColor = value;
            }
        }

        /// <summary>
        /// Gets or sets the normal image for the letter and number keys.
        /// </summary>
        [Description("The normal image for the letter and number keys.")]
        [Category("Appearance")]
        [DefaultValue(typeof(Image), "null")]
        public Image KeyImageNormal
        {
            get
            {
                return m_tildeKey.ImageNormal;
            }
            set
            {
                m_tildeKey.ImageNormal = value;
                m_1Key.ImageNormal = value;
                m_2Key.ImageNormal = value;
                m_3Key.ImageNormal = value;
                m_4Key.ImageNormal = value;
                m_5Key.ImageNormal = value;
                m_6Key.ImageNormal = value;
                m_7Key.ImageNormal = value;
                m_8Key.ImageNormal = value;
                m_9Key.ImageNormal = value;
                m_0Key.ImageNormal = value;
                m_minusKey.ImageNormal = value;
                m_equalKey.ImageNormal = value;
                m_qKey.ImageNormal = value;
                m_wKey.ImageNormal = value;
                m_eKey.ImageNormal = value;
                m_rKey.ImageNormal = value;
                m_tKey.ImageNormal = value;
                m_yKey.ImageNormal = value;
                m_uKey.ImageNormal = value;
                m_iKey.ImageNormal = value;
                m_oKey.ImageNormal = value;
                m_pKey.ImageNormal = value;
                m_openBracketKey.ImageNormal = value;
                m_closeBracketKey.ImageNormal = value;
                m_aKey.ImageNormal = value;
                m_sKey.ImageNormal = value;
                m_dKey.ImageNormal = value;
                m_fKey.ImageNormal = value;
                m_gKey.ImageNormal = value;
                m_hKey.ImageNormal = value;
                m_jKey.ImageNormal = value;
                m_kKey.ImageNormal = value;
                m_lKey.ImageNormal = value;
                m_semicolonKey.ImageNormal = value;
                m_quotesKey.ImageNormal = value;
                m_cedillaKey.ImageNormal = value;
                m_lessThanKey.ImageNormal = value;
                m_zKey.ImageNormal = value;
                m_xKey.ImageNormal = value;
                m_cKey.ImageNormal = value;
                m_vKey.ImageNormal = value;
                m_bKey.ImageNormal = value;
                m_nKey.ImageNormal = value;
                m_mKey.ImageNormal = value;
                m_commaKey.ImageNormal = value;
                m_periodKey.ImageNormal = value;
                m_questionKey.ImageNormal = value;
            }
        }

        /// <summary>
        /// Gets or sets the pressed image for the letter and number keys.
        /// </summary>
        [Description("The pressed image for the letter and number keys.")]
        [Category("Appearance")]
        [DefaultValue(typeof(Image), "null")]
        public Image KeyImagePressed
        {
            get
            {
                return m_tildeKey.ImagePressed;
            }
            set
            {
                m_tildeKey.ImagePressed = value;
                m_1Key.ImagePressed = value;
                m_2Key.ImagePressed = value;
                m_3Key.ImagePressed = value;
                m_4Key.ImagePressed = value;
                m_5Key.ImagePressed = value;
                m_6Key.ImagePressed = value;
                m_7Key.ImagePressed = value;
                m_8Key.ImagePressed = value;
                m_9Key.ImagePressed = value;
                m_0Key.ImagePressed = value;
                m_minusKey.ImagePressed = value;
                m_equalKey.ImagePressed = value;
                m_qKey.ImagePressed = value;
                m_wKey.ImagePressed = value;
                m_eKey.ImagePressed = value;
                m_rKey.ImagePressed = value;
                m_tKey.ImagePressed = value;
                m_yKey.ImagePressed = value;
                m_uKey.ImagePressed = value;
                m_iKey.ImagePressed = value;
                m_oKey.ImagePressed = value;
                m_pKey.ImagePressed = value;
                m_openBracketKey.ImagePressed = value;
                m_closeBracketKey.ImagePressed = value;
                m_aKey.ImagePressed = value;
                m_sKey.ImagePressed = value;
                m_dKey.ImagePressed = value;
                m_fKey.ImagePressed = value;
                m_gKey.ImagePressed = value;
                m_hKey.ImagePressed = value;
                m_jKey.ImagePressed = value;
                m_kKey.ImagePressed = value;
                m_lKey.ImagePressed = value;
                m_semicolonKey.ImagePressed = value;
                m_quotesKey.ImagePressed = value;
                m_cedillaKey.ImagePressed = value;
                m_lessThanKey.ImagePressed = value;
                m_zKey.ImagePressed = value;
                m_xKey.ImagePressed = value;
                m_cKey.ImagePressed = value;
                m_vKey.ImagePressed = value;
                m_bKey.ImagePressed = value;
                m_nKey.ImagePressed = value;
                m_mKey.ImagePressed = value;
                m_commaKey.ImagePressed = value;
                m_periodKey.ImagePressed = value;
                m_questionKey.ImagePressed = value;
            }
        }

        /// <summary>
        /// Gets or sets whether to stretch the normal and pressed images to 
        /// the size of the letter/number keys.
        /// </summary>
        [Description("Stretch the normal and pressed images to the size of the letter/number keys.")]
        [Category("Appearance")]
        [DefaultValue(true)]
        public bool KeyStretch
        {
            get
            {
                return m_tildeKey.Stretch;
            }
            set
            {
                m_tildeKey.Stretch = value;
                m_1Key.Stretch = value;
                m_2Key.Stretch = value;
                m_3Key.Stretch = value;
                m_4Key.Stretch = value;
                m_5Key.Stretch = value;
                m_6Key.Stretch = value;
                m_7Key.Stretch = value;
                m_8Key.Stretch = value;
                m_9Key.Stretch = value;
                m_0Key.Stretch = value;
                m_minusKey.Stretch = value;
                m_equalKey.Stretch = value;
                m_qKey.Stretch = value;
                m_wKey.Stretch = value;
                m_eKey.Stretch = value;
                m_rKey.Stretch = value;
                m_tKey.Stretch = value;
                m_yKey.Stretch = value;
                m_uKey.Stretch = value;
                m_iKey.Stretch = value;
                m_oKey.Stretch = value;
                m_pKey.Stretch = value;
                m_openBracketKey.Stretch = value;
                m_closeBracketKey.Stretch = value;
                m_aKey.Stretch = value;
                m_sKey.Stretch = value;
                m_dKey.Stretch = value;
                m_fKey.Stretch = value;
                m_gKey.Stretch = value;
                m_hKey.Stretch = value;
                m_jKey.Stretch = value;
                m_kKey.Stretch = value;
                m_lKey.Stretch = value;
                m_semicolonKey.Stretch = value;
                m_quotesKey.Stretch = value;
                m_cedillaKey.Stretch = value;
                m_lessThanKey.Stretch = value;
                m_zKey.Stretch = value;
                m_xKey.Stretch = value;
                m_cKey.Stretch = value;
                m_vKey.Stretch = value;
                m_bKey.Stretch = value;
                m_nKey.Stretch = value;
                m_mKey.Stretch = value;
                m_commaKey.Stretch = value;
                m_periodKey.Stretch = value;
                m_questionKey.Stretch = value;
            }
        }

        /// <summary>
        /// Gets or sets the normal image for the backspace key.
        /// </summary>
        [Description("The normal image for the backspace key.")]
        [Category("Appearance")]
        [DefaultValue(typeof(Image), "null")]
        public Image BackspaceImageNormal
        {
            get
            {
                return m_backspaceKey.ImageNormal;
            }
            set
            {
                m_backspaceKey.ImageNormal = value;
            }
        }

        /// <summary>
        /// Gets or sets the pressed image for the backspace key.
        /// </summary>
        [Description("The pressed image for the backspace key.")]
        [Category("Appearance")]
        [DefaultValue(typeof(Image), "null")]
        public Image BackspaceImagePressed
        {
            get
            {
                return m_backspaceKey.ImagePressed;
            }
            set
            {
                m_backspaceKey.ImagePressed = value;
            }
        }

        /// <summary>
        /// Gets or sets whether to stretch the normal and pressed images to 
        /// the size of the backspace key.
        /// </summary>
        [Description("Stretch the normal and pressed images to the size of the backspace key.")]
        [Category("Appearance")]
        [DefaultValue(true)]
        public bool BackspaceStretch
        {
            get
            {
                return m_backspaceKey.Stretch;
            }
            set
            {
                m_backspaceKey.Stretch = value;
            }
        }

        /// <summary>
        /// Gets or sets the normal image for the tab and pipe key.
        /// </summary>
        [Description("The normal image for the tab and pipe key.")]
        [Category("Appearance")]
        [DefaultValue(typeof(Image), "null")]
        public Image TabPipeImageNormal
        {
            get
            {
                return m_tabKey.ImageNormal;
            }
            set
            {
                m_tabKey.ImageNormal = value;
                m_pipeKey.ImageNormal = value;
            }
        }

        /// <summary>
        /// Gets or sets the pressed image for the tab and pipe key.
        /// </summary>
        [Description("The pressed image for the tab and pipe key.")]
        [Category("Appearance")]
        [DefaultValue(typeof(Image), "null")]
        public Image TabPipeImagePressed
        {
            get
            {
                return m_tabKey.ImagePressed;
            }
            set
            {
                m_tabKey.ImagePressed = value;
                m_pipeKey.ImagePressed = value;
            }
        }

        /// <summary>
        /// Gets or sets whether to stretch the normal and pressed images to 
        /// the size of the tab and pipe key.
        /// </summary>
        [Description("Stretch the normal and pressed images to the size of the tab and pipe key.")]
        [Category("Appearance")]
        [DefaultValue(true)]
        public bool TabPipeStretch
        {
            get
            {
                return m_tabKey.Stretch;
            }
            set
            {
                m_tabKey.Stretch = value;
                m_pipeKey.Stretch = value;
            }
        }

        /// <summary>
        /// Gets or sets the normal image for the caps lock key.
        /// </summary>
        [Description("The normal image for the caps lock key.")]
        [Category("Appearance")]
        [DefaultValue(typeof(Image), "null")]
        public Image CapsLockImageNormal
        {
            get
            {
                return m_capsLockKey.ImageNormal;
            }
            set
            {
                m_capsLockKey.ImageNormal = value;
                m_capsLockImageNormal = value;
            }
        }

        /// <summary>
        /// Gets or sets the pressed image for the caps lock key.
        /// </summary>
        [Description("The pressed image for the caps lock key.")]
        [Category("Appearance")]
        [DefaultValue(typeof(Image), "null")]
        public Image CapsLockImagePressed
        {
            get
            {
                return m_capsLockKey.ImagePressed;
            }
            set
            {
                m_capsLockKey.ImagePressed = value;
            }
        }

        /// <summary>
        /// Gets or sets whether to stretch the normal and pressed images to 
        /// the size of the caps lock key.
        /// </summary>
        [Description("Stretch the normal and pressed images to the size of the caps lock key.")]
        [Category("Appearance")]
        [DefaultValue(true)]
        public bool CapsLockStretch
        {
            get
            {
                return m_capsLockKey.Stretch;
            }
            set
            {
                m_capsLockKey.Stretch = value;
            }
        }

        /// <summary>
        /// Gets or sets the normal image for the enter key.
        /// </summary>
        [Description("The normal image for the enter key.")]
        [Category("Appearance")]
        [DefaultValue(typeof(Image), "null")]
        public Image EnterImageNormal
        {
            get
            {
                return m_enterKey.ImageNormal;
            }
            set
            {
                m_enterKey.ImageNormal = value;
            }
        }

        /// <summary>
        /// Gets or sets the pressed image for the enter key.
        /// </summary>
        [Description("The pressed image for the enter key.")]
        [Category("Appearance")]
        [DefaultValue(typeof(Image), "null")]
        public Image EnterImagePressed
        {
            get
            {
                return m_enterKey.ImagePressed;
            }
            set
            {
                m_enterKey.ImagePressed = value;
            }
        }

        /// <summary>
        /// Gets or sets whether to stretch the normal and pressed images to 
        /// the size of the enter key.
        /// </summary>
        [Description("Stretch the normal and pressed images to the size of the enter key.")]
        [Category("Appearance")]
        [DefaultValue(true)]
        public bool EnterStretch
        {
            get
            {
                return m_enterKey.Stretch;
            }
            set
            {
                m_enterKey.Stretch = value;
            }
        }

        /// <summary>
        /// Gets or sets the normal image for the shift keys.
        /// </summary>
        [Description("The normal image for the shift keys.")]
        [Category("Appearance")]
        [DefaultValue(typeof(Image), "null")]
        public Image ShiftImageNormal
        {
            get
            {
                return m_lShiftKey.ImageNormal;
            }
            set
            {
                m_lShiftKey.ImageNormal = value;
                m_rShiftKey.ImageNormal = value;
                m_shiftImageNormal = value;
            }
        }

        /// <summary>
        /// Gets or sets the pressed image for the shift keys.
        /// </summary>
        [Description("The pressed image for the shift keys.")]
        [Category("Appearance")]
        [DefaultValue(typeof(Image), "null")]
        public Image ShiftImagePressed
        {
            get
            {
                return m_lShiftKey.ImagePressed;
            }
            set
            {
                m_lShiftKey.ImagePressed = value;
                m_rShiftKey.ImagePressed = value;
            }
        }

        /// <summary>
        /// Gets or sets whether to stretch the normal and pressed images to 
        /// the size of the shift keys.
        /// </summary>
        [Description("Stretch the normal and pressed images to the size of the shift keys.")]
        [Category("Appearance")]
        [DefaultValue(true)]
        public bool ShiftStretch
        {
            get
            {
                return m_lShiftKey.Stretch;
            }
            set
            {
                m_lShiftKey.Stretch = value;
                m_rShiftKey.Stretch = value;
            }
        }

        /// <summary>
        /// Gets or sets the icon image for the shift keys.
        /// </summary>
        [Description("The icon image for the shift keys.")]
        [Category("Appearance")]
        [DefaultValue(typeof(Image), "null")]
        public Image ShiftImageIcon
        {
            get
            {
                return m_lShiftKey.ImageIcon;
            }
            set
            {
                m_lShiftKey.ImageIcon = value;
                m_rShiftKey.ImageIcon = value;
            }
        }

        /// <summary>
        /// Gets or sets the normal image for the space key.
        /// </summary>
        [Description("The normal image for the space key.")]
        [Category("Appearance")]
        [DefaultValue(typeof(Image), "null")]
        public Image SpaceImageNormal
        {
            get
            {
                return m_spaceKey.ImageNormal;
            }
            set
            {
                m_spaceKey.ImageNormal = value;
            }
        }

        /// <summary>
        /// Gets or sets the pressed image for the space key.
        /// </summary>
        [Description("The pressed image for the space key.")]
        [Category("Appearance")]
        [DefaultValue(typeof(Image), "null")]
        public Image SpaceImagePressed
        {
            get
            {
                return m_spaceKey.ImagePressed;
            }
            set
            {
                m_spaceKey.ImagePressed = value;
            }
        }

        /// <summary>
        /// Gets or sets whether to stretch the normal and pressed images to 
        /// the size of the space key.
        /// </summary>
        [Description("Stretch the normal and pressed images to the size of the space key.")]
        [Category("Appearance")]
        [DefaultValue(true)]
        public bool SpaceStretch
        {
            get
            {
                return m_spaceKey.Stretch;
            }
            set
            {
                m_spaceKey.Stretch = value;
            }
        }

        /// <summary>
        /// Gets or sets the normal image for the alt gr key.
        /// </summary>
        [Description("The normal image for the alt gr key.")]
        [Category("Appearance")]
        [DefaultValue(typeof(Image), "null")]
        public Image AltGrImageNormal
        {
            get
            {
                return m_altGrKey.ImageNormal;
            }
            set
            {
                m_altGrKey.ImageNormal = value;
                m_altGrImageNormal = value;
            }
        }

        /// <summary>
        /// Gets or sets the pressed image for the alt gr key.
        /// </summary>
        [Description("The pressed image for the alt gr key.")]
        [Category("Appearance")]
        [DefaultValue(typeof(Image), "null")]
        public Image AltGrImagePressed
        {
            get
            {
                return m_altGrKey.ImagePressed;
            }
            set
            {
                m_altGrKey.ImagePressed = value;
            }
        }

        /// <summary>
        /// Gets or sets whether to stretch the normal and pressed images to 
        /// the size of the alt gr key.
        /// </summary>
        [Description("Stretch the normal and pressed images to the size of the alt gr key.")]
        [Category("Appearance")]
        [DefaultValue(true)]
        public bool AltGrStretch
        {
            get
            {
                return m_altGrKey.Stretch;
            }
            set
            {
                m_altGrKey.Stretch = value;
            }
        }

        /// <summary>
        /// Gets or sets whether to show the buttons' focus rectangle.
        /// </summary>
        [Description("Whether to show the buttons' focus rectangle.")]
        [Category("Appearance")]
        [DefaultValue(true)]
        public bool ShowFocus
        {
            get
            {
                return m_tildeKey.ShowFocus;
            }
            set
            {
                m_tildeKey.ShowFocus = value;
                m_1Key.ShowFocus = value;
                m_2Key.ShowFocus = value;
                m_3Key.ShowFocus = value;
                m_4Key.ShowFocus = value;
                m_5Key.ShowFocus = value;
                m_6Key.ShowFocus = value;
                m_7Key.ShowFocus = value;
                m_8Key.ShowFocus = value;
                m_9Key.ShowFocus = value;
                m_0Key.ShowFocus = value;
                m_minusKey.ShowFocus = value;
                m_equalKey.ShowFocus = value;
                m_backspaceKey.ShowFocus = value;
                m_tabKey.ShowFocus = value;
                m_qKey.ShowFocus = value;
                m_wKey.ShowFocus = value;
                m_eKey.ShowFocus = value;
                m_rKey.ShowFocus = value;
                m_tKey.ShowFocus = value;
                m_yKey.ShowFocus = value;
                m_uKey.ShowFocus = value;
                m_iKey.ShowFocus = value;
                m_oKey.ShowFocus = value;
                m_pKey.ShowFocus = value;
                m_openBracketKey.ShowFocus = value;
                m_closeBracketKey.ShowFocus = value;
                m_pipeKey.ShowFocus = value;
                m_capsLockKey.ShowFocus = value;
                m_aKey.ShowFocus = value;
                m_sKey.ShowFocus = value;
                m_dKey.ShowFocus = value;
                m_fKey.ShowFocus = value;
                m_gKey.ShowFocus = value;
                m_hKey.ShowFocus = value;
                m_jKey.ShowFocus = value;
                m_kKey.ShowFocus = value;
                m_lKey.ShowFocus = value;
                m_semicolonKey.ShowFocus = value;
                m_quotesKey.ShowFocus = value;
                m_cedillaKey.ShowFocus = value;
                m_enterKey.ShowFocus = value;
                m_lShiftKey.ShowFocus = value;
                m_lessThanKey.ShowFocus = value;
                m_zKey.ShowFocus = value;
                m_xKey.ShowFocus = value;
                m_cKey.ShowFocus = value;
                m_vKey.ShowFocus = value;
                m_bKey.ShowFocus = value;
                m_nKey.ShowFocus = value;
                m_mKey.ShowFocus = value;
                m_commaKey.ShowFocus = value;
                m_periodKey.ShowFocus = value;
                m_questionKey.ShowFocus = value;
                m_rShiftKey.ShowFocus = value;
                m_spaceKey.ShowFocus = value;
                m_altGrKey.ShowFocus = value;
            }
        }

        /// <summary>
        /// Gets or sets whether to play a sound when the keys are clicked.
        /// </summary>
        [Description("Whether to play a sound when the keys are clicked.")]
        [Category("Behavior")]
        [DefaultValue(false)]
        public bool UseClickSound
        {
            get
            {
                return m_tildeKey.UseClickSound;
            }
            set
            {
                m_tildeKey.UseClickSound = value;
                m_1Key.UseClickSound = value;
                m_2Key.UseClickSound = value;
                m_3Key.UseClickSound = value;
                m_4Key.UseClickSound = value;
                m_5Key.UseClickSound = value;
                m_6Key.UseClickSound = value;
                m_7Key.UseClickSound = value;
                m_8Key.UseClickSound = value;
                m_9Key.UseClickSound = value;
                m_0Key.UseClickSound = value;
                m_minusKey.UseClickSound = value;
                m_equalKey.UseClickSound = value;
                m_backspaceKey.UseClickSound = value;
                m_tabKey.UseClickSound = value;
                m_qKey.UseClickSound = value;
                m_wKey.UseClickSound = value;
                m_eKey.UseClickSound = value;
                m_rKey.UseClickSound = value;
                m_tKey.UseClickSound = value;
                m_yKey.UseClickSound = value;
                m_uKey.UseClickSound = value;
                m_iKey.UseClickSound = value;
                m_oKey.UseClickSound = value;
                m_pKey.UseClickSound = value;
                m_openBracketKey.UseClickSound = value;
                m_closeBracketKey.UseClickSound = value;
                m_pipeKey.UseClickSound = value;
                m_capsLockKey.UseClickSound = value;
                m_aKey.UseClickSound = value;
                m_sKey.UseClickSound = value;
                m_dKey.UseClickSound = value;
                m_fKey.UseClickSound = value;
                m_gKey.UseClickSound = value;
                m_hKey.UseClickSound = value;
                m_jKey.UseClickSound = value;
                m_kKey.UseClickSound = value;
                m_lKey.UseClickSound = value;
                m_semicolonKey.UseClickSound = value;
                m_quotesKey.UseClickSound = value;
                m_cedillaKey.UseClickSound = value;
                m_enterKey.UseClickSound = value;
                m_lShiftKey.UseClickSound = value;
                m_lessThanKey.UseClickSound = value;
                m_zKey.UseClickSound = value;
                m_xKey.UseClickSound = value;
                m_cKey.UseClickSound = value;
                m_vKey.UseClickSound = value;
                m_bKey.UseClickSound = value;
                m_nKey.UseClickSound = value;
                m_mKey.UseClickSound = value;
                m_commaKey.UseClickSound = value;
                m_periodKey.UseClickSound = value;
                m_questionKey.UseClickSound = value;
                m_rShiftKey.UseClickSound = value;
                m_spaceKey.UseClickSound = value;
                m_altGrKey.UseClickSound = value;
            }
        }

        /// <summary>
        /// Sets the data stream of the .wav file to play when keys 
        /// are clicked.
        /// </summary>
        [Description("The data stream of the .wav file to play when keys are clicked.")]
        [Browsable(false)]
        public Stream ClickSound
        {
            set
            {
                m_tildeKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_1Key.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_2Key.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_3Key.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_4Key.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_5Key.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_6Key.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_7Key.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_8Key.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_9Key.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_0Key.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_minusKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_equalKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_backspaceKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_tabKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_qKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_wKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_eKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_rKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_tKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_yKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_uKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_iKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_oKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_pKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_openBracketKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_closeBracketKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_pipeKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_capsLockKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_aKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_sKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_dKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_fKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_gKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_hKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_jKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_kKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_lKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_semicolonKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_quotesKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_cedillaKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_enterKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_lShiftKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_lessThanKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_zKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_xKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_cKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_vKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_bKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_nKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_mKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_commaKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_periodKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_questionKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_rShiftKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_spaceKey.ClickSound = value;
                value.Seek(0, SeekOrigin.Begin);
                m_altGrKey.ClickSound = value;
            }
        }
        #endregion
    }

    /// <summary>
    /// Represents the method that will handle a keyboard event.
    /// </summary>
    /// <param name="sender">The source of the event.</param>
    /// <param name="e">A KeyboardEventArgs object that 
    /// contains the event data.</param>
    public delegate void KeyboardEventHandler(object sender, KeyboardEventArgs e);

    /// <summary>
    /// Contains data about a keyboard event.
    /// </summary>
    public class KeyboardEventArgs : EventArgs
    {
        #region Member Variables
        protected readonly string m_keyPressed;
        #endregion

        #region Constructors
        /// <summary>
        /// Initializes a new instance of the KeyboardEventArgs class.
        /// </summary>
        /// <param name="keyPressed">A string representing the 
        /// key(s) pressed.</param>
        public KeyboardEventArgs(string keyPressed)
        {
            m_keyPressed = keyPressed;
        }
        #endregion

        #region Member Properties
        /// <summary>
        /// Gets a string representing the key(s) pressed.
        /// </summary>
        public string KeyPressed
        {
            get
            {
                return m_keyPressed;
            }
        }
        #endregion
    }

    /// <summary>
    /// Customizes the design mode behavior of the VirtualKeyboard.
    /// </summary>
    [System.Security.Permissions.PermissionSet(System.Security.Permissions.SecurityAction.Demand, Name = "FullTrust")]
    public class VirtualKeyboardDesigner : ControlDesigner
    {
        #region Member Methods
        /// <summary>
        /// This method provides a way to change items in the dictionary 
        /// of properties that a designer exposes through a TypeDescriptor.
        /// </summary>
        /// <param name="properties">The PropertyDescriptor objects that 
        /// represent the properties of the class of the component. The keys 
        /// in the dictionary of properties are property names.</param>
        protected override void PreFilterProperties(IDictionary properties)
        {
            base.PreFilterProperties(properties);

            properties.Remove("AllowDrop");
            properties.Remove("AutoSize");
            properties.Remove("AutoSizeMode");
            properties.Remove("Padding");
        }

        /// <summary>
        /// This method provides a way to change items in the dictionary of 
        /// events that a designer exposes through a TypeDescriptor.
        /// </summary>
        /// <param name="events">The EventDescriptor objects that represent 
        /// the events of the class of the component. The keys in the 
        /// dictionary of events are event names.</param>
        protected override void PreFilterEvents(IDictionary events)
        {
            base.PreFilterEvents(events);

            events.Remove("PaddingChangd");
            events.Remove("AutoSizeChanged");
        }
        #endregion
    }
}
