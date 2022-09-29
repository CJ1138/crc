/// <reference types="Cypress" />

describe('Page Content Loads Correctly', () => {
    it('Finds the words "Professional Experience"', ()=>{
        cy.visit('https://chrisjohnson.tech')

        cy.contains("Professional Experience")
    })

    it('Checks the blog link', ()=>{
        cy.visit('https://chrisjohnson.tech')

        cy.contains('Technical Blog').click()

        cy.contains('Recent Posts')
    })
})