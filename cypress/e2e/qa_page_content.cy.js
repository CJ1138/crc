/// <reference types="Cypress" />

describe('Page Content Loads Correctly', () => {
    it('Finds the words "Professional Experience"', ()=>{
        cy.visit(Cypress.env('resume_site'))

        cy.contains("Professional Experience")
    })

    it('Checks the blog link', ()=>{
        cy.visit(Cypress.env('resume_site'))

        cy.contains('Technical Blog')//.click()

        //cy.contains('Recent Posts')
    })

    it('Checks for Visitor Counter', ()=>{
        cy.visit(Cypress.env('resume_site'))

        cy.contains('You are visitor number')

        cy.get('[id=count]')
        .invoke('text')
        .should('match', /^[0-9]*$/)
    })
})