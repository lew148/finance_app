import axios from 'axios';

export default {
    getExpenses: () => axios.get('/expenses/getAll'),
    addExpense: (request) => axios.post('/expenses/add', request),
    editExpense: (request) => axios.post('/expenses/edit', request),
    deleteExpense: (id) => axios.post(`/expenses/delete/${id}`),
    getExpensesTotal: () => axios.get('/expenses/total'),
    getSettings: (id) => axios.get(`/settings/get/${id}`),
    updateSettings: (request) => axios.post('/settings/update', request),
    getSavingsPercentage: () => axios.get(`/settings/getSavings/`),
};