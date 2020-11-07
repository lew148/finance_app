import axios from 'axios';

export default {
    getExpenses: () => axios.get('/expenses/getAll'),
    addExpense: (request) => axios.post('/expenses/add', request),
    editExpense: (request) => axios.post('/expenses/edit', request),
    deleteExpense: (id) => axios.post(`/expenses/delete/${id}`),
};