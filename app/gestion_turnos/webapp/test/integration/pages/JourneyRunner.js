sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"project1/test/integration/pages/TurnosList",
	"project1/test/integration/pages/TurnosObjectPage"
], function (JourneyRunner, TurnosList, TurnosObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('project1') + '/test/flp.html#app-preview',
        pages: {
			onTheTurnosList: TurnosList,
			onTheTurnosObjectPage: TurnosObjectPage
        },
        async: true
    });

    return runner;
});

