/// <reference types="Cypress" />

import rgbHex from 'rgb-hex';

describe('Page Content Loads', () => {
    it('Finds the words "Professional Experience"', ()=>{
        cy.visit(Cypress.env('RESUME_PAGE'))
        cy.contains("Professional Experience")
    })

    it('Checks background colour', () => {
        cy.get('[id=col1]')
        .invoke('css', 'background-color')
        .then((bgcolor) => {
          expect(rgbHex(bgcolor)).to.eq('536979')
        })
      })
      
    it('Checks for Visitor Counter', {defaultCommandTimeout: 10000}, ()=>{
        cy.visit(Cypress.env('RESUME_PAGE'))
        //Checks vistor counter text displays
        cy.contains('You are visitor number')

        //Checks that visitor count is integer
        cy.get('[id=count]')
        .invoke('text')
        .should('match', /^[0-9]*$/)
    })

    it('Checks outbound links', () => {
        //Ignores weird 999 error from LinkedIn
        Cypress.on('fail', (error, runnable) => {
            if (!error.message.includes('999')) {
                throw error
            }
        })
        cy.visit(Cypress.env('RESUME_PAGE'))
        //Loops through all links except email
        cy.get("a:not([href*='mailto:'])").each(page => {
            cy.request(page.prop('href'));
        })
      
      });
})