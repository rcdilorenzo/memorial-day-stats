app = Elm.Main.fullscreen();

var save = function (model) {
  var json = JSON.stringify(model);
  localStorage.setItem('model', json);
};

app.ports.save.subscribe(save);

app.ports.location.subscribe(function(route) {
  if (route == '') {
    route = '#';
  }
  history.replaceState({}, "", route);
});

app.ports.confirm.subscribe(function(message) {
  var result = confirm(message);
  app.ports.confirmed.send(result);
});

var getStored = function() {
  var stored = JSON.parse(localStorage.getItem('model'));
  if (stored) {
    stored.route = location.hash;
    save(stored);
  }
  return stored;
};

window.onhashchange = function() {
  app.ports.storage.send(getStored());
};

setTimeout(window.onhashchange, 1);
