// Includes the js file which I created during the evaluation.
let evaluationMethods = {
  tickbox: function () {
    $("ul li input:first").on("click", function () {
      $("input").not(this).prop("checked", this.checked);
      //   $("input").not(this).attr("checked", this.checked);
    });
  },

  myFunction: function () {
    $("#odd").on("click", function () {
      $("ul li:odd").addClass("yellow");

      $("ul li:even").removeClass("red");
    });

    $("#even").on("click", function () {
      $("ul li:even").addClass("red");

      $("ul li:odd").removeClass("yellow");
    });
  },

  buttonClick: function () {
    var items = 6;
    $("#myButton").on("click", function () {
      if (!this.done) {
        $("ul").after("<p>Data-value:<span></span></p>");
        this.done = true;
      }

      $("#addLi").append(
        "<li data-value=" + items + ">Item " + items + "</li>"
      );
      items++;
    });
  },

  liClick: function () {
    $("#addLi").on("click", "li", function (event) {
      //alternatives
      // $("p span").html($(this).attr("data-value"));
      // $("p span").html($(this).data("value"));
      console.log($(event.target));
      $("p span").html($(event.target).data("value"));
    });
  },
};
