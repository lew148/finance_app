import React from 'react';
import { Container } from 'reactstrap';
import NavMenu from './NavMenu.jsx';

const Layout = (props) => (
    <div>
        <NavMenu />
        <Container>
            {props.children}
        </Container>
    </div>
);

export default Layout;
