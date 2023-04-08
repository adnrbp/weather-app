document.addEventListener("turbolinks:load", function() {

  $input = $('*[data-behavior="autocomplete"]')


  var options = {
    url: function(phrase) {
      return "/cities/search.json?q=" + phrase;
    },
    getValue: "city_iata",
    template: {
      type: "description",
      fields: {
        description: "country"
      }
    },
    list: {
      maxNumberOfElements: 10,
    }
  };
  
  $input.easyAutocomplete(options);
});