#region Copyright
// This is an unpublished work protected under the copyright laws of the
// United States and other countries.  All rights reserved.  Should
// publication occur the following will apply:  © 2008 GameTech
// International, Inc.
#endregion

using System;
using System.IO;
using System.Media;
using System.Drawing;
using System.Drawing.Imaging;
using System.Collections;
using System.Windows.Forms;
using System.Windows.Forms.Design;
using System.ComponentModel;
using System.ComponentModel.Design;


namespace GameTech.B3Reports.Forms
{
    /// <summary>
    /// A button that allows the displaying of pictures instead of Windows
    /// drawn graphics.
    /// </summary>
    [Description("GameTech Image Button")]
    [DesignerAttribute(typeof(ImageButtonDesigner))]
    public class ImageButton : Button
    {
        #region Constants and Data Types
        protected readonly Size MinSize = new Size(30, 30);
        protected const int FocusPadding = 5; // Pixels
        #endregion

        #region Member Variables
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.Container components = null;

        protected Image m_currentImage = null;
        protected Image m_normalImage = null;
        protected Image m_pressedImage = null;
        protected Image m_disabledImage = null;
        protected Image m_imageIcon = null;
        protected ImageAttributes m_transparentAttrs = null;
        protected ImageAttributes m_grayScaleAttrs = null;
        protected bool m_pressed = false;
        protected Point m_lastMousePos;
        protected bool m_useClickSound = false;
        protected SoundPlayer m_clickSound = null;
        protected bool m_stretch = true;
        protected StringAlignment m_alignment = StringAlignment.Center;
        protected StringAlignment m_lineAlignment = StringAlignment.Center;
        protected bool m_showFocus = true;
        protected Color m_focusColor = Color.Black;
        #endregion

        #region Constructors
        /// <summary>
        /// Initializes a new instance of the ImageButton class.
        /// </summary>
        public ImageButton()
            : this(null, null, null)
        {
        }

        /// <summary>
        /// Initializes a new instance of the ImageButton class with the 
        /// specified image. By default, the button will be the size of 
        /// the image.
        /// </summary>
        /// <param name="normalImage">The image to display on the
        /// button.</param>
        public ImageButton(Image normalImage)
            : this(normalImage, null, null)
        {
        }

        /// <summary>
        /// Initializes a new instance of the ImageButton class with the 
        /// specified images. By default, the button will be the size of 
        /// the normal image.
        /// </summary>
        /// <param name="normalImage">The image to display on the 
        /// button.</param>
        /// <param name="pressedImage">The image to display on the 
        /// button while it's being pressed.</param>
        public ImageButton(Image normalImage, Image pressedImage)
            : this(normalImage, pressedImage, null)
        {
        }

        /// <summary>
        /// Initializes a new instance of the ImageButton class with the 
        /// specified images. By default, the button will be the size of 
        /// the normal image.
        /// </summary>
        /// <param name="normalImage">The image to display on the 
        /// button.</param>
        /// <param name="pressedImage">The image to display on the 
        /// button while it's being pressed.</param>
        /// <param name="disabledImage">The image to display on the 
        /// button while it's disabled.</param>
        public ImageButton(Image normalImage, Image pressedImage, Image disabledImage)
        {
            InitializeComponent();

            DoubleBuffered = true;
            AutoSize = false;
            MinimumSize = MinSize;

            if (normalImage != null)
            {
                m_normalImage = normalImage;

                // By default, the button takes the size of the image.
                Size = m_normalImage.Size;
            }

            if (pressedImage != null)
                m_pressedImage = pressedImage;

            if (disabledImage != null)
                m_disabledImage = disabledImage;

            // If no disabledImage is passed in we'll make the normal, grayscale.               
            ColorMatrix grayScaleMatrix = new ColorMatrix();
            grayScaleMatrix.Matrix00 = 1 / 3f;
            grayScaleMatrix.Matrix01 = 1 / 3f;
            grayScaleMatrix.Matrix02 = 1 / 3f;
            grayScaleMatrix.Matrix10 = 1 / 3f;
            grayScaleMatrix.Matrix11 = 1 / 3f;
            grayScaleMatrix.Matrix12 = 1 / 3f;
            grayScaleMatrix.Matrix20 = 1 / 3f;
            grayScaleMatrix.Matrix21 = 1 / 3f;
            grayScaleMatrix.Matrix22 = 1 / 3f;

            m_grayScaleAttrs = new ImageAttributes();
            m_grayScaleAttrs.SetColorMatrix(grayScaleMatrix);

            // If the button is disabled we'll make the icon (if there is one),
            // 75% transparent.
            ColorMatrix transparentMatrix = new ColorMatrix
                (
                    new float[][]
                    {
                        new float[] {1, 0, 0, 0, 0},
                        new float[] {0, 1, 0, 0, 0},
                        new float[] {0, 0, 1, 0, 0},
                        new float[] {0, 0, 0, 0.25f, 0},
                        new float[] {0, 0, 0, 0, 1}
                    }
                );

            m_transparentAttrs = new ImageAttributes();
            m_transparentAttrs.SetColorMatrix(transparentMatrix);

            if (m_useClickSound)
            {
                // Load the click sound player.
                m_clickSound = new SoundPlayer();
            }

            // Create the button's image.
            RenderButton();
        }
        #endregion

