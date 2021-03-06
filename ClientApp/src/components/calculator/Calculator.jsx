import React, {useEffect, useState} from 'react';
import {Form, Formik} from 'formik';
import Api from "../../Api";
import CalcStep1 from "./CalcStep1";
import CalcStep2 from "./CalcStep2";

const Calculator = () => {
    const [expensesTotal, setExpensesTotal] = useState(null)
    const [step, setStep] = useState(1);

    useEffect(() => {
        const getExpensesTotal = async () => {
            const response = await Api.getExpensesTotal();
            setExpensesTotal(response.data);
        };
        getExpensesTotal();
    }, []);

    const onNextButtonClick = () => {
        setStep(step + 1);
    }
    const onBackButtonClick = () => {
        setStep(step - 1);
    }

    const getCalcStep = (values, setFieldValue) => {
        if (step === 1) {
            return <CalcStep1 expensesTotal={expensesTotal}/>
        }

        if (step === 2) {
            return <CalcStep2 values={values} setFieldValue={setFieldValue} expensesTotal={expensesTotal}/>
        }

        return <div>Oops! How's this happened?</div>
    };

    const CalcForm = ({values, setFieldValue}) => (
        <Form>
            <div className="d-flex justify-content-center">
                <div>
                    <div style={{
                        border: "1.25px solid black",
                        borderRadius: "10px",
                        maxWidth: "fit-content"
                    }}>
                        <div className="d-flex justify-content-center">
                            <div className="align-self-center">
                                <h1>Calculator</h1>
                            </div>
                        </div>
 
                        <hr/>

                        <div className="m-3" style={{minWidth: "max-content"}}>
                            {expensesTotal && getCalcStep(values, setFieldValue)}
                        </div>

                        <hr/>

                        <div className="d-flex justify-content-end">
                            <div className="m-3">
                                {step === 1 ? (
                                    <button type="button" onClick={onNextButtonClick}
                                            className="btn btn-info">Next</button>
                                ) : (<>
                                    <button type="button" onClick={onBackButtonClick}
                                            className="btn btn-danger mr-3">Back
                                    </button>
                                    <button type="submit" className="btn btn-success">Finish</button>
                                </>)}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </Form>
    );

    return (
        <div>
            <Formik
                initialValues={{}}
                onSubmit={(results) => console.log(results)}
                component={CalcForm}
            />
        </div>
    );
}

export default Calculator;
