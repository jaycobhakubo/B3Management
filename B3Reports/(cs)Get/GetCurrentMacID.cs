
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Net.NetworkInformation;
using System.Net;

namespace GameTech.B3Reports
{
    class GetCurrentMacID
    {
        public static string MacAddress;
        public static string IpAddress;

        public  GetCurrentMacID()
        {
            var macAddr =
                (
                    from nic in NetworkInterface.GetAllNetworkInterfaces()
                    where nic.OperationalStatus == OperationalStatus.Up
                    select nic.GetPhysicalAddress().ToString()
                ).FirstOrDefault();

            MacAddress = macAddr.ToString();
            string hostname = Dns.GetHostName();
            IpAddress = Dns.GetHostByName(hostname).AddressList[0].ToString();
            
        }      
    }
}
