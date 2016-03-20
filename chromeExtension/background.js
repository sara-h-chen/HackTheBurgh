
var id = 100;

// Listen for a click on the icon. On that click, take a screenshot.
chrome.browserAction.onClicked.addListener(function() {

  chrome.tabs.captureVisibleTab(function(screenshotUrl) {
    var viewTabUrl = chrome.extension.getURL('screenshot.html?id=' + id++);
    var targetId = null;

    chrome.tabs.onUpdated.addListener(function listener(tabId, changedProps) {
      // We are waiting for the tab we opened to finish loading.
      // Check that the tab's id matches the tab we opened,
      // and that the tab is done loading.
      if (tabId != targetId || changedProps.status != "complete")
        return;

      /**
      chrome.tabs.insertCSS(tab.id, {
        file: "css/magnify.css"
      })
      **/

      // Passing the above test means this is the event we were waiting for.
      // There is nothing we need to do for future onUpdated events, so we
      // use removeListner to stop getting called when onUpdated events fire.
      chrome.tabs.onUpdated.removeListener(listener);

      // Look through all views to find the window which will display
      // the screenshot.  The url of the tab which will display the
      // screenshot includes a query parameter with a unique id, which
      // ensures that exactly one view will have the matching URL.
      var views = chrome.extension.getViews();
      for (var i = 0; i < views.length; i++) {
        var view = views[i];
        if (view.location.href == viewTabUrl) {
          view.setScreenshotUrl(screenshotUrl);
          break;
        }
      }
    });
    /**
    chrome.add.insertCSS(tab.id, {
      file: "css/magnify.css"
    })
    **/
    chrome.tabs.create({url: viewTabUrl}, function(tab) {
      targetId = tab.id;
      chrome.tabs.executeScript(null, {file: "magnifier.js"});
      //chrome.add.insertCSS(targetId, {
      //  file: "css/magnifier.css"
      //})
    });
  });
});
