let CheckSelected = {
  buttonCheck: function () {
    $("#main").on("click", "#checkButton", function () {
      //for only even elements
      //   $("input:even").each(function () {
      //     this.checked = !this.checked;
      //   });

      var arr = [1, 3, 4];
      //filtering based on the given array
      $("input").filter(function (index) {
        for (let i = 0; i < arr.length; i++) {
          if (index == arr[i]) {
            this.checked = !this.checked;
          }
        }
      });
    });
  },

  buttonGetCheck: function () {
    $("#main").on("click", "#getCheck", function () {
      var text = "";
      $("input[type='checkbox']").each(function () {
        if (this.checked == true) {
          text = text.concat(this.name, " ");
        }
      });
      $("#items").html(text);
    });
  },

  highlightRow: function () {
    $("input[type='checkbox']").eq(1).css("background", "red");
  },
};