        #region Member Methods
        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            components = new System.ComponentModel.Container();
        }

        /// <summary>
        /// Creates the button's graphics that will be needed for the paint 
        /// message.
        /// </summary>
        protected void RenderButton()
        {
            // Reset the rendered image.
            if (m_currentImage != null)
            {
                m_currentImage.Dispose();
                m_currentImage = null;
            }

            // Holds the source image that we will extract sections out of.
            Image srcImage;

            // Which image we are actually going to draw?
            if (Enabled) // Control is enabled.
            {
                if (m_pressed && m_pressedImage != null && ClientRectangle.Contains(m_lastMousePos))
                    srcImage = m_pressedImage;
                else
                    srcImage = m_normalImage;
            }
            else // Control is disabled.
            {
                if (m_disabledImage != null)
                    srcImage = m_disabledImage;
                else
                    srcImage = m_normalImage;
            }

            if (srcImage != null)
            {
                Rectangle destRect = new Rectangle(), srcRect = new Rectangle();
                m_currentImage = new Bitmap(Width, Height);
                Graphics g = Graphics.FromImage(m_currentImage);

                if (m_stretch)
                {
                    Image stretchedImg = ImageHelper.ResizeImage(srcImage.Width / 3, Color.Transparent, srcImage, Size);

                    if (stretchedImg == null)
                    {
                        // We failed to resize the image.
                        m_currentImage.Dispose();
                        m_currentImage = null;
                        return;
                    }

                    // Draw image to our bitmap.
                    destRect = new Rectangle(0, 0, Width, Height);

                    if (m_disabledImage == null && !Enabled)
                    {
                        // Draw the grayscaled version of the image.
                        g.DrawImage(stretchedImg, destRect, 0, 0, stretchedImg.Width, stretchedImg.Height, GraphicsUnit.Pixel, m_grayScaleAttrs);
                    }
                    else
                    {
                        // Draw the actual image they want to use for the button.
                        g.DrawImage(stretchedImg, destRect, 0, 0, stretchedImg.Width, stretchedImg.Height, GraphicsUnit.Pixel);
                    }

                    stretchedImg.Dispose();
                    stretchedImg = null;
                }
                else
                {
                    // PDTS 964 - UK Bingo Support
                    // Draw the image centered and resize if not the same as 
                    // the button.
                    // Initialize the default upper left corner.
                    destRect.Y = 0;
                    destRect.X = 0;
                    destRect.Width = Width;
                    destRect.Height = Height;
                    srcRect.X = 0;
                    srcRect.Y = 0;
                    srcRect.Width = srcImage.Width;
                    srcRect.Height = srcImage.Height;

                    // Find out if we need to center the image horizontally.
                    if (Width > srcImage.Width)
                        destRect.X = (Width - srcImage.Width) / 2;

                    // Find out if we need to center the image vertically.
                    if (Height > srcImage.Height)
                        destRect.Y = (Height - srcImage.Height) / 2;

                    if (m_disabledImage == null && !Enabled)
                    {
                        // Draw the grayscaled version of the image.
                        g.DrawImage(srcImage, destRect, srcRect.X, srcRect.Y, srcRect.Width, srcRect.Height, GraphicsUnit.Pixel, m_grayScaleAttrs);
                    }
                    else
                    {
                        g.DrawImage(srcImage, destRect, srcRect, GraphicsUnit.Pixel);
                    }
                }

                // Check to see if we need to draw the icon image on the button.
                if (m_imageIcon != null)
                {
                    // Initialize the default upper left corner.
                    destRect.Y = 0;
                    destRect.X = 0;
                    srcRect.X = 0;
                    srcRect.Y = 0;
                    srcRect.Width = m_imageIcon.Width;
                    srcRect.Height = m_imageIcon.Height;

                    // Find out if we need to center the icon horizontally.
                    if (Width > m_imageIcon.Width)
                        destRect.X = (Width - m_imageIcon.Width) / 2;

                    // Find out if we need to center the icon vertically.
                    if (Height > m_imageIcon.Height)
                        destRect.Y = (Height - m_imageIcon.Height) / 2;

                    // Use the same rectangle as the user control to clip the 
                    // icon image if the button is too small.
                    destRect.Width = srcRect.Width;
                    destRect.Height = srcRect.Height;

                    if (Enabled)
                        g.DrawImage(m_imageIcon, destRect, srcRect, GraphicsUnit.Pixel);
                    else // If the control is disabled make the icon semi-transparent.
                        g.DrawImage(m_imageIcon, destRect, srcRect.X, srcRect.Y, srcRect.Width, srcRect.Height, GraphicsUnit.Pixel, m_transparentAttrs);
                }

                // Dispose of the graphics object.
                g.Dispose();
                g = null;
            }
        }

