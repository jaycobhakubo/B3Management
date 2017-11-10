#region Copyright
// This is an unpublished work protected under the copyright laws of the
// United States and other countries.  All rights reserved.  Should
// publication occur the following will apply:  © 2008 GameTech
// International, Inc.
#endregion

using System;
using System.Drawing;
using System.Drawing.Imaging;

namespace GameTech.B3Reports.Forms
{
    /// <summary>
    /// Helps dynamically size images.
    /// </summary>
    public class ImageHelper
    {
        /// <summary>
        /// This function dynamically resizes a specified image to prevent 
        /// stretch of the corners.
        /// </summary>
        /// <param name="cornerSize">The size of the corners that should 
        /// not be stretched.</param>
        /// <param name="backColor">The background color the image should be 
        /// filled with before stretching. If the color is set to 
        /// Color.Transparent, then no background color is used.</param>
        /// <param name="sourceImage">The source image that is 
        /// to be resized.</param>
        /// <param name="targetSize">The desired size of the new image.</param>
        /// <returns>The dynamically resized image or null if invalid parameters 
        /// were passed.</returns>
        public static Image ResizeImage(int cornerSize, Color backColor, Image sourceImage, Size targetSize)
        {
            if (sourceImage == null || cornerSize < 1 || targetSize.IsEmpty)
                return null;

            // Create the target image.
            Bitmap target = new Bitmap(targetSize.Width, targetSize.Height);

            // Create rectangle for target image. Always starting at the 
            // top left corner.
            Rectangle destRect = new Rectangle(0, 0, cornerSize, cornerSize);

            // Create rectangle for source image.
            Rectangle srcRect = new Rectangle(0, 0, cornerSize, cornerSize);

            // Get the drawing surface.
            Graphics g = Graphics.FromImage(target);

            // Fill the surface with the specified back color.
            if (backColor != Color.Transparent)
                g.FillRectangle(new SolidBrush(backColor), new Rectangle(0, 0, targetSize.Width, targetSize.Height));

            // Loop the 9 sections of the image to paint the graphics.
            for (int i = 1; i < 10; i++)
            {
                switch (i)
                {
                    #region Upper Row
                    case 1: // Upper Left
                        srcRect.X = 0;
                        srcRect.Y = 0;
                        // Dest
                        destRect.X = 0;
                        destRect.Width = cornerSize;
                        destRect.Y = 0;
                        destRect.Height = cornerSize;
                        break;
                    case 2: // Upper Center
                        // Source
                        srcRect.X = cornerSize;
                        srcRect.Y = 0;
                        // Dest
                        destRect.X = cornerSize;
                        destRect.Width = targetSize.Width - (cornerSize * 2);
                        destRect.Y = 0;
                        destRect.Height = cornerSize;
                        break;
                    case 3: // Upper Right
                        // Source
                        srcRect.X = (cornerSize * 2);
                        srcRect.Y = 0;
                        // Dest
                        destRect.X = targetSize.Width - cornerSize;
                        destRect.Width = cornerSize;
                        destRect.Y = 0;
                        destRect.Height = cornerSize;
                        break;
                    #endregion
                    #region Middle Row
                    case 4: // Center Left
                        // Source
                        srcRect.Y = cornerSize;
                        srcRect.X = 0;
                        // Dest
                        destRect.X = 0;
                        destRect.Width = cornerSize;
                        destRect.Y = cornerSize;
                        destRect.Height = targetSize.Height - (cornerSize * 2);
                        break;
                    case 5: // Center Center
                        // Source
                        srcRect.Y = cornerSize;
                        srcRect.X = cornerSize;
                        // Dest
                        destRect.X = cornerSize;
                        destRect.Width = targetSize.Width - (cornerSize * 2);
                        destRect.Y = cornerSize;
                        destRect.Height = targetSize.Height - (cornerSize * 2);
                        break;
                    case 6: // Center Right
                        // Source
                        srcRect.X = (cornerSize * 2);
                        srcRect.Y = cornerSize;
                        // Dest
                        destRect.X = targetSize.Width - cornerSize;
                        destRect.Width = cornerSize;
                        destRect.Y = cornerSize;
                        destRect.Height = targetSize.Height - (cornerSize * 2);
                        break;
                    #endregion
                    #region Bottom Row
                    case 7: // Bottom Left
                        // Source
                        srcRect.X = 0;
                        srcRect.Y = (cornerSize * 2);
                        // Dest
                        destRect.X = 0;
                        destRect.Width = cornerSize;
                        destRect.Y = targetSize.Height - cornerSize;
                        destRect.Height = cornerSize;
                        break;
                    case 8: // Bottom Center
                        // Source
                        srcRect.Y = (cornerSize * 2);
                        srcRect.X = cornerSize;
                        // Dest
                        destRect.X = cornerSize;
                        destRect.Width = targetSize.Width - (cornerSize * 2);
                        destRect.Y = targetSize.Height - cornerSize;
                        destRect.Height = cornerSize;
                        break;
                    case 9: //Bottom Right
                        // Source
                        srcRect.Y = (cornerSize * 2);
                        srcRect.X = (cornerSize * 2);
                        // Dest
                        destRect.X = targetSize.Width - cornerSize;
                        destRect.Width = cornerSize;
                        destRect.Y = targetSize.Height - cornerSize;
                        destRect.Height = cornerSize;
                        break;
                    #endregion
                }

                g.DrawImage(sourceImage, destRect, srcRect, GraphicsUnit.Pixel);
            }

            g.Dispose();
            g = null;

            return target;
        }
    }
}
