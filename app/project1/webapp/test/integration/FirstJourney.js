sap.ui.define([
    "sap/ui/test/opaQunit",
    "./pages/JourneyRunner"
], function (opaTest, runner) {
    "use strict";

    function journey() {
        QUnit.module("First journey");

        opaTest("Start application", function (Given, When, Then) {
            Given.iStartMyApp();

            Then.onTheTurnosList.iSeeThisPage();
            Then.onTheTurnosList.onTable().iCheckColumns(6, {"idTurno":{"header":"ID Turno"},"fechaHora":{"header":"Fecha y Hora"},"motivo":{"header":"Motivo"},"estado":{"header":"Estado"},"doctor/apellido":{"header":"Doctor"},"paciente/apellido":{"header":"Paciente"}});

        });


        opaTest("Navigate to ObjectPage", function (Given, When, Then) {
            // Note: this test will fail if the ListReport page doesn't show any data
            
            When.onTheTurnosList.onFilterBar().iExecuteSearch();
            
            Then.onTheTurnosList.onTable().iCheckRows();

            When.onTheTurnosList.onTable().iPressRow(0);
            Then.onTheTurnosObjectPage.iSeeThisPage();

        });

        opaTest("Teardown", function (Given, When, Then) { 
            // Cleanup
            Given.iTearDownMyApp();
        });
    }

    runner.run([journey]);
});