        /// <summary>
        /// Raises the SizeChanged event and re-renders the control.
        /// </summary>
        /// <param name="e">A EventArgs object that contains 
        /// the event data.</param>
        protected override void OnSizeChanged(EventArgs e)
        {
            base.OnSizeChanged(e);
            RenderButton();
        }

        /// <summary>
        /// Handles the drawing of the button.
        /// </summary>
        /// <param name="pevent">A PaintEventArgs object that contains 
        /// the event data.</param>
        protected override void OnPaint(PaintEventArgs pevent)
        {
            if (m_currentImage != null)
            {
                base.OnPaintBackground(pevent);

                pevent.Graphics.DrawImage(m_currentImage, pevent.ClipRectangle, pevent.ClipRectangle, GraphicsUnit.Pixel);

                // Draw the button's text.
                if (Text.Length > 0)
                {
                    // Set the string drawing properties.
                    StringFormat format = new StringFormat();
                    format.Alignment = m_alignment;
                    format.LineAlignment = m_lineAlignment;
                    format.Trimming = StringTrimming.EllipsisCharacter;

                    if (UseMnemonic)
                        format.HotkeyPrefix = System.Drawing.Text.HotkeyPrefix.Show;

                    // Create the drawing rect. and adjust it based on padding.
                    Rectangle textRect = ClientRectangle;
                    textRect.X += Padding.Left;
                    textRect.Width -= Padding.Right;
                    textRect.Y += Padding.Top;
                    textRect.Height -= Padding.Bottom;

                    if (!Enabled)
                    {
                        // Draw a while outline if it's disabled.
                        Rectangle shadowRect = textRect;
                        shadowRect.X += 1;
                        shadowRect.Y += 1;

                        pevent.Graphics.DrawString(Text, Font, new SolidBrush(Color.White), shadowRect, format);
                    }

                    pevent.Graphics.DrawString(Text, Font, new SolidBrush(Enabled ? ForeColor : Color.Gray), textRect, format);
                }

                // Optionally, draw the button's focus rectangle.
                if (Focused && m_showFocus && !m_pressed)
                {
                    Rectangle destRect = new Rectangle(FocusPadding, FocusPadding, Size.Width - (FocusPadding * 2) - 1, Size.Height - (FocusPadding * 2) - 1);

                    Pen highlightPen = new Pen(m_focusColor, 1.0f);
                    highlightPen.DashStyle = System.Drawing.Drawing2D.DashStyle.Dot;
                    pevent.Graphics.DrawRectangle(highlightPen, destRect);
                }
            }
            else
                base.OnPaint(pevent);
        }

        /// <summary>
        /// Handles the mouse button down event.
        /// </summary>
        /// <param name="mevent">A MouseEventArgs object that contains 
        /// the event data.</param>
        protected override void OnMouseDown(MouseEventArgs mevent)
        {
            if (mevent.Button == MouseButtons.Left)
            {
                m_pressed = true;
                m_lastMousePos = new Point(mevent.X, mevent.Y);
                RenderButton();
                Invalidate();
            }

            base.OnMouseDown(mevent);

            if (m_useClickSound)
                m_clickSound.Play();
        }

