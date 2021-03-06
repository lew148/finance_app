using System.Linq;
using finance_app.Models;

namespace finance_app.Services
{
    public class SettingsService
    {
        # region init

        private static SettingsService _instance;
        private static readonly object Padlock = new object();

        private SettingsService()
        {
        }

        public static SettingsService Instance
        {
            get
            {
                lock (Padlock)
                {
                    return _instance ??= new SettingsService();
                }
            }
        }

        # endregion

        public static Settings GetSettings(int id)
        {
            using var db = new FinanceAppContext();
            return db.Settings.Find(id);
        }

        public static void UpdateSettings(Settings settings)
        {
            using var db = new FinanceAppContext();
            db.Update(settings);
            db.SaveChanges();
        }

        public decimal GetSavingsPercentage()
        {
            using var db = new FinanceAppContext();
            var settings = db.Settings.FirstOrDefault();

            if (settings == null)
            {
                return 1;
            }
            
            return settings.SavingsPercentage;
        }
    }
}