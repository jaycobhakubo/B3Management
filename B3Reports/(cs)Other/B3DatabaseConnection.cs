using System.Text;
using Microsoft.Win32;

namespace GameTech.B3Reports._cs_Other
{
    public class B3DatabaseConnection
    {
        //keep local copy of values to prevent fetching values from 
        //register everytime we was to use the connection string
        private static string m_serverName;
        private static string m_databaseName;
        private static string m_databaseUser;
        private static string m_databasePassword;

        private const string Key = "!@a812e226ef95#";
        private const string RegistryPath = "HKEY_USERS\\.DEFAULT\\Software\\Gametech International\\B3";

        public const string ConnectionStringTemplate = "Data Source={0}; Initial Catalog={1};Persist Security Info=True;User ID={2};Password=\"{3}\"";

        public static string GetServerNameFromRegistry()
        {
            if (!string.IsNullOrEmpty(m_serverName))
            {
                return m_serverName;
            }

            //load values from registry
            m_serverName = (string)Registry.GetValue(RegistryPath, "server name", string.Empty);

            //set default values if they do not exist
            if (string.IsNullOrEmpty(m_serverName))
            {
                m_serverName = "B3-Server";
                Registry.SetValue(RegistryPath, "server name", m_serverName);
            }

            return m_serverName;
        }

        public static string GetDatabaseNameFromRegistry()
        {
            if (!string.IsNullOrEmpty(m_databaseName))
            {
                return m_databaseName;
            }

            //load values from registry
            m_databaseName = (string)Registry.GetValue(RegistryPath, "database name", string.Empty);

            if (string.IsNullOrEmpty(m_databaseName))
            {
                m_databaseName = "B3";
                Registry.SetValue(RegistryPath, "database name", m_databaseName);
            }

            return m_databaseName;
        }

        public static string GetDatabaseUserFromRegistry()
        {
            if (!string.IsNullOrEmpty(m_databaseUser))
            {
                return m_databaseUser;
            }
            //load values from registry
            m_databaseUser = (string)Registry.GetValue(RegistryPath, "database user", string.Empty);

            if (string.IsNullOrEmpty(m_databaseUser))
            {
                m_databaseUser = "sqluser";
                Registry.SetValue(RegistryPath, "database user", m_databaseUser);
            }

            return m_databaseUser;
        }

        public static string GetDatabasePasswordRegistry()
        {
            if (!string.IsNullOrEmpty(m_databasePassword))
            {
                return m_databasePassword;
            }

            //load values from registry
            m_databasePassword = Obfuscate((string)Registry.GetValue(RegistryPath, "database password", string.Empty));

            //set default
            if (string.IsNullOrEmpty(m_databasePassword))
            {
                m_databasePassword = "gly*cine83";
                Registry.SetValue(RegistryPath, "database password", Obfuscate(m_databasePassword));
            }

            return m_databasePassword;
        }

        public static string Obfuscate(string input)
        {
            var sb = new StringBuilder();
            for (int i = 0; i < input.Length; i++)
            {
                sb.Append((char)(input[i] ^ Key[(i % Key.Length)]));
            }
            var result = sb.ToString();

            return result;
        }

        public static string GetConnectionString
        {
            get
            {
                return string.Format(ConnectionStringTemplate,
                    GetServerNameFromRegistry(),
                    GetDatabaseNameFromRegistry(),
                    GetDatabaseUserFromRegistry(),
                    GetDatabasePasswordRegistry());
            }
        }

        public static void SaveCredentials(string serverName, string databaseName, string databaseUser, string databasePassword)
        {
            //save values to registry
            Registry.SetValue(RegistryPath, "server name", serverName);
            Registry.SetValue(RegistryPath, "database name", databaseName);
            Registry.SetValue(RegistryPath, "database user", databaseUser);
            Registry.SetValue(RegistryPath, "database password", Obfuscate(databasePassword));

            //update values
            m_serverName = serverName;
            m_databaseName = databaseName;
            m_databaseUser = databaseUser;
            m_databasePassword = databasePassword;
        }
    }
}