        /// <summary>
        /// Handles the mouse button up event.
        /// </summary>
        /// <param name="mevent">A MouseEventArgs object that contains 
        /// the event data.</param>
        protected override void OnMouseUp(MouseEventArgs mevent)
        {
            if (mevent.Button == MouseButtons.Left)
            {
                m_pressed = false;
                RenderButton();
                Invalidate();
            }

            base.OnMouseUp(mevent);
        }

        /// <summary>
        /// Handles the mouse move event.
        /// </summary>
        /// <param name="mevent">A MouseEventArgs object that contains 
        /// the event data.</param>
        protected override void OnMouseMove(MouseEventArgs mevent)
        {
            if (m_pressed && mevent.Button == MouseButtons.Left)
                m_lastMousePos = new Point(mevent.X, mevent.Y);

            base.OnMouseMove(mevent);
        }

        /// <summary>
        /// Handles the key down event.
        /// </summary>
        /// <param name="kevent">A KeyEventArgs object that contains 
        /// the event data.</param>
        protected override void OnKeyDown(KeyEventArgs kevent)
        {
            if (kevent.KeyCode == Keys.Space)
            {
                m_pressed = true;
                RenderButton();
                Invalidate();

                if (m_useClickSound)
                    m_clickSound.Play();
            }

            base.OnKeyDown(kevent);
        }

        /// <summary>
        /// Handles the Enabled Changed event.
        /// </summary>
        /// <param name="kevent">A EventArgs object that contains 
        /// the event data.</param>
        protected override void OnEnabledChanged(EventArgs e)
        {
            // Release the button
            m_pressed = false;
            RenderButton();
            Invalidate();

            base.OnEnabledChanged(e);
        }

        /// <summary>
        /// Handles the key up event.
        /// </summary>
        /// <param name="kevent">A KeyEventArgs object that contains 
        /// the event data.</param>
        protected override void OnKeyUp(KeyEventArgs kevent)
        {
            if (kevent.KeyCode == Keys.Space)
            {
                m_pressed = false;
                RenderButton();
                Invalidate();
            }

            base.OnKeyUp(kevent);
        }

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be 
        /// disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }

