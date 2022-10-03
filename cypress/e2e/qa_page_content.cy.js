/// <reference types="Cypress" />

describe('Page Content Loads Correctly', () => {
    it('Finds the words "Professional Experience"', ()=>{
        cy.visit('gs://crc-test-bucket')

        cy.contains("Professional Experience")
    })

    it('Checks the blog link', ()=>{
        cy.visit('gs://crc-test-bucket')

        cy.contains('Technical Blog')//.click()

        //cy.contains('Recent Posts')
    })

    it('Checks for Visitor Counter', ()=>{
        cy.visit('gs://crc-test-bucket')

        cy.contains('You are visitor number')

        cy.get('[id=count]')
        .invoke('text')
        .should('match', /^[0-9]*$/)
    })
})