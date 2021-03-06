import React, {useState, useEffect} from 'react';
import Api from '../../Api';
import AddExpenses from './AddExpenses';
import EditExpenses from './EditExpenses';

const Expenses = () => {
    const [outOfDate, setOutOfDate] = useState(true);
    const [expenses, setExpenses] = useState([]);
    const [expensesTotal, setExpensesTotal] = useState(null);

    useEffect(() => {
        const getExpenses = async () => {
            if (outOfDate) {
                const expensesResponse = await Api.getExpenses();
                const expensesTotalResponse = await Api.getExpensesTotal();
                console.log(expensesTotalResponse.data)

                setExpenses(expensesResponse.data);
                setExpensesTotal(expensesTotalResponse.data)
                setOutOfDate(false);
            }
        };
        getExpenses();
    }, [outOfDate]);

    const handleOutOfDate = () => {
        setOutOfDate(true);
    }

    const handleDeleteClick = (id, name) => async () => {
        // eslint-disable-next-line no-restricted-globals
        if (confirm(`Are you sure you want to delete ${name}?`)) {
            await Api.deleteExpense(id);
            handleOutOfDate();
        }
    };

    return (outOfDate
            ? <div>Loading...</div>
            : (<>
                <div className="d-flex justify-content-between align-items-center">
                    <h1 className="p-2">Expenses</h1>
                    <AddExpenses handleOutOfDate={handleOutOfDate}/>
                </div>
                <div className="d-flex">
                    <h5 className="p-2">Total:</h5>
                    {expensesTotal !== null && (
                        <h5
                            className="p-2 text-danger font-weight-bold"
                            style={{
                                border: "2px solid black", borderRadius: "5px", backgroundColor: "lightgrey"
                            }}
                        >
                            £{expensesTotal.toFixed(2)}
                        </h5>
                    )}
                </div>
                <div className="d-flex flex-wrap" style={{padding: "1rem"}}>
                    {
                        expenses.length !== 0
                            ? (expenses.map(e => (
                                <div key={e.id} className="card" style={{width: "10rem", margin: "0.5rem"}}>
                                    <div className="card-body">
                                        <div className="d-flex justify-content-between">
                                            <div>
                                                <h5 className="card-title">{e.name}</h5>
                                                <p className="card-text">£{e.cost.toFixed(2)}</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div className="d-flex justify-content-between" style={{padding: "8px"}}>
                                        <button type="button" onClick={handleDeleteClick(e.id, e.name)}
                                                className="btn btn-danger">Delete
                                        </button>
                                        <EditExpenses
                                            expense={e}
                                            handleOutOfDate={handleOutOfDate}
                                        />
                                    </div>
                                </div>
                            )))
                            : <div>You have no expenses</div>
                    }
                </div>
            </>)
    );
};

export default Expenses;