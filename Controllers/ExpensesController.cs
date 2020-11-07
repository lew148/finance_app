using System.Collections.Generic;
using finance_app.Models;
using finance_app.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace finance_app.Controllers
{
    [ApiController]
    [Route("expenses")]
    public class ExpensesController : ControllerBase
    {
        private readonly ILogger<ExpensesController> _logger;

        public ExpensesController(ILogger<ExpensesController> logger)
        {
            _logger = logger;
        }

        [HttpGet]
        [Route("getAll")]
        public List<Expense> GetAll()
        {
            return ExpensesService.Instance.GetAllExpenses();
        }
        
        [HttpPost]
        [Route("add")]
        public void Add(Expense expense)
        {
            ExpensesService.Instance.AddExpense(expense);
        }

        [HttpPost]
        [Route("delete/{id}")]
        public void Delete(int id)
        {
            ExpensesService.DeleteExpense(id);
        }
        
        [HttpPost]
        [Route("edit")]
        public void Edit(Expense expense)
        {
            ExpensesService.EditExpense(expense);
        }
    }
}