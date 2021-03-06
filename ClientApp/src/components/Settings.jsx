import React, {useEffect, useState} from 'react';
import {Field, Formik, Form} from "formik";
import Api from "../Api";

const Settings = () => {
    const [isEdit, setIsEdit] = useState(false);
    const [settings, setSettings] = useState(null)

    useEffect(() => {
        const getSettings = async () => {
            const response = await Api.getSettings(1);
            setSettings(response.data);
        };
        getSettings();
    }, []);

    const onFormSubmit = async (values) => {
        setIsEdit(false);
        await Api.updateSettings(values);
    };

    const toggleIsEdit = () => {
        setIsEdit(!isEdit);
    };

    return (settings == null ? <>Loading...</> : (
        <Formik
            initialValues={settings}
            onSubmit={onFormSubmit}
        >
            <Form>
                <h1 className="mb-3">Settings</h1>
                <div className="d-flex justify-content-start">
                    <label className="mr-3 align-self-center">Percentage to Save:</label>
                    <div className="input-group mb-2" style={{maxWidth: "10rem"}}>
                        <Field id="savingsPercentage" name="savingsPercentage" type="number" className="form-control" disabled={!isEdit}/>
                        <div className="input-group-append">
                            <div className="input-group-text">%</div>
                        </div>
                    </div>
                </div>

                {isEdit ? (
                        <div className="d-flex justify-content-between">
                            <button type="button" className="btn btn-danger" onClick={toggleIsEdit}>Cancel</button>
                            <button type="submit" className="btn btn-success">Save</button>
                        </div>
                    )
                    : (
                        <div className="d-flex justify-content-end">
                            <button type="button" className="btn btn-info" onClick={toggleIsEdit}>Edit</button>
                        </div>
                    )}
            </Form>
        </Formik>
    ));
}

export default Settings;