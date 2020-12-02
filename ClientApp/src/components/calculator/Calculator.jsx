import React from 'react';
import { Formik, Field, Form } from 'formik';

const Calculator = () => {

    return (
        <div>
            <div className="d-flex justify-content-between align-items-center">
                <h1 className="p-2">Calculator</h1>
            </div>
            <Formik
                initialValues={{}}
                onSubmit={() => null}
            >
                <Form>
                    <div className="form-group">
                        <label htmlFor="amount">Amount</label>
                        <div class="input-group mb-2">
                            <div class="input-group-prepend">
                                <div class="input-group-text">£</div>
                            </div>
                            <Field id="amount" className="form-control" name="amount" />
                        </div>
                        <small id="amountHelp" class="form-text text-muted">
                            This could be your wage, salary or any amount of money you'd like to run calculations on.
                        </small>
                    </div>

                    <div className="form-group">
                        <label htmlFor="cost">Cost</label>
                        <Field id="cost" name="cost" type="number" step="any" className="form-control" />
                    </div>

                    <div className="d-flex justify-content-between">
                        <div/>
                        <button type="submit" className="btn btn-info">Calculate</button>
                    </div>
                </Form>
            </Formik>
        </div>
    );
}

export default Calculator;
