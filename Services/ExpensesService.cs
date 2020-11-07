using System.Collections.Generic;
using System.Linq;
using finance_app.Models;

namespace finance_app.Services
{
    public class ExpensesService
    {
        # region init
        
        private static ExpensesService _instance;
        private static readonly object Padlock = new object();

        private ExpensesService()
        {
        }

        public static ExpensesService Instance
        {
            get
            {
                lock (Padlock)
                {
                    return _instance ??= new ExpensesService();
                }
            }
        }
        
        # endregion

        public List<Expense> GetAllExpenses()
        {
            using var db = new FinanceAppContext();
            return db.Expenses.ToList();
        }

        public void AddExpense(Expense expense)
        {
            using var db = new FinanceAppContext();
            expense.Cost = decimal.Round(expense.Cost, 2);
            db.Expenses.Add(expense);
            db.SaveChanges();
        }

        public static void DeleteExpense(in int id)
        {
            using var db = new FinanceAppContext();
            var expense = db.Expenses.Find(id);
            db.Remove(expense);
            db.SaveChanges();
        }

        public static void EditExpense(Expense expense)
        {
            using var db = new FinanceAppContext();
            db.Update(expense);
            db.SaveChanges();
        }
    }
}