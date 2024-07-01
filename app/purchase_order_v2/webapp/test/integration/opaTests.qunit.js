sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'pankaj/purchaseorderv2/test/integration/FirstJourney',
		'pankaj/purchaseorderv2/test/integration/pages/POsList',
		'pankaj/purchaseorderv2/test/integration/pages/POsObjectPage',
		'pankaj/purchaseorderv2/test/integration/pages/POItemsObjectPage'
    ],
    function(JourneyRunner, opaJourney, POsList, POsObjectPage, POItemsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('pankaj/purchaseorderv2') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePOsList: POsList,
					onThePOsObjectPage: POsObjectPage,
					onThePOItemsObjectPage: POItemsObjectPage
                }
            },
            opaJourney.run
        );
    }
);