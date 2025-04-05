try {
  let { classes: Cc, interfaces: Ci, manager: Cm  } = Components;
  const Services = globalThis.Services;
  function ConfigJS() { Services.obs.addObserver(this, 'chrome-document-global-created', false); }
  ConfigJS.prototype = {
    observe: function (aSubject) { aSubject.addEventListener('DOMContentLoaded', this, {once: true}); },
    handleEvent: function (aEvent) {
      let document = aEvent.originalTarget; let window = document.defaultView; let location = window.location;
      if (/^(chrome:(?!\/\/(global\/content\/commonDialog|browser\/content\/webext-panels)\.x?html)|about:(?!blank))/i.test(location.href)) {
        if (window.Tabbrowser) {
          // Place your keyboard shortcut changes here
          // remove Ctrl-Shift-X, so that I can map it to 1Password in the 1Password app later
          let keySwitchDirection = window.document.getElementById('key_switchTextDirection');
          keySwitchDirection.remove();


        }
      }
    }
  };
  if (!Services.appinfo.inSafeMode) { new ConfigJS(); }
} catch(ex) {};
