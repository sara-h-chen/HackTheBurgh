window.onload = function(){
var evt = new Event()
m = new Magnifier(evt);
m.attach({
  thumb: document.getElementById('target'),
  large: 'chrome-extension://*/*',
  mode: 'inside',
  zoom: 3,
  zoomable: true
});
};
