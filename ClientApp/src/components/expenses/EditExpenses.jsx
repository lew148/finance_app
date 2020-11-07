import React, { useState } from 'react';
import ExpenseModalForm from './ExpenseModalForm';

const EditExpenses = ({ expense, handleOutOfDate }) => {
    const [modalOpen, setModalOpen] = useState(false);

    const onModalOpen = () => setModalOpen(true);

    const onModalClose = () => {
        setModalOpen(false);
        handleOutOfDate();
    };

    return (<>
        <button type="button" className="btn btn-info" onClick={onModalOpen}>Edit</button>
        <ExpenseModalForm
            isOpen={modalOpen}
            onClose={onModalClose}
            isEdit
            initialValues={expense}
        />
    </>);
};

export default EditExpenses;