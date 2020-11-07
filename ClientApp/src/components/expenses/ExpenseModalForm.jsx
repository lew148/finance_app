import React from 'react';
import Modal from 'react-modal';
import { Formik, Field, Form } from 'formik';
import Api from '../../Api';

const customStyles = {
    content: {
        top: '50%',
        left: '50%',
        right: 'auto',
        bottom: 'auto',
        marginRight: '-50%',
        transform: 'translate(-50%, -50%)'
    }
};

const defaultInitialValues = {
    name: '',
    cost: 0,
};

const ExpenseModalForm = ({ isOpen, onClose, isEdit = false, initialValues = defaultInitialValues }) => {
    Modal.setAppElement("body");

    const onFormSubmit = async (values) => {
        isEdit
            ? await Api.editExpense(values)
            : await Api.addExpense(values);
        onClose();
    };

    return (
        <Modal
            isOpen={isOpen}
            contentLabel="Example Modal"
            style={customStyles}
        >
            <Formik
                initialValues={initialValues}
                onSubmit={onFormSubmit}
            >
                <Form>
                    <div className="form-group">
                        <label htmlFor="name">Name</label>
                        <Field id="name" className="form-control" name="name" />
                    </div>

                    <div className="form-group">
                        <label htmlFor="cost">Cost</label>
                        <Field id="cost" name="cost" type="number" step="any" className="form-control" />
                    </div>

                    <div className="d-flex justify-content-between">
                        <button type="button" onClick={onClose} className="btn btn-danger">Close</button>
                        {
                            isEdit
                                ? <button type="submit" className="btn btn-info">Edit</button>
                                : <button type="submit" className="btn btn-success">Add</button>
                        }
                    </div>
                </Form>
            </Formik>
        </Modal>
    );
};

export default ExpenseModalForm;