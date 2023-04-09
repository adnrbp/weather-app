document.addEventListener("turbolinks:load", function() {

  $input = $('*[data-behavior="autocomplete"]')
  $input.keydown(function() {
    $('.search-result').css("z-index", "-1");
  })


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
      onClickEvent: function() {
        $('.search-button').trigger("click");

      }
    }
  };
  
  $input.easyAutocomplete(options);
});