            base.Dispose(disposing);
        }
        #endregion

        #region Member Properties
        /// <summary>
        /// Gets or sets whether to show the focus rectangle when the button 
        /// has focus.
        /// </summary>
        [Description("Show the focus rectangle when the button has focus.")]
        [Category("Appearance")]
        [DefaultValue(true)]
        public bool ShowFocus
        {
            get
            {
                return m_showFocus;
            }
            set
            {
                m_showFocus = value;
                Invalidate();
            }
        }

        /// <summary>
        /// Gets or sets the color of the focus rectangle.
        /// </summary>
        [Description("The color of the focus rectangle.")]
        [Category("Appearance")]
        public Color FocusColor
        {
            get
            {
                return m_focusColor;
            }
            set
            {
                m_focusColor = value;
                Invalidate();
            }
        }

        /// <summary>
        /// Gets or sets whether to stretch the Normal and Pressed images to 
        /// the size of the control.
        /// </summary>
        [Description("Stretch the Normal and Pressed images to the size of the control.")]
        [Category("Appearance")]
        [DefaultValue(true)]
        public bool Stretch
        {
            get
            {
                return m_stretch;
            }
            set
            {
                m_stretch = value;
                RenderButton();
                Invalidate();
            }
        }

        /// <summary>
        /// Gets or sets the image to use when drawing the button.
        /// </summary>
        [Description("The default image to use when drawing the button.")]
        [Category("Appearance")]
        [DefaultValue(typeof(Image), "null")]
        public Image ImageNormal
        {
            get
            {
                return m_normalImage;
            }
            set
            {
                m_normalImage = value;
                RenderButton();
                Invalidate();
            }
        }

        /// <summary>
        /// Gets or sets the icon image to use when drawing the button. 
        /// This image will be centered, and clipping will occur if button is
        /// too small.
        /// </summary>
        [Description("The icon image to use when drawing the button. This image will be centered, and clipping will occur if button is too small.")]
        [Category("Appearance")]
        [DefaultValue(typeof(Image), "null")]
        public Image ImageIcon
        {
            get
            {
                return m_imageIcon;
            }
            set
            {
                m_imageIcon = value;
                RenderButton();
                Invalidate();
            }
        }

        /// <summary>
        /// Gets or sets the image to use when drawing the button 
        /// while pressed.
        /// </summary>
        [Description("The image to use when drawing the button while pressed.")]
        [Category("Appearance")]
        [DefaultValue(typeof(Image), "null")]
        public Image ImagePressed
        {
            get
            {
                return m_pressedImage;
            }
            set
            {
                m_pressedImage = value;
                RenderButton();
                Invalidate();
            }
        }

        /// <summary>
        /// Gets or sets the image to use when drawing the button 
        /// while disabled.
        /// </summary>
        [Description("The image to use when drawing the button while disabled.")]
        [Category("Appearance")]
        [DefaultValue(typeof(Image), "null")]
        public Image ImageDisabled
        {
            get
            {
                return m_disabledImage;
            }
            set
            {
                m_disabledImage = value;
                RenderButton();
                Invalidate();
            }
        }


        /// <summary>
        /// Gets or sets the alignment of the button's text on the vertical 
        /// plane.
        /// </summary>
        [Description("The alignment of the button's text on the vertical plane.")]
        [Category("Appearance")]
        [DefaultValue(StringAlignment.Center)]
        public StringAlignment Alignment
        {
            get
            {
                return m_alignment;
            }
            set
            {
                m_alignment = value;
                Invalidate();
            }
        }

        /// <summary>
        /// Gets or sets the alignment of the button's text on the horizontal 
        /// plane.
        /// </summary>
        [Description("The alignment of the button's text on the horizontal plane.")]
        [Category("Appearance")]
        [DefaultValue(StringAlignment.Center)]
        public StringAlignment LineAlignment
        {
            get
            {
                return m_lineAlignment;
            }
            set
            {
                m_lineAlignment = value;
                Invalidate();
            }
        }

        /// <summary>
        /// Gets or sets whether to play a sound when the button is clicked.
        /// </summary>
        [Description("Whether to play a sound when the button is clicked.")]
        [Category("Behavior")]
        [DefaultValue(false)]
        public bool UseClickSound
        {
            get
            {
                return m_useClickSound;
            }
            set
            {
                m_useClickSound = value;

                if (m_useClickSound && m_clickSound == null)
                    m_clickSound = new SoundPlayer();
            }
        }

        /// <summary>
        /// Sets the data stream of the .wav file to play when the button 
        /// is clicked.
        /// </summary>
        /// <remarks>If UseClickSound is not true, then this property does 
        /// nothing.</remarks>
        [Description("The data stream of the .wav file to play when the button is clicked.")]
        [Browsable(false)]
        public Stream ClickSound
        {
            set
            {
                if (m_useClickSound)
                {
                    m_clickSound.Stream = value;
                    m_clickSound.Load();
                }
            }
        }
        #endregion
    }

    /// <summary>
    /// Customizes the design mode behavior of the ImageButton.
    /// </summary>
    [System.Security.Permissions.PermissionSet(System.Security.Permissions.SecurityAction.Demand, Name = "FullTrust")]
    public class ImageButtonDesigner : ControlDesigner
    {
        #region Member Methods
        /// <summary>
        /// This method provides a way to change items in the dictionary of 
        /// properties that a designer exposes through a TypeDescriptor.
        /// </summary>
        /// <param name="properties">The PropertyDescriptor objects that 
        /// represent the properties of the class of the component. The keys 
        /// in the dictionary of properties are property names.</param>
        protected override void PreFilterProperties(IDictionary properties)
        {
            base.PreFilterProperties(properties);

            properties.Remove("AllowDrop");
            properties.Remove("AutoEllipsis");
            properties.Remove("AutoSize");
            properties.Remove("AutoSizeMode");
            properties.Remove("BackgroundImage");
            properties.Remove("BackgroundImageLayout");
            properties.Remove("FlatAppearance");
            properties.Remove("FlatStyle");
            properties.Remove("Image");
            properties.Remove("ImageAlign");
            properties.Remove("ImageIndex");
            properties.Remove("ImageKey");
            properties.Remove("ImageList");
            properties.Remove("TextAlign");
            properties.Remove("TextImageRelation");
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

            events.Remove("DragDrop");
            events.Remove("DragEnter");
            events.Remove("DragLeave");
            events.Remove("DragOver");
            events.Remove("GiveFeedback");
            events.Remove("QueryContinueDrag");
            events.Remove("AutoSizeChanged");
            events.Remove("BackgroundImageChanged");
            events.Remove("BackgroundImageLayoutChanged");
        }
        #endregion
    }
}


