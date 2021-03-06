using finance_app.Models;
using finance_app.Services;
using Microsoft.AspNetCore.Mvc;

namespace finance_app.Controllers
{
    [ApiController]
    [Route("settings")]
    public class SettingsController : ControllerBase
    {
        [HttpGet]
        [Route("get/{id}")]
        public Settings GetSettings(int id)
        {
            return SettingsService.GetSettings(id);
        }
        
        [HttpPost]
        [Route("update")]
        public void UpdateSettings(Settings settings)
        {
            SettingsService.UpdateSettings(settings);
        }

        [HttpGet]
        [Route("getSavings")]
        public decimal GetSavingsPercentage()
        {
            return SettingsService.Instance.GetSavingsPercentage();
        }
    }
}