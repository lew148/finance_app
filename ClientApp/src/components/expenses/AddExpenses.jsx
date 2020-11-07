import React, { useState } from 'react';
import ExpenseModalForm from './ExpenseModalForm';

const AddExpenses = ({ handleOutOfDate }) => {
    const [modalOpen, setModalOpen] = useState(false);

    const onModalOpen = () => setModalOpen(true);

    const onModalClose = () => {
        setModalOpen(false);
        handleOutOfDate();
    };

    return (<>
        <button type="button" className="btn btn-success" style={{ maxHeight: "2.5rem" }} onClick={onModalOpen}>Add</button>
        <ExpenseModalForm
            isOpen={modalOpen}
            onClose={onModalClose}
        />
    </>);
};

export default AddExpenses;