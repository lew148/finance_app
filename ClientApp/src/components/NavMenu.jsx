import React from 'react';
import { Container, Navbar, NavbarBrand, NavLink } from 'reactstrap';
import { Link } from 'react-router-dom';

const NavMenu = () => (
    <header>
        <Navbar className="navbar-expand-sm ng-white border-bottom box-shadow mb-3" light>
            <Container>
                <NavbarBrand tag={Link} to="/">Finance App</NavbarBrand>
                <ul className="navbar-nav flex-grow">
                        <NavLink tag={Link} className="text-dark" to="/">Calculator</NavLink>
                        <NavLink tag={Link} className="text-dark" to="/expenses">Expenses</NavLink>
                </ul>
            </Container>
        </Navbar>
    </header>
);

export default NavMenu;
