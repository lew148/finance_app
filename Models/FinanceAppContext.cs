using Microsoft.EntityFrameworkCore;

namespace finance_app.Models
{
    public class FinanceAppContext : DbContext
    {
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer(System.IO.File.ReadAllLines(@".\ConnectionString.txt")[0]);
        }

        public DbSet<Expense> Expenses { get; set; }
        public DbSet<Settings> Settings { get; set; }
    }
}